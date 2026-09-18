-- Practical work 1, Task 1: table "Employee" (built from the Contact application-part template)
CREATE TABLE Employee (
    Code            INTEGER PRIMARY KEY,
    Organization    TEXT,
    LastName        TEXT,
    FirstName       TEXT,
    Email           TEXT,
    Position        TEXT,
    WorkPhone       TEXT,
    HomePhone       TEXT,
    MobilePhone     TEXT,
    FaxNumber       TEXT,
    Address         TEXT,
    City            TEXT,
    Republic        TEXT,
    PostalCode      TEXT,
    Country         TEXT
);

-- Practical work 1, Task 2: table "Student" (built with the Table Designer, CodeStudent is an autonumber key)
CREATE TABLE Student (
    CodeStudent     INTEGER PRIMARY KEY AUTOINCREMENT,
    LastName        TEXT NOT NULL,
    FirstName       TEXT NOT NULL,
    Patronymic      TEXT,
    Address         TEXT,
    PhoneNumber     TEXT,
    Specialty       TEXT
);
