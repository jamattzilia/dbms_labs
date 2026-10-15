-- =====================================================================
--  University database (individual work) - Lab Works 4 and 5
--  Student: Doe John, group SISCCO-2502NS
--  DBMS: PostgreSQL
--
--  How to run:
--    psql:    psql -U postgres -f university_lw4_lw5.sql
--    pgAdmin: run Lab Work 4 / Task 1 (CREATE DATABASE) on its own, then
--             open a Query Tool on the new "university" database and run
--             the rest of the script, skipping the \c line.
-- =====================================================================


-- =====================================================================
-- Lab Work 4
-- Physical Design (SQL, DDL)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Task 1. Create the University database
-- ---------------------------------------------------------------------
CREATE DATABASE university;

\c university


-- ---------------------------------------------------------------------
-- Task 2. Create all tables (11 tables, 3NF, from the Lab work 3 model)
--  Tables are created in dependency order: a table is created only
--  after every table its foreign keys point to.
-- ---------------------------------------------------------------------

-- 1. Faculties
CREATE TABLE faculties (
    faculty_id  SERIAL       PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    building    VARCHAR(50)  NOT NULL,
    phone       VARCHAR(20),
    CONSTRAINT uq_faculties_name UNIQUE (name)
);

-- 2. Departments
CREATE TABLE departments (
    department_id SERIAL       PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    phone         VARCHAR(20),
    faculty_id    INTEGER      NOT NULL,
    CONSTRAINT fk_departments_faculty FOREIGN KEY (faculty_id)
        REFERENCES faculties (faculty_id),
    CONSTRAINT uq_departments_faculty_name UNIQUE (faculty_id, name)
);

-- 3. Teachers
CREATE TABLE teachers (
    teacher_id      SERIAL       PRIMARY KEY,
    last_name       VARCHAR(50)  NOT NULL,
    first_name      VARCHAR(50)  NOT NULL,
    position        VARCHAR(30)  NOT NULL,
    academic_degree VARCHAR(30),
    email           VARCHAR(100) NOT NULL,
    phone           VARCHAR(20),
    hire_date       DATE         NOT NULL,
    department_id   INTEGER      NOT NULL,
    CONSTRAINT fk_teachers_department FOREIGN KEY (department_id)
        REFERENCES departments (department_id),
    CONSTRAINT uq_teachers_email UNIQUE (email),
    CONSTRAINT ck_teachers_position CHECK (position IN
        ('Assistant', 'Senior Lecturer', 'Associate Professor', 'Professor')),
    CONSTRAINT ck_teachers_degree CHECK (academic_degree IN
        ('Master', 'PhD', 'Doctor of Sciences'))
);

-- 4. Groups (study groups); curator_id is UNIQUE -> 1:1 with Teachers
CREATE TABLE groups (
    group_id       SERIAL      PRIMARY KEY,
    name           VARCHAR(20) NOT NULL,
    admission_year SMALLINT    NOT NULL,
    faculty_id     INTEGER     NOT NULL,
    curator_id     INTEGER     NOT NULL,
    CONSTRAINT fk_groups_faculty FOREIGN KEY (faculty_id)
        REFERENCES faculties (faculty_id),
    CONSTRAINT fk_groups_curator FOREIGN KEY (curator_id)
        REFERENCES teachers (teacher_id),
    CONSTRAINT uq_groups_name UNIQUE (name),
    CONSTRAINT uq_groups_curator UNIQUE (curator_id),
    CONSTRAINT ck_groups_admission_year CHECK (admission_year BETWEEN 2000 AND 2100)
);

-- 5. Students
CREATE TABLE students (
    student_id      SERIAL       PRIMARY KEY,
    last_name       VARCHAR(50)  NOT NULL,
    first_name      VARCHAR(50)  NOT NULL,
    date_of_birth   DATE         NOT NULL,
    email           VARCHAR(100),
    phone           VARCHAR(20),
    enrollment_date DATE         NOT NULL,
    has_scholarship BOOLEAN      NOT NULL DEFAULT FALSE,
    group_id        INTEGER      NOT NULL,
    CONSTRAINT fk_students_group FOREIGN KEY (group_id)
        REFERENCES groups (group_id),
    CONSTRAINT uq_students_email UNIQUE (email),
    CONSTRAINT ck_students_dob CHECK (date_of_birth > DATE '1980-01-01'),
    CONSTRAINT ck_students_enrollment CHECK (enrollment_date > date_of_birth)
);

