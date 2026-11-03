-- stored procedure retrieves the dept name and budget given the dept id 
-- It also retrieves info related to dept_head 

CREATE OR REPLACE PROCEDURE get_dhead_info (p_dept_id department.deptID%TYPE, p_dept_head department.deptHead%TYPE) IS 
    -- define user-defined record
    TYPE dept_rec_type IS RECORD (
        d_name department.deptName%TYPE,
        budget department.budget%TYPE
    );
    -- declare department record
    dept_rec dept_rec_type;

    -- create record based on table column
    doctor_rec doctor%ROWTYPE;

BEGIN 
    IF p_dept_id IS NULL THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Department ID cannot be null');
    END IF; 

    IF p_dept_head IS NULL THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Department Head ID cannot be null');
    END IF;

    -- retrieve department data
    SELECT deptName, budget 
    INTO dept_rec
    FROM department
    WHERE deptID = p_dept_id;

    -- retrieve dept head data
    SELECT *
    INTO doctor_rec 
    FROM doctor 
    WHERE doctorID = p_dept_head;

    -- display dept and dept head info
    DBMS_OUTPUT.PUT_LINE(dept_rec.d_name || ' has ' || doctor_rec.doctorName || ' as the head');
    DBMS_OUTPUT.PUT_LINE(doctor_rec.doctorName || ' earns ' || doctor_rec.salary);

EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Invalid dept ID or deptHead ID');
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
