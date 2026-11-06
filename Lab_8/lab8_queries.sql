-- Lab work 8 — Advanced queries (University database, individual work)
-- Doe John, SISCCO-2502NS. PostgreSQL 16.
-- First create the database with the handout script Lab_work_8.sql, then run this file.

-- Preparation (Task 7, step 1): rows with different values in Ed_process and Progress.
-- They are added before all tasks, so every task works on the same data.
-- New courses: Physics (subj_id 2) for groups 1-5 in term 3
INSERT INTO Ed_process VALUES (7,1,2,3),
(8,2,2,3),
(9,3,2,3),
(10,4,2,3),
(11,5,2,3);

-- New grades (rk_avg = (rk1+rk2)/2, final = 0.6*rk_avg + 0.4*exam)
INSERT INTO Progress VALUES (4,7,1,95,93,94,94,94),
(5,8,2,88,94,91,92,91),
(6,9,3,80,84,82,70,77),
(7,4,4,85,89,87,80,84),
(8,10,4,70,76,73,65,70),
(9,5,5,98,96,97,96,97),
(10,11,5,92,90,91,89,90),
(11,6,6,60,66,63,58,61);

-- Task 1. Write a query with count() aggregation function. Explain the query result.
SELECT COUNT(*)                AS progress_records,
       COUNT(DISTINCT stud_id) AS students_with_grades
FROM progress;

-- Task 2. Write a query with max(), min(), avg() or sum() aggregation function. Explain the query result.
SELECT MIN(final)           AS min_final,
       MAX(final)           AS max_final,
       ROUND(AVG(final), 2) AS avg_final
FROM progress;

-- Task 3. Add to the previous query (from #1 or #2) GROUP BY condition. Explain the query result.
SELECT stud_id,
       COUNT(*)             AS subjects,
       MIN(final)           AS min_final,
       MAX(final)           AS max_final,
       ROUND(AVG(final), 2) AS avg_final
FROM progress
GROUP BY stud_id;

-- Task 4. Add to the previous query from #4 a condition with HAVING. Explain the query result.
SELECT stud_id,
       COUNT(*)             AS subjects,
       MIN(final)           AS min_final,
       MAX(final)           AS max_final,
       ROUND(AVG(final), 2) AS avg_final
FROM progress
GROUP BY stud_id
HAVING MIN(final) >= 75;

-- Task 5. Add to the previous query from #4 ORDER BY condition. Explain the query result.
SELECT stud_id,
       COUNT(*)             AS subjects,
       MIN(final)           AS min_final,
       MAX(final)           AS max_final,
       ROUND(AVG(final), 2) AS avg_final
FROM progress
GROUP BY stud_id
HAVING MIN(final) >= 75
ORDER BY avg_final DESC;

-- Task 6. Show the Schedule in the following way: Group name, Subject name, Room, Time, Day of week, Type of class, Teacher lname.
SELECT g.group_name  AS "Group name",
       s.subj_name   AS "Subject name",
       sc.room       AS "Room",
       sc.sch_time   AS "Time",
       sc.day_of_week AS "Day of week",
       c.class_type  AS "Type of class",
       t.lname       AS "Teacher lname"
FROM schedule sc
JOIN ed_process e ON sc.proc_id  = e.proc_id
JOIN groups g     ON e.group_id  = g.group_id
JOIN subjects s   ON e.subj_id   = s.subj_id
JOIN classes c    ON sc.class_id = c.class_id
JOIN teachers t   ON sc.teach_id = t.teach_id
ORDER BY sc.day_of_week, sc.sch_time;

-- Task 7. In this task before the SELECT statement add a few rows with different values in the Progress and Ed_process tables. Show the Progress table in the following way: Student fname and lname in one column with "Full name" title, Subject name, RK1, RK2, RK average, Exam, Final.
SELECT st.fname || ' ' || st.lname AS "Full name",
       s.subj_name AS "Subject name",
       p.rk1       AS "RK1",
       p.rk2       AS "RK2",
       p.rk_avg    AS "RK average",
       p.exam      AS "Exam",
       p.final     AS "Final"
FROM progress p
JOIN students st  ON p.stud_id = st.stud_id
JOIN ed_process e ON p.proc_id = e.proc_id
JOIN subjects s   ON e.subj_id = s.subj_id
ORDER BY p.progress_id;

-- Task 8. Edit the previous query to get only students with good (but not excellent) final grades (in other words, from 75 to 90). Final column contains grades in 100% scoring system.
SELECT st.fname || ' ' || st.lname AS "Full name",
       s.subj_name AS "Subject name",
       p.rk1       AS "RK1",
       p.rk2       AS "RK2",
       p.rk_avg    AS "RK average",
       p.exam      AS "Exam",
       p.final     AS "Final"
FROM progress p
JOIN students st  ON p.stud_id = st.stud_id
JOIN ed_process e ON p.proc_id = e.proc_id
JOIN subjects s   ON e.subj_id = s.subj_id
WHERE p.final >= 75 AND p.final < 90
ORDER BY p.progress_id;

-- Task 9. Show the following information with the Ed_process table: Group name, Subject name, average value of final (for every subject for every group).
SELECT g.group_name AS "Group name",
       s.subj_name  AS "Subject name",
       ROUND(AVG(p.final), 2) AS "Average final"
FROM ed_process e
JOIN groups g   ON e.group_id = g.group_id
JOIN subjects s ON e.subj_id  = s.subj_id
JOIN progress p ON p.proc_id  = e.proc_id
GROUP BY g.group_name, s.subj_name
ORDER BY g.group_name, s.subj_name;

-- Task 10. Show the following information with the Students and Progress tables: Student fname and lname in one column with "Full name" title, average value of final for all subjects for every student (like gpa). Show only students with average final grade more or equal 90. Sort students alphabetically.
SELECT st.fname || ' ' || st.lname AS "Full name",
       ROUND(AVG(p.final), 2) AS "Average final"
FROM students st
JOIN progress p ON p.stud_id = st.stud_id
GROUP BY st.stud_id, st.fname, st.lname
HAVING AVG(p.final) >= 90
ORDER BY st.lname, st.fname;
