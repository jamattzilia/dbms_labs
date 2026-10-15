# Lab work 1 — Subject Area Analysis (University database)

**Goal:** the first step of database design — describe the future database for the educational process at the university.

**Upload:** [`Lab1_Subject_Area_Analysis.docx`](Lab1_Subject_Area_Analysis.docx)

The report follows the six points of the assignment plan:

| # | Plan item | What the report contains |
|---|---|---|
| 1 | Stored information | "The database is designed to hold information relating to the educational process…" — 9 detailed areas |
| 2 | Entities and attributes | 9 tables: Faculties, Departments, Teachers, Groups, Students, Courses, Semesters, Classrooms, Schedule (PK underlined, FK in italics) |
| 3 | Relationships | 13 relationships, each answered from both sides: ten 1:M, one 1:1 (curator), two M:N (Students – Courses, Teachers – Courses) |
| 4 | Constraints | 5 constraints (date of birth after 1980, grade 0–100, credits 1–10, one curator per group, no two lessons of a group at once) |
| 5 | User groups | Students (read-only), Teachers (write grades), Dean's office staff (write students, groups, schedule) |
| 6 | Potential queries | 14 queries |

The two M:N relationships are kept as relationships here (conceptual level) and become separate tables in Lab work 3.
