# Implementation Notes

## Project Information

### Application Name
Hospital Management System

### Group Members
- Student Name MUNEZERO DAVID 20251SEN104
- Student Name IRAFASHA SCHADRACK 20251SEN246 

---

# 1. Project Overview

This project implements a Hospital Management System using Oracle SQL and PL/SQL. The system manages patients, doctors, appointments, prescriptions, payments, insurance providers, and departments.

# 2. Implementation
The implementation demonstrates the use of:

- Records
- Collections
- Implicit Cursors
- Explicit Cursors
- Bulk Processing (BULK COLLECT and FORALL)
- Stored Procedures
- Functions
- Exception Handling

---

# 3. Database Schema

![Hospital ERD](hospital_erd.jpeg)

# 4. Performance 
I used bulk collect and forall to retrieve payment info, process it, and update the payment table efficiently instead of using traditional for loop which according to Claude AI involves a lot switching between the PL/SQL engine and SQL engine.