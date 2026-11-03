CREATE OR REPLACE PROCEDURE update_payment_tbl IS
  
  TYPE pay_rec_type IS RECORD (
        paymentID payment.paymentID%TYPE,
        patientID payment.patientID%TYPE,
        amount payment.amount%TYPE,
        coverage NUMBER
  );
  TYPE pay_table_type IS TABLE OF pay_rec_type;
  pay_table pay_table_type;

BEGIN
  -- 1. Fetch paymentID at once
    SELECT py.paymentID, py.patientID, py.amount, i.coverage
    BULK COLLECT INTO pay_table 
    FROM patient p JOIN Payment py ON py.patientID = p.patientID 
    JOIN insurance i ON p.insuranceID = i.insuranceID;

    IF pay_table.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No payments found.');
        RETURN;
    END IF;
  --

  -- 2. Update them all in one operation
  FORALL i IN 1 .. pay_table.COUNT
    UPDATE payment
    SET amount = pay_table(i).amount * (1 - (pay_table(i).coverage/100))
    WHERE paymentID = pay_table(i).paymentID;

  DBMS_OUTPUT.PUT_LINE('Rows updated: ' || SQL%ROWCOUNT);
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/