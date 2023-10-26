CREATE TABLE depts AS (SELECT * FROM departments);

SELECT * FROM depts;

// ���� 1
INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES
    (280, '����', '', 1800);
INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES
    (290, 'ȸ���', '', 1800);
INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES
    (300, '����', '', 1800);
INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES
    (310, '�λ�', '', 1800);
INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES
    (320, '����', '', 1700);

// ���� 2 
UPDATE depts
SET department_name = 'IT bank'
WHERE department_name = 'IT Support';

UPDATE depts
SET manager_id = 301
WHERE department_id = 290;

UPDATE depts
SET department_name = 'IT Help', manager_id = 303, location_id = 1800
WHERE department_name = 'IT Helpdesk';

UPDATE depts
SET manager_id = 301
WHERE department_name IN ('ȸ���', '����', '�λ�', '����');

// ���� 3
DELETE FROM depts
WHERE department_id = 220 OR department_id = 320;

// ���� 4
DELETE FROM depts
WHERE depts.department_id > 200;

UPDATE depts
SET  manager_id = 100
WHERE manager_id IS NOT NULL;

MERGE INTO depts a
    USING
        (SELECT * FROM departments) b
    ON
        (a.department_id = b.department_id)
WHEN MATCHED THEN
    UPDATE SET
        a.department_name = b.department_name,
        a.manager_id = b.manager_id,
        a.location_id = b.location_id
WHEN NOT MATCHED THEN
    INSERT VALUES
        (b.department_id,
        b.department_name,
        b.manager_id,
        b.location_id);
        
// ���� 5
CREATE TABLE jobs_it AS (SELECT * FROM jobs WHERE jobs.min_salary > 6000);

SELECT * FROM jobs_it;

INSERT INTO jobs_it
    (job_id, job_title, min_salary, max_salary)
VALUES
    ('IT_DEV', '����Ƽ������', 6000, 20000);
INSERT INTO jobs_it
    (job_id, job_title, min_salary, max_salary)
VALUES
    ('NET_DEV', '��Ʈ��ũ������', 5000, 20000);
INSERT INTO jobs_it
    (job_id, job_title, min_salary, max_salary)
VALUES
    ('SEC_DEV', '���Ȱ�����', 6000, 19000);
    
MERGE INTO jobs_it a
    USING
        (SELECT * FROM jobs WHERE min_salary > 5000) b
    ON
        (a.job_id = b.job_id)
WHEN MATCHED THEN
    UPDATE SET
        a.min_salary = b.min_salary,
        a.max_salary = b.max_salary
WHEN NOT MATCHED THEN
    INSERT VALUES
        (b.job_id,
        b.job_title,
        b.min_salary,
        b.max_salary);

