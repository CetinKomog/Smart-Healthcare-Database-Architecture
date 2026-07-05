-- Create and use the database 
CREATE DATABASE SmartHealthcareDB; 
USE SmartHealthcareDB; 
 -- 1. Hospital Table 
CREATE TABLE Hospital ( 
    HospitalID INT PRIMARY KEY, 
    HospitalName VARCHAR(100) NOT NULL, 
    City VARCHAR(50), 
    Address VARCHAR(255) 
); 
 -- 2. Department Table 
CREATE TABLE Department ( 
    DeptID INT PRIMARY KEY, 
    DeptName VARCHAR(100) NOT NULL, 
    HospitalID INT, 
    FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID) ON DELETE 
CASCADE 
); 
 -- 3. User (Superclass) Table 
CREATE TABLE User ( 
    UserID INT PRIMARY KEY, 
    FirstName VARCHAR(50) NOT NULL, 
    LastName VARCHAR(50) NOT NULL, 
    DateOfBirth DATE, 
    Gender VARCHAR(10) 
); 
 
-- 4. UserPhone (Multivalued Attribute) Table 
CREATE TABLE UserPhone ( 
    UserID INT, 
    PhoneNumber VARCHAR(20), 
    PRIMARY KEY (UserID, PhoneNumber), 
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE 
); 
 -- 5. Patient (Subclass) Table 
CREATE TABLE Patient ( 
    PatientID INT PRIMARY KEY, 
    BloodType VARCHAR(5), 
    EmergencyContact VARCHAR(50), 
    FOREIGN KEY (PatientID) REFERENCES User(UserID) ON DELETE CASCADE 
); 
 -- 6. Doctor (Subclass) Table 
CREATE TABLE Doctor ( 
    DoctorID INT PRIMARY KEY, 
    Specialty VARCHAR(100), 
    HireDate DATE, 
    DeptID INT, 
    FOREIGN KEY (DoctorID) REFERENCES User(UserID) ON DELETE CASCADE, 
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID) ON DELETE SET NULL 
); 
 -- 7. Admin (Subclass) Table 
CREATE TABLE Admin ( 
    AdminID INT PRIMARY KEY, 
    RoleLevel VARCHAR(50), 
    FOREIGN KEY (AdminID) REFERENCES User(UserID) ON DELETE CASCADE 
); 
 -- 8. Insurance Table 
CREATE TABLE Insurance ( 
    PolicyNo VARCHAR(50) PRIMARY KEY, 
    ProviderName VARCHAR(100), 
    CoverageLimit DECIMAL(10,2), 
    PatientID INT, 
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID) ON DELETE CASCADE 
); 
 -- 9. Prescription (Weak Entity) Table 
CREATE TABLE Prescription ( 
    PrescriptionNo VARCHAR(50), 
    PatientID INT, 
    MedicationName VARCHAR(100) NOT NULL, 
    Dosage VARCHAR(50), 
    PRIMARY KEY (PrescriptionNo, PatientID), 
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID) ON DELETE CASCADE 
); 
 -- 10. Appointment (Associative Entity) Table 
CREATE TABLE Appointment ( 
    AppID INT PRIMARY KEY, 
    AppDate DATE NOT NULL, 
    AppTime TIME NOT NULL, 
    Status VARCHAR(20), 
    Diagnosis VARCHAR(255), 
    DoctorID INT, 
PatientID INT, 
FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID), 
FOREIGN KEY (PatientID) REFERENCES Patient(PatientID) 
); -- 11. ALTER Operation Demonstration -- Adding an Email column to the User table after creation 
ALTER TABLE User ADD Email VARCHAR(100) UNIQUE; 

