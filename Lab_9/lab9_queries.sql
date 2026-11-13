-- Lab work 9 — Nested queries (University database, individual work)
-- Doe John, SISCCO-2502NS. PostgreSQL 16.
-- First create the database with the handout script Lab_8/Lab_work_8.sql, then run this file.

-- Rows added in Lab work 8, Task 7
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

-- Lab work 9: preparation
-- A group and a student of another major (RET), so that Task 1 filters something
INSERT INTO Groups VALUES (9,'RET-131',NULL,2);
INSERT INTO Students VALUES (9,'Dana','Bekova',NULL,1234567,'bekova@gmail.com',9);

-- Teachers of the IS and EM departments, so that Task 3 filters something
INSERT INTO Teachers VALUES (5,'Aigerim','Sadykova',1234567,'sadykova@gmail.com','Senior lecturer',2),
(6,'Marat','Zhunusov',1234567,'zhunusov@gmail.com','Associate professor',3);

-- A failed exam (below 50) for Task 4: Database Design for group CSSE-137
INSERT INTO Ed_process VALUES (12,7,1,4);
INSERT INTO Progress VALUES (12,12,7,55,61,58,40,51);

-- Task 1. Show last names of all students whose major is “CSSE”.
SELECT lname
FROM students
WHERE group_id IN (SELECT group_id
                   FROM groups
                   WHERE major_id = (SELECT major_id
                                     FROM majors
                                     WHERE major_name = 'CSSE'));

-- Task 2. Show the identifiers of all students whose "final" grade is greater than the average "final" grade of all students.
SELECT DISTINCT stud_id
FROM progress
WHERE final > (SELECT AVG(final)
               FROM progress)
ORDER BY stud_id;

-- Task 3. Show last names of all the teachers who work in departments CSSE&T and IS.
SELECT lname
FROM teachers
WHERE dep_id IN (SELECT dep_id
                 FROM departments
                 WHERE dep_name IN ('CSSE&T', 'IS'));

-- Task 4. If at least one student has an "exam" grade below 50%, show a list of the last names of all university students with their "exam" grades (i.e. all students with any grades).
SELECT st.lname, p.exam
FROM students st
JOIN progress p ON p.stud_id = st.stud_id
WHERE EXISTS (SELECT *
              FROM progress
              WHERE exam < 50)
ORDER BY st.lname, p.exam;

-- Task 5. Write a query with ANY keyword and a subquery. Explain the query result.
SELECT st.lname, s.subj_name, p.final
FROM progress p
JOIN students st  ON p.stud_id = st.stud_id
JOIN ed_process e ON p.proc_id = e.proc_id
JOIN subjects s   ON e.subj_id = s.subj_id
WHERE s.subj_name = 'Database Design'
  AND p.final > ANY (SELECT p2.final
                     FROM progress p2
                     JOIN ed_process e2 ON p2.proc_id = e2.proc_id
                     JOIN subjects s2   ON e2.subj_id = s2.subj_id
                     WHERE s2.subj_name = 'Physics')
ORDER BY p.final DESC;

-- Task 6. Write a query with ALL keyword and a subquery. Explain the query result.
SELECT st.lname, s.subj_name, p.final
FROM progress p
JOIN students st  ON p.stud_id = st.stud_id
JOIN ed_process e ON p.proc_id = e.proc_id
JOIN subjects s   ON e.subj_id = s.subj_id
WHERE s.subj_name = 'Database Design'
  AND p.final > ALL (SELECT p2.final
                     FROM progress p2
                     JOIN ed_process e2 ON p2.proc_id = e2.proc_id
                     JOIN subjects s2   ON e2.subj_id = s2.subj_id
                     WHERE s2.subj_name = 'Physics')
ORDER BY p.final DESC;

-- Task 7. Write a query with a subquery in FROM clause. Explain the query result.
SELECT COUNT(*)                   AS students,
       ROUND(MAX(avg_final), 2)   AS best_average,
       ROUND(MIN(avg_final), 2)   AS worst_average,
       ROUND(AVG(avg_final), 2)   AS average_of_averages
FROM (SELECT stud_id, AVG(final) AS avg_final
      FROM progress
      GROUP BY stud_id) AS student_avg;

-- Task 8. Write a query with a subquery in INSERT statement. Explain the query result.
INSERT INTO schedule
VALUES ((SELECT MAX(sch_id) + 1 FROM schedule),
        (SELECT e.proc_id
         FROM ed_process e
         JOIN groups g   ON e.group_id = g.group_id
         JOIN subjects s ON e.subj_id  = s.subj_id
         WHERE g.group_name = 'CSSE-131' AND s.subj_name = 'Physics'),
        (SELECT class_id FROM classes WHERE class_type = 'lecture'),
        (SELECT teach_id FROM teachers WHERE lname = 'Sariyev'),
        410, '13:00', 'tue')
RETURNING *;

-- Task 9. Write a query with a subquery in DELETE statement. Explain the query result.
DELETE FROM ed_process
WHERE proc_id NOT IN (SELECT proc_id
                      FROM progress)
RETURNING *;

-- Task 10. Write a query with a subquery in UPDATE statement. Explain the query result.
UPDATE departments d
SET headteach_id = (SELECT MIN(t.teach_id)
                    FROM teachers t
                    WHERE t.dep_id = d.dep_id)
WHERE headteach_id IS NULL
RETURNING dep_id, dep_name, headteach_id;
