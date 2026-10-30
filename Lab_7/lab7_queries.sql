-- Lab work 7 — Queries (University database, individual work)
-- Doe John, SISCCO-2502NS. PostgreSQL 16.
-- Run on the University database from Lab works 4–5 (Lab_5/university_lw4_lw5.sql).

-- Task 1. Use SELECT statement for any table with aliasing a result column.
SELECT code    AS course_code,
       title   AS course_title,
       credits AS ects_credits
FROM courses;

-- Task 2. Use aliasing of tables in a SELECT statement with several tables (with join operation).
SELECT s.last_name, s.first_name, g.name AS group_name
FROM students s
JOIN groups g ON s.group_id = g.group_id;

-- Task 3. Select data from any table and represent two different attributes in one column in the result table.
SELECT last_name || ' ' || first_name AS full_name,
       position
FROM teachers;

-- Task 4. Write a SELECT query to get data from any table's attribute without duplicates values.
SELECT DISTINCT position
FROM teachers;

-- Task 5. Select only null or not null values of any table's attribute.
SELECT last_name, first_name, phone
FROM students
WHERE phone IS NULL;

-- Task 6. Use SELECT statement to get rows from any table with filtering values in a column between two values (using the <,<=,> and >= operators).
SELECT student_id, course_id, semester_id, grade
FROM enrollments
WHERE grade >= 70 AND grade <= 90;

-- Task 7. Use SELECT statement to get rows from any table with filtering values in a column between two values (using the BETWEEN operator).
SELECT last_name, first_name, date_of_birth
FROM students
WHERE date_of_birth BETWEEN '2006-01-01' AND '2006-12-31';

-- Task 8. Use % with LIKE operator to find some values.
SELECT code, title
FROM courses
WHERE title LIKE '%Systems%';

-- Task 9. Use _ with LIKE operator to find some values.
SELECT name, admission_year
FROM groups
WHERE name LIKE 'SIS-____';

-- Task 10. Write a SELECT query with CAST or :: operators.
SELECT code,
       credits::NUMERIC(4,1) AS credits_decimal,
       CAST(credits AS VARCHAR) || ' credits' AS credits_text
FROM courses;