-- 6. Courses
CREATE TABLE courses (
    course_id     SERIAL       PRIMARY KEY,
    code          VARCHAR(10)  NOT NULL,
    title         VARCHAR(100) NOT NULL,
    credits       SMALLINT     NOT NULL,
    department_id INTEGER      NOT NULL,
    CONSTRAINT fk_courses_department FOREIGN KEY (department_id)
        REFERENCES departments (department_id),
    CONSTRAINT uq_courses_code UNIQUE (code),
    CONSTRAINT ck_courses_credits CHECK (credits BETWEEN 1 AND 10)
);

-- 7. Semesters
CREATE TABLE semesters (
    semester_id   SERIAL     PRIMARY KEY,
    academic_year VARCHAR(9) NOT NULL,
    term          VARCHAR(6) NOT NULL,
    start_date    DATE       NOT NULL,
    end_date      DATE       NOT NULL,
    CONSTRAINT uq_semesters_year_term UNIQUE (academic_year, term),
    CONSTRAINT ck_semesters_year CHECK (academic_year ~ '^[0-9]{4}-[0-9]{4}$'),
    CONSTRAINT ck_semesters_term CHECK (term IN ('Fall', 'Spring', 'Summer')),
    CONSTRAINT ck_semesters_dates CHECK (end_date > start_date)
);

-- 8. Classrooms
CREATE TABLE classrooms (
    classroom_id SERIAL      PRIMARY KEY,
    building     VARCHAR(50) NOT NULL,
    room_number  VARCHAR(10) NOT NULL,
    capacity     SMALLINT    NOT NULL,
    room_type    VARCHAR(20) NOT NULL,
    CONSTRAINT uq_classrooms_room UNIQUE (building, room_number),
    CONSTRAINT ck_classrooms_capacity CHECK (capacity > 0),
    CONSTRAINT ck_classrooms_type CHECK (room_type IN
        ('Lecture hall', 'Computer lab', 'Seminar room', 'Laboratory'))
);

-- 9. Course_Teachers (resolves Teachers M:N Courses)
CREATE TABLE course_teachers (
    teacher_id     INTEGER NOT NULL,
    course_id      INTEGER NOT NULL,
    assigned_since DATE    NOT NULL,
    CONSTRAINT pk_course_teachers PRIMARY KEY (teacher_id, course_id),
    CONSTRAINT fk_course_teachers_teacher FOREIGN KEY (teacher_id)
        REFERENCES teachers (teacher_id),
    CONSTRAINT fk_course_teachers_course FOREIGN KEY (course_id)
        REFERENCES courses (course_id)
);

-- 10. Enrollments (resolves Students M:N Courses)
CREATE TABLE enrollments (
    enrollment_id SERIAL   PRIMARY KEY,
    student_id    INTEGER  NOT NULL,
    course_id     INTEGER  NOT NULL,
    semester_id   INTEGER  NOT NULL,
    grade         SMALLINT,
    CONSTRAINT fk_enrollments_student FOREIGN KEY (student_id)
        REFERENCES students (student_id),
    CONSTRAINT fk_enrollments_course FOREIGN KEY (course_id)
        REFERENCES courses (course_id),
    CONSTRAINT fk_enrollments_semester FOREIGN KEY (semester_id)
        REFERENCES semesters (semester_id),
    CONSTRAINT uq_enrollments_once UNIQUE (student_id, course_id, semester_id),
    CONSTRAINT ck_enrollments_grade CHECK (grade BETWEEN 0 AND 100)
);

