# Lab work 7 — Queries (University database)

**Goal:** write one SELECT query for each of 10 tasks on the University database from Lab works 4–5, in PostgreSQL.

**Upload:** [`Lab7_Queries.docx`](Lab7_Queries.docx) is the report, laid out in the required structure. It opens with the University database ER diagram, then gives each task as description → SQL → result.
The same queries are also in [`lab7_queries.sql`](lab7_queries.sql), ready to run on the database created by [`../Lab_5/university_lw4_lw5.sql`](../Lab_5/university_lw4_lw5.sql).

## Tasks

| # | Task | Query | Rows |
|---|---|---|---|
| 1 | Alias for a result column | `courses`, `code AS course_code`, … | 4 |
| 2 | Table aliases in a join | `students s JOIN groups g` | 7 |
| 3 | Two attributes in one column | `last_name \|\| ' ' \|\| first_name AS full_name` | 6 |
| 4 | Values without duplicates | `SELECT DISTINCT position FROM teachers` | 4 |
| 5 | NULL / NOT NULL values | `WHERE phone IS NULL` | 1 |
| 6 | Range with `<`, `<=`, `>`, `>=` | `WHERE grade >= 70 AND grade <= 90` | 6 |
| 7 | Range with `BETWEEN` | `date_of_birth BETWEEN '2006-01-01' AND '2006-12-31'` | 4 |
| 8 | `LIKE` with `%` | `title LIKE '%Systems%'` | 2 |
| 9 | `LIKE` with `_` | `name LIKE 'SIS-____'`, which matches SIS-2401 but not SISCCO-2502NS | 1 |
| 10 | `CAST` and `::` | `credits::NUMERIC(4,1)`, `CAST(credits AS VARCHAR) \|\| ' credits'` | 4 |

The result images in the report come from the real output of each query on PostgreSQL 16, with column names, types and rows exactly as returned, drawn as a result grid. If the teacher requires screenshots taken in pgAdmin itself, run `lab7_queries.sql` there and replace the images. The results will be the same.
