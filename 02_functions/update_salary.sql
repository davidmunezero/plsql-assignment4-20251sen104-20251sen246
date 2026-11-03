-- This function returns the updated salary of a doctor based on their rank
CREATE OR REPLACE FUNCTION get_updated_salary (
    p_doctorID doctor.doctorID%TYPE
) RETURN NUMBER IS
    v_rank doctor.rank%TYPE;
    current_salary doctor.salary%TYPE;
    new_salary doctor.salary%TYPE;
    
BEGIN 
    IF p_doctorID IS NULL THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Doctor ID cannot be null');
    END IF;

    SELECT rank, salary 
    INTO v_rank, current_salary
    FROM doctor WHERE doctorID = p_doctorID;

    CASE v_rank 
    -- 20% raise 
    WHEN 'Senior' THEN new_salary := current_salary * 1.2;
    -- 15% raise 
    WHEN 'Consultant' THEN new_salary := current_salary * 1.15;
    -- 10% raise 
    WHEN 'Junior' THEN new_salary := current_salary * 1.1;
    -- 5% raise
    ELSE new_salary := current_salary * 1.05;
    END CASE;

    RETURN new_salary;

EXCEPTION  
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Invalid doctor ID');
        RETURN NULL;
    
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM); 
        RETURN NULL;

END;
/
