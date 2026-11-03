CREATE TABLE Insurance (
    -- make pk surrogate/sequential
    insuranceID INT GENERATED ALWAYS AS IDENTITY, 
    provider VARCHAR2(50) NOT NULL,
    coverage NUMBER NOT NULL CHECK (coverage BETWEEN 0 AND 100),
    PRIMARY KEY(insuranceID)
);

CREATE TABLE Patient (
    patientID INT GENERATED ALWAYS AS IDENTITY,
    patientName VARCHAR2(50) NOT NULL,
    birthdate DATE NOT NULL,
    phone VARCHAR2(15) UNIQUE NOT NULL,
    address VARCHAR2(50),
    insuranceID INT REFERENCES Insurance(insuranceID),
    PRIMARY KEY(patientID)
);

CREATE TABLE Doctor (
    doctorID INT GENERATED ALWAYS AS IDENTITY,
    doctorName VARCHAR2(50) NOT NULL,
    speciality VARCHAR2(20) NOT NULL,
    rank VARCHAR2(10),
    salary NUMBER NOT NULL CHECK (salary > 0),
    joinDate DATE,
    PRIMARY KEY(doctorID)
);

CREATE TABLE department (
    deptID INT GENERATED ALWAYS AS IDENTITY,
    deptName VARCHAR2(50) NOT NULL CHECK (deptName IN 
            ('Emergency', 'Internal Medicine', 'Laboratory', 'Pediatrics', 'Surgery', 'Dentistry', 'Maternal Care')
        ),
    budget NUMBER,
    deptHead INT REFERENCES Doctor(doctorID),
    PRIMARY KEY(deptID)
);

CREATE TABLE Appointment (
    appointmentID INT GENERATED ALWAYS AS IDENTITY,
    appointmentDate DATE DEFAULT SYSDATE NOT NULL,
    roomNo VARCHAR2(10) NOT NULL,
    diagnosis VARCHAR2(100) NOT NULL,
    patientID INT REFERENCES Patient(patientID),
    doctorID INT REFERENCES Doctor(doctorID),
    PRIMARY KEY(appointmentID)
);

CREATE TABLE Prescription (
    prescriptionID INT GENERATED ALWAYS AS IDENTITY,
    description VARCHAR2(100) NOT NULL,
    appointmentID INT REFERENCES Appointment(appointmentID),
    PRIMARY KEY(prescriptionID)
);

CREATE TABLE Payment (
    paymentID INT GENERATED ALWAYS AS IDENTITY,
    paymentDate DATE NOT NULL,
    category VARCHAR2(50) NOT NULL CHECK (category IN ('Check Up', 'Consultation', 'Lab Test', 'Prescription')),
    amount NUMBER NOT NULL CHECK (amount > 0),
    patientID INT REFERENCES Patient(patientID)
);
COMMIT;