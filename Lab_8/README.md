# Lab work 8 — Advanced Queries (University database)

**Goal:** write one SELECT query for each of 10 tasks with aggregate functions, GROUP BY, HAVING, ORDER BY and joins, in PostgreSQL.

**Upload:** [`Lab8_Advanced_Queries.docx`](Lab8_Advanced_Queries.docx) is the report. Each task has its text, an explanation of the result, the SQL and the result.

| File | What it is |
|---|---|
| [`Lab_work_8.sql`](Lab_work_8.sql) | The handout script that creates the database (11 tables, handout data) |
| [`lab8_queries.sql`](lab8_queries.sql) | The rows added for Task 7 and all 10 queries. Run it after `Lab_work_8.sql` |

## Extra data (Task 7)

The handout has only 3 Progress records, all graded 90, so GROUP BY and HAVING would have nothing to show. Task 7 asks for new rows in Progress and Ed_process, so they were added right after the database was created and all tasks use the same data:

- **Ed_process:** 5 rows, Physics for groups CSSE-131 to CSSE-135.
- **Progress:** 8 rows with different grades. RK average = (RK1 + RK2) / 2 and final = 0.6 · RK average + 0.4 · exam.

## Tasks

| # | Task | Key part of the query | Rows |
|---|---|---|---|
| 1 | `COUNT()` | `COUNT(*)`, `COUNT(DISTINCT stud_id)` on Progress → 11 records, 6 students | 1 |
| 2 | `MIN`/`MAX`/`AVG` | final grades: 61 / 97 / 84.91 | 1 |
| 3 | + `GROUP BY` | `GROUP BY stud_id` | 6 |
| 4 | + `HAVING` | `HAVING MIN(final) >= 75` | 4 |
| 5 | + `ORDER BY` | `ORDER BY avg_final DESC` | 4 |
| 6 | Schedule | 5 joins: Ed_process, Groups, Subjects, Classes, Teachers | 2 |
| 7 | Progress with "Full name" | `fname \|\| ' ' \|\| lname AS "Full name"` | 11 |
| 8 | Good grades only | `final >= 75 AND final < 90` (90 is already "excellent", A-) | 2 |
| 9 | Average final per group and subject | `GROUP BY group_name, subj_name` | 10 |
| 10 | GPA ≥ 90, alphabetical | `HAVING AVG(final) >= 90 ORDER BY lname, fname` | 3 |

The result images in the report come from the real output of each query on PostgreSQL 16, with column names, types and rows exactly as returned, drawn as a result grid. If the teacher requires screenshots taken in pgAdmin itself, run the two SQL files there and replace the images. The results will be the same.
