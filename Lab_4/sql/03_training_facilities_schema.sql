PRAGMA foreign_keys = ON;

-- Practical work 2, Task 2: table "Groups" (StudyGroup is the key field)
CREATE TABLE Groups (
    StudyGroup  INTEGER PRIMARY KEY,
    Teacher     TEXT
);

-- Practical work 2, Task 3: table "List" (Code is the key field, StudyGroup is a
-- lookup/combo-box column referencing Groups -> the data scheme relationship)
CREATE TABLE List (
    Code        INTEGER PRIMARY KEY AUTOINCREMENT,
    LastName    TEXT NOT NULL,
    FirstName   TEXT NOT NULL,
    Patronymic  TEXT,
    YearOfBirth INTEGER,
    School      INTEGER,
    Class       INTEGER,
    StudyGroup  INTEGER,
    FOREIGN KEY (StudyGroup) REFERENCES Groups (StudyGroup)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
