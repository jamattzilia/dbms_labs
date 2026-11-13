-- Lab work 10 — Views (University database, individual work)
-- Doe John, SISCCO-2502NS. PostgreSQL 16.
-- Database state after Lab 9: run Lab_8/Lab_work_8.sql, then Lab_9/lab9_queries.sql, then this file.

-- Task 1. Choose any query from the LW9 (implemented before with subquery) and remake them using CTE.
WITH csse_major AS (
    SELECT major_id
    FROM majors
    WHERE major_name = 'CSSE'
),
csse_groups AS (
    SELECT group_id
    FROM groups
    WHERE major_id IN (SELECT major_id FROM csse_major)
)
SELECT lname
FROM students
WHERE group_id IN (SELECT group_id FROM csse_groups);

-- Task 2. Choose any other query from the LW9 (implemented before with subquery) and also remake them using CTE.
WITH student_avg AS (
    SELECT stud_id, AVG(final) AS avg_final
    FROM progress
    GROUP BY stud_id
)
SELECT COUNT(*)                 AS students,
       ROUND(MAX(avg_final), 2) AS best_average,
       ROUND(MIN(avg_final), 2) AS worst_average,
       ROUND(AVG(avg_final), 2) AS average_of_averages
FROM student_avg;

-- Task 3. The Teachers table contains some columns with private information. Create a view Teacher_info to hide them and to show only first, last names and id.
CREATE VIEW Teacher_info AS
SELECT teach_id, fname, lname
FROM teachers;

-- Task 4. Show all rows from the view Teacher_info (from the #3) with SELECT statement.
SELECT *
FROM Teacher_info;

-- Task 5. Add a new row into the Teachers table.
INSERT INTO teachers
VALUES (7, 'Daniyar', 'Omarov', 1234567, 'omarov@gmail.com', 'Assistant', 2);

-- Task 6. Check with SELECT if the Teacher_info view contains this new information or not.
SELECT *
FROM Teacher_info;

-- Task 7. Change the structure of the Teacher_info view to include another one column from the Teachers table.
CREATE OR REPLACE VIEW Teacher_info AS
SELECT teach_id, fname, lname, positions
FROM teachers;

-- Task 8. Show with SELECT a result of the renewed view Teacher_info.
SELECT *
FROM Teacher_info;

-- Task 9. Create a new view with joining of two or more tables, an aggregation function or a subquery.
CREATE VIEW Student_gpa AS
SELECT st.stud_id,
       st.fname || ' ' || st.lname AS full_name,
       g.group_name,
       COUNT(p.final)              AS subjects,
       ROUND(AVG(p.final), 2)      AS avg_final
FROM students st
JOIN groups g        ON st.group_id = g.group_id
LEFT JOIN progress p ON p.stud_id   = st.stud_id
GROUP BY st.stud_id, st.fname, st.lname, g.group_name;

-- Task 10. Show with SELECT a result of the view from the #9.
SELECT *
FROM Student_gpa
ORDER BY avg_final DESC NULLS LAST;
