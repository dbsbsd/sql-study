
/*
���ν����� divisor_proc
���� �ϳ��� ���޹޾� �ش� ���� ����� ������ ����ϴ� ���ν����� �����մϴ�.
*/
CREATE OR REPLACE PROCEDURE divisor_proc
    (n IN NUMBER)
IS
    c NUMBER := 0;
BEGIN
    FOR i IN 1..n
    LOOP
        IF MOD(n, i) = 0 THEN
            c := c + 1;
        END IF;
    END LOOP;
    dbms_output.put_line(n || '�� ����� ����: ' || c || '��'); 
END;

EXEC divisor_proc(72);

/*
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
*/
CREATE OR REPLACE PROCEDURE depts_proc
    (p_department_id IN depts.department_id%TYPE,
    p_department_name IN depts.department_name%TYPE,
    p_flag IN VARCHAR2
    )
IS
    v_cnt NUMBER := 0;
BEGIN
    SELECT
        count(*)
    INTO
        v_cnt
    FROM depts
    WHERE department_id = p_department_id;

    IF p_flag  = 'I' THEN
        INSERT INTO depts
        (department_id, department_name)
        VALUES(p_department_id, p_department_name);
    ELSIF p_flag = 'U' THEN
        UPDATE depts
        SET department_name = p_department_name
        WHERE department_id = p_department_id;
    ELSIF p_flag = 'D' THEN
        IF v_cnt = 0 THEN
            dbms_output.put_line('�������� �ʴ� �μ��Դϴ�.');
            RETURN;
        END IF;
        DELETE FROM depts
        WHERE department_id = p_department_id;
    ELSE
        dbms_output.put_line('�ش� flag�� �������� �ʽ��ϴ�.');
    END IF;
    COMMIT;
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('���ܰ� �߻��߽��ϴ�.');
        dbms_output.put_line('ERROR MGS: ' || SQLERRM);
        ROLLBACK;
END;

EXEC depts_proc(700, '������', 'g');

SELECT * FROM depts ORDER BY department_id DESC;

/*
employee_id�� �Է¹޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
*/
CREATE OR REPLACE PROCEDURE emp_proc
    (p_employee_id IN employees.employee_id%TYPE,
    p_result OUT VARCHAR2)
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '�������� �ʴ� ���̵��Դϴ�.';
BEGIN
    SELECT
        count(*)
    INTO v_cnt
    FROM employees
    WHERE employee_id = p_employee_id;
    
    IF v_cnt = 0 THEN p_result := v_result;
    ELSE
        SELECT
            first_name || ' ' || last_name || '���� �ټӳ⵵�� ' ||
            TRUNC((sysdate - hire_date)/365, 0) || '���Դϴ�.'
        INTO
            v_result
        FROM employees
        WHERE employee_id = p_employee_id;
    END IF;
    p_result := v_result;
    COMMIT;
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('���ܰ� �߻��߽��ϴ�.');
        dbms_output.put_line('ERROR MGS: ' || SQLERRM);
END;

DECLARE
    y VARCHAR2(100);
BEGIN
    emp_proc(106, y);
    dbms_output.put_line(y);
END;

/*
���ν����� - new_emp_proc
employees ���̺��� ���� ���̺� emps�� �����մϴ�.
employee_id, last_name, email, hire_date, job_id�� �Է¹޾�
�����ϸ� �̸�, �̸���, �Ի���, ������ update, 
���ٸ� insert�ϴ� merge���� �ۼ��ϼ���

������ �� Ÿ�� ���̺� -> emps
���ս�ų ������ -> ���ν����� ���޹��� employee_id�� dual�� select ������ ��.
���ν����� ���޹޾ƾ� �� ��: ���, last_name, email, hire_date, job_id
*/

CREATE TABLE emps AS SELECT * FROM employees;
SELECT * FROM emps;
DROP TABLE emps;

CREATE OR REPLACE PROCEDURE new_emp_proc
    (
    p_employee_id IN emps.employee_id%TYPE,
    p_last_name IN emps.last_name%TYPE,
    p_email IN emps.email%TYPE,
    p_hire_date IN emps.hire_date%TYPE,
    p_job_id IN emps.job_id%TYPE
    )
IS
BEGIN
    MERGE INTO emps a -- ������ �� Ÿ�� ���̺�
                USING
                    (SELECT p_employee_id AS employee_id FROM dual) b -- SELECT (����) AS employee_id FROM dual
                ON
                    (a.employee_id = b.employee_id) -- ���޹��� ����� emps�� �����ϴ� ���� ���� �������� ���.
            WHEN MATCHED THEN
                UPDATE SET
                    a.last_name = p_last_name,
                    a.email = p_email,
                    a.hire_date = p_hire_date,
                    a.job_id = p_job_id
            WHEN NOT MATCHED THEN
                INSERT
                    (a.employee_id, a.last_name, a.email, a.hire_date, a.job_id)
                VALUES
                    (p_employee_id, p_last_name, p_email, p_hire_date, p_job_id);
END;

EXEC new_emp_proc(100, 'kim', 'kim1234', '2023-11-02', 'test2');

SELECT * FROM emps;





    