-- ========================================== -- POPULATING THE DATABASE WITH SAMPLE DATA -- ==========================================
INSERT INTO Hospital (HospitalID, HospitalName, City, Address) VALUES 
(1, 'Central Hope Hospital', 'Istanbul', 'Uskudar Central District No:4'), 
(2, 'Yildiz Medical Center', 'Istanbul', 'Besiktas Avenue No:12'), 
(3, 'Metro Health Hospital', 'Ankara', 'Cankaya Boulevard No:89'); -- 2. Inserting into Department 
INSERT INTO Department (DeptID, DeptName, HospitalID) VALUES 
(10, 'Cardiology', 1), 
(20, 'Neurology', 1), 
(30, 'Pediatrics', 2), 
(40, 'General Surgery', 2), 
(50, 'Dermatology', 3); -- 3. Inserting into User (Superclass) -- IDs 101-105: Patients, 106-110: Doctors, 111-113: Admins 
INSERT INTO User (UserID, FirstName, LastName, DateOfBirth, Gender) VALUES 
(101, 'John', 'Doe', '1985-05-12', 'Male'), 
(102, 'Jane', 'Smith', '1990-09-23', 'Female'), 
(103, 'Robert', 'Johnson', '1978-11-02', 'Male'), 
(104, 'Emily', 'Williams', '1995-03-15', 'Female'), 
(105, 'Michael', 'Brown', '1965-07-30', 'Male'), 
(106, 'Alice', 'Walker', '1975-04-18', 'Female'), 
(107, 'David', 'Miller', '1980-12-25', 'Male'), 
(108, 'Sarah', 'Davis', '1983-08-14', 'Female'), 
(109, 'James', 'Wilson', '1972-01-09', 'Male'), 
(110, 'Emma', 'Taylor', '1988-06-21', 'Female'), 
(111, 'Admin', 'Chief', '1985-01-01', 'Male'), 
(112, 'Staff', 'Super', '1992-05-10', 'Female'); -- 4. Inserting into UserPhone (Multivalued Attribute) 
INSERT INTO UserPhone (UserID, PhoneNumber) VALUES 
(101, '+905551112233'), 
(101, '+905551112234'), -- John Doe has two phones 
(102, '+905552223344'), 
(103, '+905553334455'), 
(106, '+905556667788'), 
(107, '+905557778899'); -- 5. Inserting into Patient (Subclass) 
INSERT INTO Patient (PatientID, BloodType, EmergencyContact) VALUES 
(101, 'A+', 'Mary Doe (+905559998877)'), 
(102, '0-', 'Peter Smith (+905558887766)'), 
(103, 'B+', 'Linda Johnson (+905557776655)'), 
(104, 'AB+', 'Kevin Williams (+905556665544)'), 
(105, 'A-', 'Susan Brown (+905555554433)'); -- 6. Inserting into Doctor (Subclass) 
INSERT INTO Doctor (DoctorID, Specialty, HireDate, DeptID) VALUES 
(106, 'Cardiologist', '2015-08-10', 10), 
(107, 'Neurologist', '2018-03-15', 20), 
(108, 'Pediatrician', '2020-01-20', 30), 
(109, 'General Surgeon', '2012-11-01', 40), 
(110, 'Dermatologist', '2021-05-17', 50); -- 7. Inserting into Admin (Subclass) 
INSERT INTO Admin (AdminID, RoleLevel) VALUES 
(111, 'SuperAdmin'), 
(112, 'SystemStaff'); -- 8. Inserting into Insurance 
INSERT INTO Insurance (PolicyNo, ProviderName, CoverageLimit, PatientID) VALUES 
('POL-99881', 'Allianz Health', 50000.00, 101), 
('POL-99882', 'Axa Insurance', 75000.00, 102), 
('POL-99883', 'Mapfre Seguros', 30000.00, 103), 
('POL-99884', 'Anadolu Sigorta', 120000.00, 104); -- 9. Inserting into Prescription (Weak Entity) 
INSERT INTO Prescription (PrescriptionNo, PatientID, MedicationName, Dosage) VALUES 
('RX-2026-001', 101, 'Lipitor', '10mg once daily'), 
('RX-2026-002', 101, 'Aspirin', '81mg once daily'), 
('RX-2026-003', 102, 'Amoxicillin', '500mg three times daily'), 
('RX-2026-004', 104, 'Metformin', '850mg twice daily'); -- 10. Inserting into Appointment (Associative Entity) 
INSERT INTO Appointment (AppID, AppDate, AppTime, Status, Diagnosis, DoctorID, 
PatientID) VALUES 
(1001, '2026-05-10', '09:00:00', 'Completed', 'Hypertension checkup', 106, 101), 
(1002, '2026-05-12', '10:30:00', 'Completed', 'Migraine follow-up', 107, 102), 
(1003, '2026-05-15', '14:00:00', 'Completed', 'Routine child screening', 108, 103), 
(1004, '2026-05-20', '11:15:00', 'Cancelled', 'Patient missed the slot', 109, 104), 
(1005, '2026-06-01', '09:30:00', 'Scheduled', 'Skin rash inspection', 110, 105), 
(1006, '2026-06-02', '15:00:00', 'Scheduled', 'Post-surgery review', 109, 101); 