-- 11. Schedule (weekly timetable). The (teacher_id, course_id) pair must
--     exist in course_teachers, so a teacher can only be scheduled for a
--     course they actually teach.
CREATE TABLE schedule (
    lesson_id     SERIAL      PRIMARY KEY,
    semester_id   INTEGER     NOT NULL,
    group_id      INTEGER     NOT NULL,
    teacher_id    INTEGER     NOT NULL,
    course_id     INTEGER     NOT NULL,
    classroom_id  INTEGER     NOT NULL,
    day_of_week   SMALLINT    NOT NULL,
    lesson_number SMALLINT    NOT NULL,
    lesson_type   VARCHAR(10) NOT NULL,
    CONSTRAINT fk_schedule_semester FOREIGN KEY (semester_id)
        REFERENCES semesters (semester_id),
    CONSTRAINT fk_schedule_group FOREIGN KEY (group_id)
        REFERENCES groups (group_id),
    CONSTRAINT fk_schedule_course_teacher FOREIGN KEY (teacher_id, course_id)
        REFERENCES course_teachers (teacher_id, course_id),
    CONSTRAINT fk_schedule_classroom FOREIGN KEY (classroom_id)
        REFERENCES classrooms (classroom_id),
    CONSTRAINT uq_schedule_group_slot
        UNIQUE (semester_id, group_id, day_of_week, lesson_number),
    CONSTRAINT ck_schedule_day CHECK (day_of_week BETWEEN 1 AND 6),
    CONSTRAINT ck_schedule_lesson_number CHECK (lesson_number BETWEEN 1 AND 7),
    CONSTRAINT ck_schedule_type CHECK (lesson_type IN ('Lecture', 'Practice', 'Lab'))
);


-- ---------------------------------------------------------------------
-- Task 3. Create a test table and change it with ALTER TABLE
-- ---------------------------------------------------------------------
CREATE TABLE test_table (
    id      SERIAL PRIMARY KEY,
    comment VARCHAR(50)
);

-- add a new column
ALTER TABLE test_table ADD COLUMN created_on DATE;

-- rename a column
ALTER TABLE test_table RENAME COLUMN comment TO note;

-- change the type of a column
ALTER TABLE test_table ALTER COLUMN note TYPE VARCHAR(200);

-- make a column required and give it a default value
ALTER TABLE test_table ALTER COLUMN created_on SET DEFAULT CURRENT_DATE;
ALTER TABLE test_table ALTER COLUMN created_on SET NOT NULL;

-- add a CHECK constraint
ALTER TABLE test_table ADD CONSTRAINT ck_test_note_not_empty CHECK (note <> '');

-- rename the table itself
ALTER TABLE test_table RENAME TO test_table_renamed;


-- ---------------------------------------------------------------------
-- Task 4. Drop the test table
-- ---------------------------------------------------------------------
DROP TABLE test_table_renamed;


-- =====================================================================
-- Lab Work 5
-- Content (SQL, DML): INSERT, UPDATE, DELETE
-- =====================================================================
-- The database is created fresh by Lab Work 4, so the SERIAL keys are
-- assigned 1, 2, 3, ... in the order of the rows below; the foreign keys
-- in later INSERTs refer to those numbers.


-- ---------------------------------------------------------------------
-- Task 1. Add at least 3 rows to each table (INSERT)
-- Parent tables are filled before the tables that reference them.
-- ---------------------------------------------------------------------

-- Faculties: 1 = IT, 2 = Business and Economics, 3 = Engineering
INSERT INTO faculties (name, building, phone) VALUES
    ('Faculty of Information Technology', 'Main building', '+7 727 300 1001'),
    ('Faculty of Business and Economics', 'Building B',    '+7 727 300 2002'),
    ('Faculty of Engineering',            'Building C',    '+7 727 300 3003');

-- Departments: 1 = Computer Engineering, 2 = Information Systems,
--              3 = Economics, 4 = Electrical Engineering
INSERT INTO departments (name, phone, faculty_id) VALUES
    ('Department of Computer Engineering',   '+7 727 300 1101', 1),
    ('Department of Information Systems',    '+7 727 300 1102', 1),
    ('Department of Economics',              '+7 727 300 2101', 2),
    ('Department of Electrical Engineering', '+7 727 300 3101', 3);

