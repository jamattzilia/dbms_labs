# Lab work 6 — Relational Algebra (SELECT queries)

**Goal:** create the small database given in the assignment and solve 10 tasks with one SELECT query each in PostgreSQL.

**Upload:** [`Lab6_Relational_Algebra.docx`](Lab6_Relational_Algebra.docx) — the report with the SQL script and the result of every task, in the required structure (task → query → result).
The same queries are also in [`lab6_queries.sql`](lab6_queries.sql), ready to run.

## Tasks and the relational-algebra operation behind each query

| # | Task | Operation | SQL |
|---|---|---|---|
| 1 | All information about all teachers | whole relation | `SELECT * FROM Teachers` |
| 2 | Last names of all students | projection π | `SELECT lname FROM Students` |
| 3 | Last names of teachers with first name "B" | selection σ + projection π | `... WHERE fname = 'B'` |
| 4 | All teachers and all students in one table | union ∪ | `UNION` |
| 5 | Students who are not also teachers | difference − | `EXCEPT` |
| 6 | Persons who are both students and teachers | intersection ∩ | `INTERSECT` |
| 7 | Teachers with their departments (matches only) | inner join ⋈ | `INNER JOIN` |
| 8 | + teachers without a department | left outer join ⟕ | `LEFT JOIN` |
| 9 | + departments without teachers | right outer join ⟖ | `RIGHT JOIN` |
| 10 | + both kinds of unmatched rows | full outer join ⟗ | `FULL JOIN` |

## Results (PostgreSQL 16, the assignment's data)

- Task 4 returns 3 rows, not 4: `UNION` removes the duplicate "B B", who is both a student and a teacher.
- Task 5 returns "A A"; Task 6 returns "B B".
- Tasks 7 and 8 give the same 2 rows, because with the given data every teacher has a department.
- Tasks 9 and 10 add department AAA with a NULL teacher, because AAA has no teachers.

The result images in the report were generated from the real output of each query on PostgreSQL 16 (column names, types and rows exactly as returned), laid out as a result grid. If the teacher requires screenshots taken in pgAdmin itself, run `lab6_queries.sql` in pgAdmin and replace the images — the results will be identical.
