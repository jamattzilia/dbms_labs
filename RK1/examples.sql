-- =====================================================================
--  Topic 32. Aggregate Functions and GROUP BY - example queries
--  Every result shown in the presentation comes from these queries.
--
--  Database: the University database from Lab works 4-5, filled with the
--  Lab 5 INSERT statements only (run Lab_5/university_lw4_lw5.sql up to
--  "Lab Work 5 / Task 2", i.e. without its UPDATE and DELETE), so that
--  one enrollment still has a NULL grade.
--  Run with: psql -U postgres -d university -f examples.sql
-- =====================================================================

\echo === sample
SELECT s.last_name AS student, c.code AS course, e.grade
FROM enrollments e JOIN students s USING (student_id) JOIN courses c USING (course_id)
ORDER BY e.enrollment_id;
\echo === whole_table
SELECT COUNT(*) AS rows, COUNT(grade) AS graded, SUM(grade) AS total,
       ROUND(AVG(grade), 1) AS avg_grade, MIN(grade) AS lowest, MAX(grade) AS highest
FROM enrollments;
\echo === count_variants
SELECT COUNT(*) AS count_star, COUNT(grade) AS count_grade,
       COUNT(DISTINCT course_id) AS distinct_courses
FROM enrollments;
\echo === empty_set
SELECT COUNT(*) AS cnt, SUM(grade) AS total, AVG(grade) AS avg_grade
FROM enrollments WHERE grade > 100;
\echo === avg_with_zero
SELECT ROUND(AVG(grade), 1) AS avg_ignoring_null, ROUND(AVG(COALESCE(grade, 0)), 1) AS avg_null_as_zero
FROM enrollments;
\echo === group_by_course
SELECT c.code AS course, COUNT(*) AS students, ROUND(AVG(e.grade), 1) AS avg_grade, MAX(e.grade) AS best
FROM enrollments e JOIN courses c USING (course_id)
GROUP BY c.code
ORDER BY avg_grade DESC;
\echo === group_two_cols
SELECT g.name AS group_name, s.has_scholarship, COUNT(*) AS students
FROM students s JOIN groups g USING (group_id)
GROUP BY g.name, s.has_scholarship
ORDER BY g.name, s.has_scholarship;
\echo === having
SELECT c.code AS course, ROUND(AVG(e.grade), 1) AS avg_grade
FROM enrollments e JOIN courses c USING (course_id)
WHERE e.semester_id = 3
GROUP BY c.code
HAVING AVG(e.grade) > 80
ORDER BY avg_grade DESC;
\echo === having_all_groups_fall2025
SELECT c.code AS course, ROUND(AVG(e.grade), 1) AS avg_grade
FROM enrollments e JOIN courses c USING (course_id)
WHERE e.semester_id = 3
GROUP BY c.code ORDER BY avg_grade DESC;
\echo === error_rule
SELECT c.code, e.student_id, AVG(e.grade)
FROM enrollments e JOIN courses c USING (course_id)
GROUP BY c.code;
\echo === error_where
SELECT course_id FROM enrollments WHERE AVG(grade) > 80;
