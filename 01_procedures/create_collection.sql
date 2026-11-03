-- procedure displays the appointments associated with a particular doctor
CREATE OR REPLACE PROCEDURE get_appointments (
    p_doctorID Doctor.doctorID%TYPE
 ) IS 

    -- Create record 
    TYPE apt_record_type IS RECORD (
        doctorName doctor.doctorName%TYPE,
        patientName patient.patientName%TYPE,
        appointmentDate appointment.appointmentDate%TYPE
    );
    
-- create collection 
    TYPE apt_table_type IS TABLE OF apt_record_type;
    apt_table apt_table_type;

BEGIN 
    IF p_doctorID IS NULL THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Doctor ID cannot be null');
    END IF;

    SELECT d.doctorName, p.patientName, a.appointmentDate
    BULK COLLECT INTO apt_table 
    FROM appointment a, doctor d, patient p
    WHERE a.patientID = p.patientID AND a.doctorID = d.doctorID
    AND a.doctorID = p_doctorID;

    IF SQL%ROWCOUNT = 0 THEN 
        RAISE NO_DATA_FOUND;
    END IF;

    FOR i IN 1..apt_table.COUNT LOOP 
        DBMS_OUTPUT.PUT_LINE('Appointment ' || i);
        DBMS_OUTPUT.PUT_LINE('--------------');
        DBMS_OUTPUT.PUT_LINE('Appointment Date: ' || apt_table(i).appointmentDate);
        DBMS_OUTPUT.PUT_LINE('Patient Name: ' || apt_table(i).patientName);
        DBMS_OUTPUT.PUT_LINE('Doctor Name: ' || apt_table(i).doctorName);
    END LOOP;


EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Invalid doctor ID');
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM); 
END;
/
