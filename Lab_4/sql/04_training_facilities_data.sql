-- Practical work 2, Task 5, Table 1: fill "Groups"
INSERT INTO Groups (StudyGroup, Teacher) VALUES
(101, 'Смирнова З.В.'),
(102, 'Вильданова Р.Ш.'),
(103, 'Зайцева С.А.'),
(104, 'Зазулина З.А.'),
(105, 'Друк Н.Н.');

-- Practical work 2, Task 6, Table 2: fill in the "List" data-entry form
INSERT INTO List (LastName, FirstName, Patronymic, YearOfBirth, School, Class, StudyGroup) VALUES
('Чернова',   'Наталья', 'Алексеевна',     2001, 5, 9,  101),
('Куликов',   'Клим',    'Алексеевич',     1999, 2, 10, 103),
('Архипов',   'Виктор',  'Александрович',  2000, 5, 9,  101),
('Баранкова', 'Александра', 'Николаевна',  1998, 5, 11, 104),
('Новоселов', 'Алексей', 'Иванович',       2000, 3, 9,  105);
