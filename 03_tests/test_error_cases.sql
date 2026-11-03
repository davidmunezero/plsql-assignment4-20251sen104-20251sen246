-- Invalid dept ID or deptHead ID
EXEC get_dhead_info(6, 6);
-- Triggers application error
EXEC get_dhead_info(NULL, 5); 
EXEC get_dhead_info(5, NULL);
EXEC get_dhead_info(NULL, NULL); 

-- Invalid doctor ID
EXEC get_appointments(6);
-- Triggers application error
EXEC get_appointments(NULL);

-- invalid doctor ID, returns NULL
SELECT get_updated_salary(6) FROM dual;
-- triggers application error, returns NULL
SELECT get_updated_salary(NULL) FROM dual;
-- if payments table is empty, triggers NO_DATA_FOUND
EXEC process_payments;

-- invalid dept ID
DECLARE 
    updated_budget NUMBER;
BEGIN 
    updated_budget := update_dbudget(6);
    DBMS_OUTPUT.PUT_LINE('Updated budget for dept 6: ' || updated_budget);
END;
/