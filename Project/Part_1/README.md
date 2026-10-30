# Project. Part 1 — Subject Area Analysis (Hospital database)

**Topic:** Hospital / Clinic · **Done by:** Doe John, group SISCCO-2502NS

**Upload:** [`Project_Part1_Subject_Area_Analysis.docx`](Project_Part1_Subject_Area_Analysis.docx)

This README repeats the full design so the next project parts (ER diagram, normalization, SQL) can be built on it.

## 1. Information stored

The database is designed to hold information relating to the work of a hospital, namely:

- the structure of the hospital: departments (cardiology, surgery, pediatrics, ...), their floors and phones, and the doctor who heads each department;
- doctors: personal and contact data, medical license number, date of employment, specialization and the department where they work;
- the catalogue of medical specializations (cardiologist, surgeon, pediatrician, ...);
- patients: personal and contact data, date of birth, gender, blood type, address and medical insurance number;
- outpatient appointments: which patient visits which doctor, on which date and at what time, the complaint and the status of the visit;
- diagnoses made at each appointment, chosen from a catalogue of diseases with international ICD-10 codes;
- prescriptions issued at appointments and the medications in each prescription with dosage, frequency and duration;
- laboratory tests ordered at appointments (blood test, urinalysis, X-ray, ...) and their results;
- inpatient care: wards with their type, number of beds and daily rate, and hospitalizations — which patient stays in which ward, when admitted and discharged, and under which doctor;
- billing: invoices issued to patients with amounts, due dates and payment status.

## 2. Subject area and goal

The subject area is a multi-department city hospital that has both an outpatient clinic (appointments with doctors) and an inpatient part (wards where patients are hospitalized). Today much of its work is done on paper and in separate spreadsheets: the registry keeps an appointment book, each doctor writes the medical history by hand, laboratory results come on paper forms, and the accounting department calculates invoices separately.

The goal of the database design is to bring all this information into one consistent database. It solves concrete problems: double booking of a doctor at the same time, lost or unreadable medical records, laboratory results that do not reach the doctor, not knowing how many free beds are left in a ward, and billing mistakes.

The database improves the main processes of the hospital: scheduling of appointments, keeping a complete electronic medical history of every patient (diagnoses, prescriptions, test results, hospitalizations), management of beds in the wards, and billing. It also gives the management statistics, for example the most frequent diagnoses or the workload of every doctor.

## 3. Entities and attributes (12 entities)

Primary keys are <u>underlined</u>, foreign keys in *italics*.

1. **Departments** (<u>**department_id**</u>, name, floor, phone, *head_doctor_id*)
2. **Specializations** (<u>**specialization_id**</u>, name, description)
3. **Doctors** (<u>**doctor_id**</u>, last_name, first_name, license_number, phone, email, hire_date, *specialization_id*, *department_id*)
4. **Patients** (<u>**patient_id**</u>, last_name, first_name, date_of_birth, gender, phone, email, address, blood_type, insurance_number)
5. **Appointments** (<u>**appointment_id**</u>, appointment_date, start_time, status, complaint, *patient_id*, *doctor_id*)
6. **Diseases** (<u>**disease_id**</u>, icd_code, name, category)
7. **Medications** (<u>**medication_id**</u>, name, dosage_form, manufacturer, price)
8. **Prescriptions** (<u>**prescription_id**</u>, issue_date, valid_until, notes, *appointment_id*)
9. **Lab_Tests** (<u>**lab_test_id**</u>, name, sample_type, unit, normal_range, price)
10. **Wards** (<u>**ward_id**</u>, ward_number, ward_type, capacity, daily_rate, *department_id*)
11. **Hospitalizations** (<u>**hospitalization_id**</u>, admission_date, discharge_date, reason, *patient_id*, *ward_id*, *doctor_id*)
12. **Invoices** (<u>**invoice_id**</u>, issue_date, due_date, total_amount, status, *patient_id*)

The three M:N relationships (Appointments – Diseases, Prescriptions – Medications, Appointments – Lab_Tests) carry their own attributes and become separate tables in Part 3.

## 4. Relationships

