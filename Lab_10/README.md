# Lab work 10 — Views (University database)

**Goal:** rewrite two Lab 9 queries with CTE (`WITH`), then create, use and change views in PostgreSQL.

**Upload:** [`Lab10_Views.docx`](Lab10_Views.docx) is the report. Each task has its text, an explanation, the SQL and the result. For a command that returns no table, the result is the server's message, for example `CREATE VIEW` or `INSERT 0 1`.

The queries are in [`lab10_queries.sql`](lab10_queries.sql). The database is in its state after Lab 9, so run [`../Lab_8/Lab_work_8.sql`](../Lab_8/Lab_work_8.sql), then [`../Lab_9/lab9_queries.sql`](../Lab_9/lab9_queries.sql), then this file.

## Tasks

| # | Task | Statement | Result |
|---|---|---|---|
| 1 | Lab 9 query rewritten with a CTE | LW9 Task 1 (CSSE students): two chained CTEs, `csse_major` → `csse_groups` | 8 rows, as in LW9 |
| 2 | Another Lab 9 query rewritten with a CTE | LW9 Task 7 (subquery in FROM) → CTE `student_avg` | 1 row, as in LW9 |
| 3 | View `Teacher_info` that hides private columns | `CREATE VIEW … SELECT teach_id, fname, lname` | `CREATE VIEW` |
| 4 | Show the view | `SELECT * FROM Teacher_info` | 6 teachers, 3 columns |
| 5 | New row in Teachers | `INSERT INTO teachers VALUES (7, 'Daniyar', 'Omarov', …)` | `INSERT 0 1` |
| 6 | Does the view show it? | `SELECT * FROM Teacher_info` | yes, 7 teachers |
| 7 | Add a column to the view | `CREATE OR REPLACE VIEW … , positions` | `CREATE VIEW` |
| 8 | Show the changed view | `SELECT * FROM Teacher_info` | 7 teachers, 4 columns |
| 9 | View with a join and aggregates | `Student_gpa`: Students + Groups + `LEFT JOIN` Progress, `COUNT`, `AVG`, `GROUP BY` | `CREATE VIEW` |
| 10 | Show that view | `SELECT * FROM Student_gpa ORDER BY avg_final DESC NULLS LAST` | 9 students |

The result images in the report come from the real output of PostgreSQL 16. Tables show the column names, types and rows exactly as returned. Messages show the command tag returned by the server, in a panel styled like pgAdmin's Messages tab. If the teacher requires screenshots taken in pgAdmin itself, run the SQL files there and replace the images. The results will be the same.
