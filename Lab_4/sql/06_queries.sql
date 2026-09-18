-- Practical work 3, Task 2: select query "phone book" — students whose last
-- name starts with the letter "С" (Cyrillic), run against the Student table.
-- SELECT
SELECT CodeStudent, LastName, FirstName, Patronymic, PhoneNumber
FROM Student
WHERE LastName LIKE 'С%';

-- Practical work 3, Task 2 (second query): select query "Address" — students
-- who came from Moscow or Lyubertsy.
SELECT CodeStudent, LastName, FirstName, Address
FROM Student
WHERE Address LIKE '%Москва%' OR Address LIKE '%Люберцы%';

-- Separate task 1: students whose first name is Olga.
SELECT CodeStudent, LastName, FirstName, Patronymic
FROM Student
WHERE FirstName = 'Ольга';

-- Separate task 2: employees whose organization begins with the letter "Р"
-- (Cyrillic Р, visually the same glyph as Latin "P" in the assignment text).
SELECT Code, Organization, LastName, FirstName
FROM Employee
WHERE Organization LIKE 'Р%';

-- Separate task 3: students trained in the "технолог" (technologist) specialty.
SELECT CodeStudent, LastName, FirstName, Specialty
FROM Student
WHERE Specialty = 'технолог';

-- Separate task 4: employees who work as engineer or accountant.
SELECT Code, Organization, LastName, FirstName, Position
FROM Employee
WHERE Position IN ('инженер', 'бухгалтер');