| # | Relationship | Description |
|---|---|---|
| 1 | Departments – Doctors (1:M) | One department employs one or many doctors, and from the other side one doctor works in exactly one department. |
| 2 | Doctors – Departments (1:1, head of department) | One department is headed by one doctor, and one doctor can be the head of at most one department. |
| 3 | Specializations – Doctors (1:M) | One specialization can be held by many doctors (zero or more), and one doctor has exactly one specialization. |
| 4 | Departments – Wards (1:M) | One department has many wards (zero or more), and one ward belongs to exactly one department. |
| 5 | Patients – Appointments (1:M) | One patient can have many appointments, and one appointment is made for exactly one patient. |
| 6 | Doctors – Appointments (1:M) | One doctor has many appointments, and one appointment is conducted by exactly one doctor. |
| 7 | Appointments – Diseases (M:N) | At one appointment the doctor can make several diagnoses, and one disease can be diagnosed at many appointments. For every pair the database stores whether the diagnosis is primary and the doctor's notes; these are attributes of the relationship itself. |
| 8 | Appointments – Prescriptions (1:M) | At one appointment the doctor can issue zero or many prescriptions, and one prescription is issued at exactly one appointment. |
| 9 | Prescriptions – Medications (M:N) | One prescription contains one or many medications, and one medication can appear in many prescriptions. For every pair the database stores the dosage, how often to take it and for how many days. |
| 10 | Appointments – Lab_Tests (M:N) | At one appointment the doctor can order several laboratory tests, and one type of test can be ordered at many appointments. For every pair the database stores the result value and the date of the result. |
| 11 | Patients – Hospitalizations (1:M) | One patient can be hospitalized many times, and one hospitalization is for exactly one patient. |
| 12 | Wards – Hospitalizations (1:M) | One ward hosts many hospitalizations over time, and one hospitalization takes place in exactly one ward. |
| 13 | Doctors – Hospitalizations (1:M) | One doctor is the attending doctor for many hospitalizations, and one hospitalization has exactly one attending doctor. |
| 14 | Patients – Invoices (1:M) | One patient can receive many invoices, and one invoice is issued to exactly one patient. |

## 5. Constraints

1. A patient's date of birth cannot be later than today; gender is 'M' or 'F'; blood type is one of A+, A−, B+, B−, AB+, AB−, O+, O−.
2. A doctor cannot have two appointments on the same date at the same start time; the status of an appointment is Scheduled, Completed, Cancelled or No-show.
3. The discharge date of a hospitalization, if it is set, cannot be earlier than the admission date.
4. A ward has from 1 to 10 beds; ward daily rates, medication prices, laboratory test prices and invoice amounts cannot be negative.
5. A doctor's license number and a patient's insurance number are unique; one doctor can be the head of at most one department.
6. An invoice's due date cannot be earlier than its issue date, and its status is Unpaid, Paid or Cancelled.

## 6. User groups and access rights

- **User_group_1: Doctors.** Access rights: Appointments, diagnoses (Appointments – Diseases), Prescriptions, prescribed medications (Prescriptions – Medications), ordered lab tests and results (Appointments – Lab_Tests), Hospitalizations (read-write); Patients, Doctors, Departments, Specializations, Diseases, Medications, Lab_Tests, Wards (read-only).
- **User_group_2: Receptionists (registry).** Access rights: Patients, Appointments, Hospitalizations (read-write); Doctors, Departments, Specializations, Wards (read-only).
- **User_group_3: Accountants.** Access rights: Invoices, Medications, Lab_Tests, Wards (read-write) — they issue invoices and keep prices up to date; Patients, Appointments, Prescriptions, Hospitalizations (read-only).

The database administrator exists by default and is not listed.

## 7. Potential queries

1. Show all appointments of a given doctor on a given date, ordered by time.
2. Show the contact information of a patient by his or her insurance number.
3. Show all doctors of a department with their specializations.
4. Show the medical history of a patient: dates of appointments, doctors and diagnoses.
5. Show all medications prescribed to a patient during the last 6 months with dosage and frequency.
6. Show the patients who are in hospital now (no discharge date) with their ward and attending doctor.
7. Show the number of free beds in every ward (capacity minus the patients staying there now).
8. Show the 5 most frequent diagnoses of the current year.
9. Show the number of appointments of every doctor per month.
10. Show all laboratory tests ordered at a given appointment with their results and normal ranges.
11. Show all unpaid invoices whose due date has already passed, with the patient's phone number.
12. Show the total amount of invoices issued per month.
13. Show the head doctor of every department.
14. Show all cancelled appointments and no-shows for a given period.
15. Show the patients who have not visited the hospital for more than one year.
