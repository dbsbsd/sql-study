/*
문제 1.
-EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들의 데이터를 출력 하세요 
(AVG(컬럼) 사용)
-EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들의 수를 출력하세요
-EMPLOYEES 테이블에서 job_id가 IT_PROG인 사원들의 평균급여보다 높은 사원들의 
데이터를 출력하세요
*/
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT count(*)
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees WHERE job_id = 'IT_PROG');

/*
문제 2.
-DEPARTMENTS테이블에서 manager_id가 100인 사람의 department_id와
EMPLOYEES테이블에서 department_id가 일치하는 모든 사원의 정보를 검색하세요.
*/
SELECT * FROM employees
WHERE department_id = (SELECT department_id FROM departments
                        WHERE manager_id = 100);

/*
문제 3.
-EMPLOYEES테이블에서 “Pat”의 manager_id보다 높은 manager_id를 갖는 모든 사원의 데이터를 
출력하세요
-EMPLOYEES테이블에서 “James”(2명)들의 manager_id를 갖는 모든 사원의 데이터를 출력하세요.
*/
SELECT * FROM employees
WHERE manager_id > (SELECT manager_id FROM employees
                    WHERE first_name = 'Pat');

SELECT * FROM employees
WHERE manager_id IN (SELECT manager_id FROM employees
                    WHERE first_name = 'James');

/*
문제 4.
-EMPLOYEES테이블 에서 first_name기준으로 내림차순 정렬하고, 41~50번째 데이터의 
행 번호, 이름을 출력하세요
*/
SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl.first_name
        FROM
        (
            SELECT * FROM employees
            ORDER BY first_name DESC
        ) tbl
    )
WHERE rn BETWEEN 41 AND 50;

/*
문제 5.
-EMPLOYEES테이블에서 hire_date기준으로 오름차순 정렬하고, 31~40번째 데이터의 
행 번호, 사원id, 이름, 번호, 입사일을 출력하세요.
*/
SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl.*
        FROM
        (
            SELECT
                employee_id, first_name, phone_number, hire_date
            FROM employees
            ORDER BY hire_date
        ) tbl
    )
WHERE rn BETWEEN 31 AND 40;

/*
문제 6.
employees테이블 departments테이블을 left 조인하세요
조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
조건) 직원아이디 기준 오름차순 정렬
*/
SELECT
    e.employee_id AS 직원아이디,
    e.first_name || ' ' || e.last_name AS 이름,
    e.department_id AS 부서아이디,
    d.department_name AS 부서명
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY employee_id;

/*
문제 7.
문제 6의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
*/
SELECT
    employee_id AS 직원아이디,
    first_name || ' ' || last_name AS 이름,
    department_id AS 부서아이디,
    (
        SELECT
            department_name
        FROM departments d
        WHERE d.department_id = e.department_id
    ) AS 부서명
FROM employees e
ORDER BY employee_id;

/*
문제 8.
departments테이블 locations테이블을 left 조인하세요
조건) 부서아이디, 부서이름, 매니저아이디, 로케이션아이디, 스트릿_어드레스, 포스트 코드, 시티 만 출력합니다
조건) 부서아이디 기준 오름차순 정렬
*/
SELECT
    d.department_id,
    d.department_name,
    d.manager_id,
    d.location_id,
    loc.street_address,
    loc.postal_code,
    loc.city
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY department_id;

/*
문제 9.
문제 8의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
*/
SELECT
    department_id,
    department_name,
    manager_id,
    location_id,
    (
        SELECT
            loc.street_address
        FROM locations loc
        WHERE loc.location_id = d.location_id
    ) AS street_address,
    (
        SELECT
            loc.postal_code
        FROM locations loc
        WHERE loc.location_id = d.location_id
    ) AS postal_code,
    (
        SELECT
            loc.city
        FROM locations loc
        WHERE loc.location_id = d.location_id
    ) AS city