-- Teachers: 1 Smith, 2 Brown, 3 Kim, 4 Akhmetov, 5 Lee, 6 Nurlanova
INSERT INTO teachers (last_name, first_name, position, academic_degree, email, phone, hire_date, department_id) VALUES
    ('Smith',     'Anna',    'Associate Professor', 'PhD',                'a.smith@uni.edu.kz',     '+7 701 111 2233', '2015-09-01', 1),
    ('Brown',     'Mark',    'Senior Lecturer',     'Master',             'm.brown@uni.edu.kz',     '+7 701 222 3344', '2019-09-01', 1),
    ('Kim',       'Elena',   'Professor',           'Doctor of Sciences', 'e.kim@uni.edu.kz',       '+7 701 333 4455', '2008-02-01', 2),
    ('Akhmetov',  'Timur',   'Senior Lecturer',     'PhD',                't.akhmetov@uni.edu.kz',  '+7 701 444 5566', '2017-09-01', 2),
    ('Lee',       'David',   'Assistant',           'Master',             'd.lee@uni.edu.kz',       NULL,              '2023-09-01', 3),
    ('Nurlanova', 'Aigerim', 'Associate Professor', 'PhD',                'a.nurlanova@uni.edu.kz', '+7 701 555 6677', '2012-09-01', 4);

-- Groups (each curator is a different teacher): 1 = SISCCO-2502NS, 2 = SIS-2401, 3 = ECON-2501
INSERT INTO groups (name, admission_year, faculty_id, curator_id) VALUES
    ('SISCCO-2502NS', 2025, 1, 1),
    ('SIS-2401',      2024, 1, 4),
    ('ECON-2501',     2025, 2, 5);

-- Students: 1 Doe, 2 Seitkali, 3 Petrov, 4 Omarova, 5 Garcia, 6 Bekov, 7 Wilson
INSERT INTO students (last_name, first_name, date_of_birth, email, phone, enrollment_date, has_scholarship, group_id) VALUES
    ('Doe',      'John',    '2006-04-12', 'j.doe@stud.uni.edu.kz',      '+7 702 100 0001', '2025-09-01', FALSE, 1),
    ('Seitkali', 'Aruzhan', '2006-11-03', 'a.seitkali@stud.uni.edu.kz', '+7 702 100 0002', '2025-09-01', TRUE,  1),
    ('Petrov',   'Ivan',    '2007-01-20', 'i.petrov@stud.uni.edu.kz',   NULL,              '2025-09-01', FALSE, 1),
    ('Omarova',  'Dana',    '2005-06-15', 'd.omarova@stud.uni.edu.kz',  '+7 702 100 0004', '2024-09-01', TRUE,  2),
    ('Garcia',   'Lucas',   '2005-09-30', 'l.garcia@stud.uni.edu.kz',   '+7 702 100 0005', '2024-09-01', FALSE, 2),
    ('Bekov',    'Arman',   '2006-02-11', 'a.bekov@stud.uni.edu.kz',    '+7 702 100 0006', '2025-09-01', FALSE, 3),
    ('Wilson',   'Emma',    '2006-08-25', 'e.wilson@stud.uni.edu.kz',   '+7 702 100 0007', '2025-09-01', TRUE,  3);

-- Courses: 1 = DBMS, 2 = Programming, 3 = Information Systems Analysis, 4 = Microeconomics
INSERT INTO courses (code, title, credits, department_id) VALUES
    ('DBMS2101', 'Database Management Systems',  5, 1),
    ('PROG1101', 'Programming Fundamentals',     6, 1),
    ('ISYS2201', 'Information Systems Analysis', 4, 2),
    ('ECON1101', 'Microeconomics',               5, 3);

-- Semesters: 1 = Fall 2024, 2 = Spring 2025, 3 = Fall 2025
INSERT INTO semesters (academic_year, term, start_date, end_date) VALUES
    ('2024-2025', 'Fall',   '2024-09-01', '2024-12-28'),
    ('2024-2025', 'Spring', '2025-01-20', '2025-05-31'),
    ('2025-2026', 'Fall',   '2025-09-01', '2025-12-27');

-- Classrooms: 1 = 305 (computer lab), 2 = 101 (lecture hall), 3 = B-210 (seminar room)
INSERT INTO classrooms (building, room_number, capacity, room_type) VALUES
    ('Main building', '305', 30,  'Computer lab'),
    ('Main building', '101', 120, 'Lecture hall'),
    ('Building B',    '210', 25,  'Seminar room');

