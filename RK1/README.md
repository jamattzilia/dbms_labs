# RK1 — Individual Self-Study Project

**Topic 32. Aggregate Functions and GROUP BY**
Doe John · group SISCCO-2502NS

| Deliverable | File |
|---|---|
| Presentation (15 slides) | [`Aggregate_Functions_and_GROUP_BY.pptx`](Aggregate_Functions_and_GROUP_BY.pptx) |
| Peer task — Option B: quiz, 8 questions, with answer key | [`Quiz_Aggregate_Functions_and_GROUP_BY.docx`](Quiz_Aggregate_Functions_and_GROUP_BY.docx) |
| SQL behind every example in the slides | [`examples.sql`](examples.sql) |

## Slides

| # | Slide | What it shows |
|---|---|---|
| 1 | Title | Topic, course, author |
| 2 | Many rows in, one value out | The idea of aggregation: ten grades → `AVG(grade)` = 79.3 |
| 3 | The five standard aggregate functions | COUNT, SUM, AVG, MIN, MAX with their value on the sample data |
| 4 | Sample data | The `enrollments` table used in every example (11 rows, 4 courses, one NULL grade) |
| 5 | Aggregates over the whole table | One query, one result row |
| 6 | COUNT variants and NULL values | `COUNT(*)` 11 vs `COUNT(grade)` 10 vs `COUNT(DISTINCT …)` 4; AVG skips NULL (79.3 vs 72.1); empty input |
| 7 | GROUP BY: one result row per group | Diagram: 11 rows → 4 course groups → 4 result rows |
| 8 | GROUP BY in SQL | Grouped query with JOIN and its result |
| 9 | The GROUP BY rule | A wrong query with PostgreSQL's real error message, and the fix |
| 10 | Grouping by several columns | One row per distinct combination |
| 11 | WHERE vs HAVING | Rows vs groups, before vs after grouping, real error for `WHERE AVG(...)` |
| 12 | WHERE and HAVING in one query | Result after GROUP BY and after HAVING |
| 13 | Logical order of a grouped query | FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY, with the key takeaways |
| 14–15 | Quiz (Q1–Q8) | Questions for classmates; answers are in the speaker notes |

All examples use the University database from Lab works 4–5, so the topic connects to the rest of the course. Every result table and error message on the slides was produced by running `examples.sql` on PostgreSQL 16. Each slide has speaker notes.
