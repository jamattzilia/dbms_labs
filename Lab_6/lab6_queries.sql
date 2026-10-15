-- =====================================================================
--  Lab work 6. Relational algebra - SELECT queries
--  Student: Doe John, group SISCCO-2502NS
--  DBMS: PostgreSQL. Run with: psql -U postgres -f lab6_queries.sql
--  (pgAdmin: create the database, open a Query Tool on it, skip the \c line)
-- =====================================================================

-- Preparation: the database and data given in the assignment
CREATE DATABASE lab6;

\c lab6

CREATE TABLE Students(
stud_id int PRIMARY KEY,
fname varchar(20),
lname varchar(20)
);

CREATE TABLE Departments(
dep_id int PRIMARY KEY,
name varchar(10)
);

CREATE TABLE Teachers(
teach_id int PRIMARY KEY,
fname varchar(20),
lname varchar(20),
dep_id int REFERENCES Departments(dep_id)
);

INSERT INTO Students VALUES (1,'A','A'), (2,'B','B');
INSERT INTO Departments VALUES (1,'AAA'), (2,'BBB');
INSERT INTO Teachers VALUES (1,'B','B', 2), (2,'C','C', 2);


-- Task 1. Show all information about all teachers.
-- Relational algebra: Teachers
SELECT *
FROM Teachers;


-- Task 2. Show last names of all students (only last names, not all
--         columns).
-- Relational algebra: π lname (Students)
SELECT lname
FROM Students;


-- Task 3. Show last names of teachers whose first names = "B".
-- Relational algebra: π lname (σ fname = 'B' (Teachers))
SELECT lname
FROM Teachers
WHERE fname = 'B';


-- Task 4. Show information about all teachers and all students in the one
--         table (with 2 columns: first name, last name).
-- Relational algebra: π fname, lname (Students) ∪ π fname, lname (Teachers)
SELECT fname, lname
FROM Students
UNION
SELECT fname, lname
FROM Teachers;


-- Task 5. Show information about students, but without persons who are
--         students and teachers at the same time (in the table with 2
--         columns: first name, last name).
-- Relational algebra: π fname, lname (Students) − π fname, lname (Teachers)
SELECT fname, lname
FROM Students
EXCEPT
SELECT fname, lname
FROM Teachers;


-- Task 6. Show information only about persons who are students and teachers
--         at the same time (in the table with 2 columns: first name, last
--         name).
-- Relational algebra: π fname, lname (Students) ∩ π fname, lname (Teachers)
SELECT fname, lname
FROM Students
INTERSECT
SELECT fname, lname
FROM Teachers;


-- Task 7. Show teachers and their departments in the following table:
--         teachers' last name, department name. Include only teachers which
--         have departments and departments which have teachers.
-- Relational algebra: π T.lname, D.name (Teachers T ⋈ T.dep_id = D.dep_id Departments D)
SELECT T.lname, D.name
FROM Teachers T
INNER JOIN Departments D ON T.dep_id = D.dep_id;


-- Task 8. Show teachers and their departments in the following table:
--         teachers' last name, department name. In this task include also
--         teachers which at this moment have not any department.
-- Relational algebra: π T.lname, D.name (Teachers T ⟕ T.dep_id = D.dep_id Departments D)
SELECT T.lname, D.name
FROM Teachers T
LEFT JOIN Departments D ON T.dep_id = D.dep_id;


-- Task 9. Show teachers and their departments in the following table:
--         teachers' last name, department name. In this task include also
--         departments which at this moment have not any teachers.
-- Relational algebra: π T.lname, D.name (Teachers T ⟖ T.dep_id = D.dep_id Departments D)
SELECT T.lname, D.name
FROM Teachers T
RIGHT JOIN Departments D ON T.dep_id = D.dep_id;


-- Task 10. Show teachers and their departments in the following table:
--         teachers' last name, department name. In this task include also
--         teachers which at this moment have not any department as well as
--         departments which at this moment have not any teachers.
-- Relational algebra: π T.lname, D.name (Teachers T ⟗ T.dep_id = D.dep_id Departments D)
SELECT T.lname, D.name
FROM Teachers T
FULL JOIN Departments D ON T.dep_id = D.dep_id;
