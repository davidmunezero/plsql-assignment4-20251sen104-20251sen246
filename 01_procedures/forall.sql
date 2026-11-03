CREATE OR REPLACE PROCEDURE Update_amount_table
IS

   TYPE payment_id_tab IS TABLE OF NUMBER;
   TYPE amount_tab IS TABLE OF NUMBER;

   v_payment_ids payment_id_tab;
   v_new_amounts amount_tab;

BEGIN

   SELECT p.paymentID,
          p.amount * (1 - i.coverage/100)
   BULK COLLECT INTO
          v_payment_ids,
          v_new_amounts
   FROM Payment p
   JOIN Patient pt
        ON p.patientID = pt.patientID
   JOIN Insurance i
        ON pt.insuranceID = i.insuranceID;

   FORALL i IN 1..v_payment_ids.COUNT

      UPDATE Payment
      SET amount = v_new_amounts(i)
      WHERE paymentID = v_payment_ids(i);

   DBMS_OUTPUT.PUT_LINE(
      SQL%ROWCOUNT || ' payments updated'
   );

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);

END;
/