FROM departments d
ORDER BY department_id;

/*
문제 10.
locations테이블 countries 테이블을 left 조인하세요
조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
조건) country_name기준 오름차순 정렬
*/
SELECT
    loc.location_id,
    loc.street_address,
    loc.city,
    loc.country_id,
    cou.country_name
FROM locations loc
LEFT JOIN countries cou
ON loc.country_id = cou.country_id
ORDER BY country_name;

/*
문제 11.
문제 10의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
*/
SELECT
    location_id,
    street_address,
    city,
    country_id,
    (
        SELECT
            cou.country_name
        FROM countries cou
        WHERE cou.country_id = loc.country_id
    ) AS country_name
FROM locations loc
ORDER BY country_name;

/*
문제 12. 
employees테이블, departments테이블을 left조인 hire_date를 오름차순 기준으로 
1-10번째 데이터만 출력합니다.
조건) rownum을 적용하여 번호, 직원아이디, 이름, 전화번호, 입사일, 
부서아이디, 부서이름 을 출력합니다.
조건) hire_date를 기준으로 오름차순 정렬 되어야 합니다. rownum이 틀어지면 안됩니다.
*/
SELECT ROWNUM AS rn, a.*
FROM (
        SELECT
            e.employee_id AS 사원번호,
            e.first_name || ' ' || e.last_name AS 이름,
            e.phone_number AS 전화번호,
            e.hire_date AS 입사일,
            e.department_id AS 부서아이디,
            d.department_name AS 부서이름
        FROM employees e
        LEFT JOIN departments d
        ON e.department_id = d.department_id
        ORDER BY 입사일
    ) a;

/*
문제 13. 
--EMPLOYEES 와 DEPARTMENTS 테이블에서 JOB_ID가 SA_MAN 사원의 정보의 LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME을 출력하세요.
*/
SELECT
    e.first_name || ' ' || e.last_name AS 이름,
    e.job_id,
    e.department_id AS 부서아이디,
    d.department_name AS 부서이름
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE job_id = 'SA_MAN';

/*
문제 14
--DEPARTMENT테이블에서 각 부서의 ID, NAME, MANAGER_ID와 부서에 속한 인원수를 출력하세요.
--인원수 기준 내림차순 정렬하세요.
--사람이 없는 부서는 출력하지 뽑지 않습니다.
*/
SELECT 
   d.department_id,   
   d.department_name,
   d.manager_id,
   COUNT(e.employee_id) as 인원수
FROM departments d  
JOIN employees e 
ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name ,d.manager_id
HAVING COUNT(e.employee_id) > 0  
ORDER BY 인원수 DESC;

/*
문제 15
--부서에 대한 정보 전부와, 주소, 우편번호, 부서별 평균 연봉을 구해서 출력하세요.
--부서별 평균이 없으면 0으로 출력하세요.
*/
SELECT
    d.*,
    loc.street_address,
    loc.postal_code,
    NVL(e.avg, 0)
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id
LEFT JOIN (SELECT department_id, AVG(salary) AS avg FROM employees GROUP BY department_id) e
ON d.department_id = e.department_id
ORDER BY d.department_id;

/*
문제 16
-문제 15 결과에 대해 DEPARTMENT_ID기준으로 내림차순 정렬해서 
ROWNUM을 붙여 1-10 데이터 까지만 출력하세요.
*/
SELECT * FROM
(
    SELECT ROWNUM AS rn, a.*
    FROM (
        SELECT
            d.*,
            loc.street_address,
            loc.postal_code,
            e.avg
        FROM departments d
        JOIN locations loc
        ON d.location_id = loc.location_id
        JOIN (SELECT department_id, AVG(salary) AS avg FROM employees GROUP BY department_id ) e
        ON d.department_id = e.department_id
        ORDER BY d.department_id DESC
    ) a
)
WHERE rn > 0 AND rn <= 10;
