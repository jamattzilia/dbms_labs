-- =====================================================================
--  Lab work 4. Physical Design (SQL, DDL) — University database
--  Student: Doe John, group SISCCO-2502NS
--  DBMS: PostgreSQL
--
--  How to run:
--    psql:    psql -U postgres -f university.sql
--    pgAdmin: run Task 1 (CREATE DATABASE) on its own, then open a
--             Query Tool on the new "university" database and run the
--             rest of the script, skipping the \c line.
-- =====================================================================


-- ---------------------------------------------------------------------
--  Task 1. Create the University database
-- ---------------------------------------------------------------------
CREATE DATABASE university;

\c university


-- ---------------------------------------------------------------------
--  Task 2. Create all tables (11 tables, 3NF, from the Lab work 3 model)
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
--  Task 3. Create a test table and change it with ALTER TABLE
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
--  Task 4. Drop the test table
-- ---------------------------------------------------------------------
DROP TABLE test_table_renamed;
