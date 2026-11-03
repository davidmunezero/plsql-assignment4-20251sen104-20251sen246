EXEC get_dhead_info(1, 2);
EXEC get_dhead_info(2, 1);
EXEC get_appointments(2);
SELECT get_updated_salary(2) FROM dual;
SELECT get_updated_salary(3) FROM dual;
EXEC process_payments;

DECLARE 
    updated_budget NUMBER;
BEGIN 
    updated_budget := update_dbudget(4);
    DBMS_OUTPUT.PUT_LINE('Updated budget for dept 4: ' || updated_budget);
END;
/

EXEC update_payment_tbl;