SELECT u1.FirstName AS PatientName, d.Specialty AS DoctorSpecialty, a.AppDate, 
a.Status  
FROM Appointment a 
JOIN Patient p ON a.PatientID = p.PatientID 
JOIN User u1 ON p.PatientID = u1.UserID 
JOIN Doctor d ON a.DoctorID = d.DoctorID;

SELECT dp.DeptName, COUNT(d.DoctorID) AS TotalDoctors
FROM Department dp
LEFT JOIN Doctor d ON dp.DeptID = d.DeptID
GROUP BY dp.DeptName;

SELECT u.FirstName, u.LastName  
FROM User u 
WHERE u.UserID IN ( 
SELECT p.PatientID  
FROM Patient p 
JOIN Insurance i ON p.PatientID = i.PatientID 
WHERE i.CoverageLimit > 50000 
);

SELECT u.FirstName, pr.MedicationName, pr.Dosage 
FROM Patient p 
JOIN User u ON p.PatientID = u.UserID 
LEFT JOIN Prescription pr ON p.PatientID = pr.PatientID; 

SELECT a.AppID, a.Diagnosis, h.HospitalName, h.City 
FROM Appointment a 
JOIN Doctor d ON a.DoctorID = d.DoctorID 
JOIN Department dp ON d.DeptID = dp.DeptID 
JOIN Hospital h ON dp.HospitalID = h.HospitalID 
WHERE h.City = 'Istanbul';

SELECT  
MAX(CoverageLimit) AS MaxCoverage,  
MIN(CoverageLimit) AS MinCoverage,  
AVG(CoverageLimit) AS AverageCoverage 
FROM Insurance;

SELECT d.DoctorID, u.LastName AS DoctorLastName, COUNT(a.AppID) AS 
AppointmentCount 
FROM Doctor d 
JOIN User u ON d.DoctorID = u.UserID 
JOIN Appointment a ON d.DoctorID = a.DoctorID 
GROUP BY d.DoctorID, u.LastName 
HAVING COUNT(a.AppID) > 1;

SELECT AppID, AppDate, AppTime, Status  
FROM Appointment  
WHERE AppDate BETWEEN '2026-05-01' AND '2026-05-31';

SELECT u.FirstName, u.LastName, i.CoverageLimit 
FROM User u 
JOIN Patient p ON u.UserID = p.PatientID 
JOIN Insurance i ON p.PatientID = i.PatientID 
WHERE i.CoverageLimit = (SELECT MAX(CoverageLimit) FROM Insurance);

SELECT AppID, AppDate, AppTime, Diagnosis 
FROM Appointment 
ORDER BY AppDate DESC, AppTime DESC 
LIMIT 3;

-- ==========================================
-- INDEXING & OPTIMIZATION
-- ==========================================

-- 1. B+ Tree Indexing for Range Queries
CREATE INDEX idx_appdate ON Appointment(AppDate);

-- 2. Hash Indexing for Exact Match Queries
CREATE INDEX idx_status ON Appointment(Status);

-- 3. Composite Indexing for Complex Joins
CREATE INDEX idx_doc_patient ON Appointment(DoctorID, PatientID);