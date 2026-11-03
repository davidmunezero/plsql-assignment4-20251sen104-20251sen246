CREATE OR REPLACE PROCEDURE Delete_payment 
(
  p_paymentid payment.paymentid%type
) is 
BEGIN 
    -- DML creates implicit cursor
    DELETE 
    FROM payment 
    WHERE paymentid = p_paymentid;

    IF p_paymentid IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, 'Invalid payment ID');
    END IF;
    IF SQL%FOUND THEN 
      DBMS_OUTPUT.PUT_LINE ('PAYMENT FOUND');
      DBMS_OUTPUT.PUT_LINE ('PAYMENTS DELETED:' || SQL%ROWCOUNT);
    ELSE 
      RAISE NO_DATA_FOUND;
    END IF;
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
      DBMS_OUTPUT.PUT_LINE('Payment not found');
      ROLLBACK;
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
    ROLLBACK;
END;
/
 