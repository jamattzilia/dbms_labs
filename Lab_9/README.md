# Lab work 9 — Nested Queries (University database)

**Goal:** solve 10 tasks with one query each in PostgreSQL. Every query contains at least one subquery.

**Upload:** [`Lab9_Nested_Queries.docx`](Lab9_Nested_Queries.docx) is the report. Each task has its text, an explanation of the result, the SQL and the result.

| File | What it is |
|---|---|
| [`../Lab_8/Lab_work_8.sql`](../Lab_8/Lab_work_8.sql) | The handout script that creates the database (Lab 9 uses the same one) |
| [`lab9_queries.sql`](lab9_queries.sql) | The rows added in Lab 8, the Lab 9 preparation rows and all 10 queries. Run it after `Lab_work_8.sql` |

## Preparation

The database is in its state after Lab 8, with the handout data plus the Lab 8 Task 7 rows. With that data alone, some tasks would show nothing, so a few rows were added:

- Group RET-131 (major RET) with student Bekova. Without it, Task 1 returns every student.
- Teachers Sadykova (IS) and Zhunusov (EM). Without them, Task 3 returns every teacher.
- A failed exam (40) for Akhat. Without it, Task 4 returns nothing.

## Tasks

| # | Task | Subquery | Rows |
|---|---|---|---|
| 1 | Students of the major CSSE | two nested `IN` / `=` subqueries: major → groups → students | 8 |
| 2 | Students with a final grade above the average | `final > (SELECT AVG(final) …)` = 82.08 | 5 |
| 3 | Teachers of CSSE&T and IS | `dep_id IN (SELECT …)` | 5 |
| 4 | All exam grades if someone has an exam grade below 50 | `WHERE EXISTS (SELECT … WHERE exam < 50)` | 12 |
| 5 | `ANY` | Database Design finals `> ANY` Physics finals (above the minimum, 70) | 5 |
| 6 | `ALL` | Database Design finals `> ALL` Physics finals (above the maximum, 94) | 1 |
| 7 | Subquery in `FROM` | per-student averages → MAX / MIN / AVG of them | 1 |
| 8 | Subquery in `INSERT` | new schedule row, every id found by name | 1 inserted |
| 9 | Subquery in `DELETE` | courses with no grades: `NOT IN (SELECT proc_id FROM progress)` | 1 deleted |
| 10 | Subquery in `UPDATE` | correlated subquery sets the head of each department | 3 updated |

Tasks 8–10 use `RETURNING`, so their result shows the rows that were changed.

The result images in the report come from the real output of each query on PostgreSQL 16, with column names, types and rows exactly as returned, drawn as a result grid. If the teacher requires screenshots taken in pgAdmin itself, run the two SQL files there and replace the images. The results will be the same.
