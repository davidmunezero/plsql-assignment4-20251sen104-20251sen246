-- This function updates the budget of a department
-- based on the number of doctors it has, and returns the updated budget
CREATE OR REPLACE FUNCTION update_dbudget(p_deptID department.deptID%TYPE) 
RETURN NUMBER IS 
    doctor_count INT;
    current_budget department.budget%TYPE;
    updated_budget department.budget%TYPE;
BEGIN 
    IF p_deptID IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Department ID cannot be null');
    END IF;
    -- retrieve dept budget 
    SELECT dp.budget, COUNT(d.doctorID)  
    INTO current_budget, doctor_count 
    FROM department dp JOIN doctor d 
    ON dp.deptHead = d.doctorID
    WHERE deptID = p_deptID
    GROUP BY dp.deptID, dp.budget;

    IF current_budget IS NULL THEN
        current_budget := 0;
    END IF;

    -- compute new budget
    IF doctor_count > 3 THEN 
        -- 30% increase
        updated_budget := current_budget * 1.3;
    ELSE -- no increase
        updated_budget := current_budget;
    END IF;
    -- update budget in db table
    UPDATE department
    SET budget = updated_budget
    WHERE deptID = p_deptID;
    COMMIT;
    -- return updated budget
    RETURN updated_budget;

EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Invalid department ID');
        ROLLBACK;
        RETURN NULL;

    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
        ROLLBACK;
        RETURN NULL;
END;
/