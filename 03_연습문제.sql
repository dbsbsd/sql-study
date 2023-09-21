--1. ��� ����� �����ȣ, �̸�, �Ի���, �޿��� ����ϼ���.
SELECT
    employee_id AS �����ȣ,
    first_name AS �̸�,
    hire_date AS �Ի���,
    salary AS �޿�
FROM employees;

--2. ��� ����� �̸��� ���� �ٿ� ����ϼ���. �� ��Ī�� name���� �ϼ���.
SELECT
    first_name || ' ' || last_name AS name
FROM employees;

--3. 50�� �μ� ����� ��� ������ ����ϼ���.
SELECT *
FROM employees
WHERE department_id = 50;

--4. 50�� �μ� ����� �̸�, �μ���ȣ, �������̵� ����ϼ���.
SELECT
    first_name AS �̸�,
    department_id AS �μ���ȣ,
    job_id AS �������̵�
FROM employees
WHERE department_id = 50;

--5. ��� ����� �̸�, �޿� �׸��� 300�޷� �λ�� �޿��� ����ϼ���.
SELECT
    first_name AS �̸�,
    salary AS �޿�,
    salary + 300 AS �λ�ȱ޿�
FROM employees;

--6. �޿��� 10000���� ū ����� �̸��� �޿��� ����ϼ���.
SELECT
   first_name AS �̸�,
   salary AS �޿�
FROM employees
WHERE salary > 10000;

--7. ���ʽ��� �޴� ����� �̸��� ����, ���ʽ����� ����ϼ���.
SELECT
   first_name AS �̸�,
   job_id AS ����,
   commission_pct AS ���ʽ���
FROM employees
WHERE commission_pct IS NOT NULL;

--8. 2003�⵵ �Ի��� ����� �̸��� �Ի��� �׸��� �޿��� ����ϼ���.(BETWEEN ������ ���)
SELECT
   first_name AS �̸�,
   hire_date AS �Ի���,
   salary AS �޿�
FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

--9. 2003�⵵ �Ի��� ����� �̸��� �Ի��� �׸��� �޿��� ����ϼ���.(LIKE ������ ���)
SELECT
   first_name AS �̸�,
   hire_date AS �Ի���,
   salary AS �޿�
FROM employees
WHERE hire_date LIKE '03%';

--10. ��� ����� �̸��� �޿��� �޿��� ���� ������� ���� ��������� ����ϼ���.
SELECT
   first_name AS �̸�,
   salary AS �޿�
FROM employees
ORDER BY salary DESC;

--11. �� ���Ǹ� 60�� �μ��� ����� ���ؼ��� �����ϼ���. (�÷�: department_id)
SELECT
   first_name AS �̸�,
   salary AS �޿�,
   department_id AS �μ���ȣ
FROM employees
WHERE department_id = 60
ORDER BY salary DESC;

--12. �������̵� IT_PROG �̰ų�, SA_MAN�� ����� �̸��� �������̵� ����ϼ���.
SELECT
    first_name AS �̸�,
    job_id AS �������̵�
FROM employees
WHERE job_id IN ('IT_PROG', 'SA_MAN');

--13. Steven King ����� ������ ��Steven King ����� �޿��� 24000�޷� �Դϴ١� �������� ����ϼ���.
SELECT
    first_name || ' ' || last_name || ' ����� �޿��� $' || salary || '�Դϴ�.' AS �������
FROM employees
WHERE (first_name = 'Steven' AND last_name LIKE 'King');

--14. �Ŵ���(MAN) ������ �ش��ϴ� ����� �̸��� �������̵� ����ϼ���. (�÷�:job_id)
SELECT
    first_name AS �̸�,
    job_id AS �������̵�
FROM employees
WHERE job_id LIKE '%_MAN';

--15. �Ŵ���(MAN) ������ �ش��ϴ� ����� �̸��� �������̵� �������̵� ������� ����ϼ���.
SELECT
    first_name AS �̸�,
    job_id AS �������̵�
FROM employees
WHERE job_id LIKE '%_MAN'
ORDER BY job_id;
