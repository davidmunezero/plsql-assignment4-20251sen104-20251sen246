-- procedure shows actual amount patients are to pay based on their insurance coverage
CREATE OR REPLACE PROCEDURE process_payments IS  
    -- define flag variable 
    v_found BOOLEAN DEFAULT FALSE;
    -- define static cursor
    CURSOR pyt_cursor IS SELECT p.patientName, py.amount, i.coverage 
    FROM patient p JOIN Payment py ON py.patientID = p.patientID 
    JOIN insurance i ON p.insuranceID = i.insuranceID;
BEGIN 
    FOR rec IN pyt_cursor LOOP 
        v_found := TRUE;
        DBMS_OUTPUT.PUT_LINE(rec.patientName || ' is to pay ' || (1-(rec.coverage/100))*rec.amount);
    END LOOP;

    -- if no payment were fetched
    IF NOT v_found THEN 
        RAISE NO_DATA_FOUND;
    END IF; 
EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('No payments were processed!');
END;
/