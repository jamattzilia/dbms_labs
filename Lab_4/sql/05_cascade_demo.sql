-- Practical work 2, Task 7: check cascade UPDATE of related fields.
-- Renumber every study group from 10x to 20x; ON UPDATE CASCADE propagates
-- the new StudyGroup value into every matching row of "List" automatically.
UPDATE Groups SET StudyGroup = StudyGroup + 100;

-- Practical work 2, Task 8: check cascade DELETE of related fields.
-- Deleting group 201 (formerly 101) removes it from "Groups"; ON DELETE
-- CASCADE removes every "List" row that referenced group 201 as well
-- (Чернова and Архипов, who were originally in group 101).
DELETE FROM Groups WHERE StudyGroup = 201;