-- Course_Teachers: who teaches which course
INSERT INTO course_teachers (teacher_id, course_id, assigned_since) VALUES
    (1, 1, '2016-09-01'),   -- Smith    - Database Management Systems (lectures)
    (2, 1, '2020-09-01'),   -- Brown    - Database Management Systems (labs)
    (2, 2, '2019-09-01'),   -- Brown    - Programming Fundamentals
    (3, 3, '2010-09-01'),   -- Kim      - Information Systems Analysis (lectures)
    (4, 3, '2018-09-01'),   -- Akhmetov - Information Systems Analysis (practice)
    (5, 4, '2023-09-01');   -- Lee      - Microeconomics

-- Enrollments: which student took which course in which semester, and the grade
INSERT INTO enrollments (student_id, course_id, semester_id, grade) VALUES
    (1, 1, 3, 91),     -- Doe      - DBMS, Fall 2025
    (1, 2, 3, 85),     -- Doe      - Programming, Fall 2025
    (2, 1, 3, 77),     -- Seitkali - DBMS, Fall 2025
    (2, 2, 3, 94),     -- Seitkali - Programming, Fall 2025
    (3, 2, 3, 48),     -- Petrov   - Programming, Fall 2025 (failed)
    (4, 2, 1, 88),     -- Omarova  - Programming, Fall 2024
    (4, 3, 2, 73),     -- Omarova  - IS Analysis, Spring 2025
    (5, 2, 1, 65),     -- Garcia   - Programming, Fall 2024
    (5, 3, 2, NULL),   -- Garcia   - IS Analysis, Spring 2025 (not graded yet)
    (6, 4, 3, 82),     -- Bekov    - Microeconomics, Fall 2025
    (7, 4, 3, 90);     -- Wilson   - Microeconomics, Fall 2025

-- Schedule: the weekly timetable for Fall 2025 (semester 3)
-- day_of_week: 1 = Monday ... 6 = Saturday; lesson_number: lesson period of the day
INSERT INTO schedule (semester_id, group_id, teacher_id, course_id, classroom_id, day_of_week, lesson_number, lesson_type) VALUES
    (3, 1, 1, 1, 2, 1, 2, 'Lecture'),    -- SISCCO-2502NS: DBMS lecture, Smith, room 101, Mon period 2
    (3, 1, 2, 1, 1, 1, 3, 'Lab'),        -- SISCCO-2502NS: DBMS lab, Brown, room 305, Mon period 3
    (3, 1, 2, 2, 2, 3, 1, 'Lecture'),    -- SISCCO-2502NS: Programming lecture, Brown, room 101, Wed period 1
    (3, 2, 3, 3, 2, 2, 2, 'Lecture'),    -- SIS-2401: IS Analysis lecture, Kim, room 101, Tue period 2
    (3, 2, 4, 3, 3, 4, 3, 'Practice'),   -- SIS-2401: IS Analysis practice, Akhmetov, room B-210, Thu period 3
    (3, 3, 5, 4, 2, 5, 1, 'Lecture');    -- ECON-2501: Microeconomics lecture, Lee, room 101, Fri period 1


-- ---------------------------------------------------------------------
-- Task 2. Change a value (UPDATE)
-- Ivan Petrov passed a retake of Programming Fundamentals in Fall 2025:
-- his grade changes from 48 to 61.
-- ---------------------------------------------------------------------
UPDATE enrollments
SET grade = 61
WHERE student_id = 3      -- Petrov Ivan
  AND course_id = 2       -- Programming Fundamentals
  AND semester_id = 3;    -- 2025-2026 Fall


-- ---------------------------------------------------------------------
-- Task 3. Delete a row (DELETE)
-- Lucas Garcia withdrew from Information Systems Analysis in Spring 2025
-- before it was graded, so his enrollment record is removed.
-- ---------------------------------------------------------------------
DELETE FROM enrollments
WHERE student_id = 5      -- Garcia Lucas
  AND course_id = 3       -- Information Systems Analysis
  AND semester_id = 2;    -- 2024-2025 Spring
