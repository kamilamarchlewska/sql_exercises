/*---------------------------------------------------------------------------
 * HR Database - SUBQUERIES: JOINS
https://www.w3resource.com/sql-exercises/joins-hr/index.php
 * Author:  Kamila Marchlewska
 *---------------------------------------------------------------------------
*/


/*---------------------------------------------------------------------------
 * 1. Write a SQL query to find the first name, last name, department number, 
 and department name for each employee.
*/

SELECT 
    EMP.FIRST_NAME, 
    EMP.LAST_NAME,
    EMP.DEPARTMENT_ID,
    DEP.DEPARTMENT_NAME
FROM EMPLOYEES EMP 
LEFT JOIN DEPARTMENTS DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID;



/*---------------------------------------------------------------------------
 * 2. Write a SQL query to find the first name, last name, department, city, 
   and state province for each employee.
*/

SELECT 
    EMP.FIRST_NAME,
    EMP.LAST_NAME,
    DEP.DEPARTMENT_NAME,
    LOC.CITY,
    LOC.STATE_PROVINCE
FROM EMPLOYEES EMP
LEFT JOIN DEPARTMENTS DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
LEFT JOIN LOCATIONS LOC ON DEP.LOCATION_ID = LOC.LOCATION_ID;



/*---------------------------------------------------------------------------
 * 3. Write a SQL query to find the first name, last name, salary, 
   and job title for all employees.
*/

SELECT 
    EMP.FIRST_NAME,
    EMP.LAST_NAME,
    EMP.SALARY,
    JOBS.JOB_TITLE
FROM EMPLOYEES EMP
LEFT JOIN JOBS ON EMP.JOB_ID = JOBS.JOB_ID;



/*---------------------------------------------------------------------------
 * 4. Write a SQL query to find all those employees who work in department ID 80
   or 40. Return first name, last name, department number and department name.
*/

SELECT 
    EMP.FIRST_NAME,
    EMP.LAST_NAME,
    EMP.DEPARTMENT_ID,
    DEP.DEPARTMENT_NAME
FROM EMPLOYEES EMP 
LEFT JOIN DEPARTMENTS DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
WHERE
    EMP.DEPARTMENT_ID IN (40,80);



/*---------------------------------------------------------------------------
 * 5. Write a SQL query to find those employees whose first name contains 
   the letter ‘z’. Return first name, last name, department, city, 
   and state province.
*/

SELECT
    EMP.FIRST_NAME,
    EMP.LAST_NAME,
    DEP.DEPARTMENT_NAME,
    LOC.CITY,
    LOC.STATE_PROVINCE
FROM EMPLOYEES EMP 
LEFT JOIN DEPARTMENTS DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
LEFT JOIN LOCATIONS LOC ON DEP.LOCATION_ID = LOC.LOCATION_ID
WHERE
    REGEXP_LIKE(FIRST_NAME, 'z');



/*---------------------------------------------------------------------------
 * 6. Write a SQL query to find all departments, including those without 
   employees. Return first name, last name, department ID, department name.
*/

SELECT
    EMP.FIRST_NAME,
    EMP.LAST_NAME,
    DEP.DEPARTMENT_ID,
    DEP.DEPARTMENT_NAME
FROM DEPARTMENTS DEP 
LEFT JOIN EMPLOYEES EMP ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID;



/*---------------------------------------------------------------------------
 *  7. Write a SQL query to find the employees who earn less than 
    the employee of ID 155. Return first name, last name and salary.
*/

SELECT 
    FIRST_NAME,
    LAST_NAME,
    SALARY
FROM 
    EMPLOYEES
WHERE
    SALARY < (SELECT SALARY 
                FROM EMPLOYEES 
                WHERE EMPLOYEE_ID = 155);



/*---------------------------------------------------------------------------
 * 8. Write a SQL query to find the employees and their managers. 
   Return the last name of the employee and manager.
*/

SELECT 
    EMP.EMPLOYEE_ID,
    EMP.LAST_NAME AS EMP_LAST_NAME,
    EMP.MANAGER_ID,
    MNG.LAST_NAME AS MNG_LAST_NAME
FROM 
    EMPLOYEES EMP, 
    EMPLOYEES MNG
WHERE
    MNG.EMPLOYEE_ID = EMP.MANAGER_ID;
 


/*---------------------------------------------------------------------------
 * 9. Write a SQL query to display the department name, city, 
   and state province for each department.
*/

SELECT
    DEP.DEPARTMENT_NAME,
    LOC.CITY,
    NVL(LOC.STATE_PROVINCE, 'NO STATE PROVINCE') AS STATE_PROVINCE
FROM DEPARTMENTS DEP 
LEFT JOIN LOCATIONS LOC ON DEP.LOCATION_ID = LOC.LOCATION_ID;



/*---------------------------------------------------------------------------
 * 10. Write a SQL query to find out which employees have or do not have 
   a department. Return first name, last name, department ID, department name.
*/

SELECT
    EMP.FIRST_NAME,
    EMP.LAST_NAME,
    DEP.DEPARTMENT_ID,
    DEP.DEPARTMENT_NAME
FROM EMPLOYEES EMP
LEFT JOIN DEPARTMENTS DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID;



/*---------------------------------------------------------------------------
 * 11. Write a SQL query to find the employees and their managers. 
   These managers do not work under any manager. 
   Return the last name of the employee and manager.
*/

SELECT 
    --EMP.EMPLOYEE_ID,
    EMP.LAST_NAME AS EMP_LAST_NAME,
    --EMP.MANAGER_ID,
    MNG.LAST_NAME AS MNG_LAST_NAME
FROM 
    EMPLOYEES EMP, 
    EMPLOYEES MNG
WHERE
    MNG.EMPLOYEE_ID = EMP.MANAGER_ID
AND
    MNG.MANAGER_ID IS NULL;



/*---------------------------------------------------------------------------
 * 12. Write a SQL query to find the employees who work in the same department 
   as the employee with the last name Taylor. 
   Return first name, last name and department ID.
*/

SELECT
    FIRST_NAME,
    LAST_NAME,
    DEPARTMENT_ID
FROM 
    EMPLOYEES
WHERE
    DEPARTMENT_ID IN (SELECT DEPARTMENT_ID 
                        FROM EMPLOYEES 
                        WHERE REGEXP_LIKE(LAST_NAME, 'Taylor'));



/*---------------------------------------------------------------------------
 * 13. Write a SQL query to find all employees who joined after 01 January 1993 
   and left on or before 31 August 1997. Return job title, department name, 
   employee name, and joining date of the job.
*/

SELECT
    JOBS.JOB_TITLE,
    DEP.DEPARTMENT_NAME,
    EMP.LAST_NAME,
    --JOB_H.END_DATE,
    JOB_H.START_DATE
FROM EMPLOYEES EMP
LEFT JOIN DEPARTMENTS DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
LEFT JOIN JOB_HISTORY JOB_H ON EMP.EMPLOYEE_ID = JOB_H.EMPLOYEE_ID
LEFT JOIN JOBS ON EMP.JOB_ID = JOBS.JOB_ID
WHERE JOB_H.START_DATE > '93/01/01'
AND JOB_H.END_DATE < '97/08/31';



/*---------------------------------------------------------------------------
 * 14. Write a SQL query to calculate the difference between 
   the maximum salary of the job and the employee's salary. 
   Return job title, employee_id, employee last name, and salary difference.
*/

SELECT 
    JOBS.JOB_TITLE,
    EMP.EMPLOYEE_ID,
    EMP.LAST_NAME,
    (SELECT MAX(SALARY) FROM EMPLOYEES) - EMP.SALARY AS SALARY_DIFFERENCE
FROM EMPLOYEES EMP
LEFT JOIN JOBS ON EMP.JOB_ID = JOBS.JOB_ID;



/*---------------------------------------------------------------------------
 * 15. Write a SQL query to calculate the average salary, 
   the number of employees receiving commissions in that department. 
   Return department name, average salary and number of employees.
*/

SELECT
    DEP.DEPARTMENT_NAME,
    NVL(TO_CHAR(CEIL(AVG(EMP.SALARY))), 'NO DATA') AS AVG_SALARY,
    COUNT(EMPLOYEE_ID) AS EMP_NUMBER
FROM DEPARTMENTS DEP 
LEFT JOIN EMPLOYEES EMP ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID
GROUP BY 
    DEP.DEPARTMENT_NAME;



/*---------------------------------------------------------------------------
 * 16. Write a SQL query to find the name of the country and departments, which are running there.
*/
 
SELECT 
    COUNTRY_NAME,
    LISTAGG(DEPARTMENT_NAME, ', ') WITHIN GROUP (ORDER BY DEPARTMENT_NAME) AS DEP_NAME
FROM DEPARTMENTS DEP 
LEFT JOIN LOCATIONS LOC ON DEP.LOCATION_ID = LOC.LOCATION_ID
LEFT JOIN COUNTRIES CNT ON LOC.COUNTRY_ID = CNT.COUNTRY_ID
GROUP BY COUNTRY_NAME;



/*---------------------------------------------------------------------------
 * 17. Write a SQL query to find the department name and the full name 
   (first and last name) of the manager.
*/

SELECT 
    DISTINCT DEP.DEPARTMENT_NAME,
    MNG.FIRST_NAME || ' ' || MNG.LAST_NAME AS MANAGER
FROM DEPARTMENTS DEP
LEFT JOIN EMPLOYEES EMP ON EMP.MANAGER_ID = DEP.MANAGER_ID
LEFT JOIN EMPLOYEES MNG ON EMP.MANAGER_ID = MNG.EMPLOYEE_ID;



/*---------------------------------------------------------------------------
 * 18. Write a SQL query to calculate the average salary 
  of employees for each job title.
*/

SELECT 
    JOB_TITLE,
    CEIL(AVG(SALARY)) AS AVG_SALARY
FROM EMPLOYEES EMP
LEFT JOIN JOBS ON EMP.JOB_ID = JOBS.JOB_ID
GROUP BY JOB_TITLE;



/*---------------------------------------------------------------------------
 * 19. Write a SQL query to find the employees who earn $12000 or more. 
   Return employee ID, starting date, end date, job ID and department ID.
*/

SELECT 
    EMP.EMPLOYEE_ID,
    NVL(TO_CHAR(JOB_H.START_DATE), 'NO DATA') AS START_DATE_JOB,
    NVL(TO_CHAR(JOB_H.END_DATE), 'NO DATA') AS END_DATE_JOB,
    NVL(TO_CHAR(JOB_H.JOB_ID), 'NO DATA') AS ID_JOB,
    NVL(TO_CHAR(JOB_H.DEPARTMENT_ID), 'NO DATA') AS ID_DEPARTMENT
FROM EMPLOYEES EMP
LEFT JOIN JOB_HISTORY JOB_H ON EMP.JOB_ID = JOB_H.JOB_ID
WHERE EMP.SALARY > 1200;



/*---------------------------------------------------------------------------
 * 20. Write a SQL query to find out which departments have at least 
   two employees. Group the result set on country name and city. 
   Return country name, city, and number. 
*/

SELECT 
    COUNT(EMP.EMPLOYEE_ID) AS NUM_EMP,
    CNT.COUNTRY_NAME,
    LOC.CITY
FROM EMPLOYEES EMP
LEFT JOIN DEPARTMENTS DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
LEFT JOIN LOCATIONS LOC ON DEP.LOCATION_ID = LOC.LOCATION_ID
LEFT JOIN COUNTRIES CNT ON LOC.COUNTRY_ID = CNT.COUNTRY_ID
WHERE
    EMP.DEPARTMENT_ID IS NOT NULL
GROUP BY
    CNT.COUNTRY_NAME,
    LOC.CITY
HAVING 
    COUNT(EMP.EMPLOYEE_ID) > 2;



/*---------------------------------------------------------------------------
 * 21. Write a SQL query to find the department name, full name 
   (first and last name) of the manager and their city(department).
*/

SELECT 
    DISTINCT DEP.DEPARTMENT_NAME,
    CITY,
    MNG.FIRST_NAME || ' ' || MNG.LAST_NAME AS MANAGER
FROM DEPARTMENTS DEP
LEFT JOIN EMPLOYEES EMP ON EMP.MANAGER_ID = DEP.MANAGER_ID
LEFT JOIN EMPLOYEES MNG ON EMP.MANAGER_ID = MNG.EMPLOYEE_ID
LEFT JOIN LOCATIONS LOC ON LOC.LOCATION_ID = DEP.LOCATION_ID;



/*---------------------------------------------------------------------------
 * 22. Write a SQL query to calculate the number of days worked by employees in 
   a department of ID 80. Return employee ID, job title, number of days worked.
*/

SELECT
    JOBS.JOB_TITLE,
    JOB_H.EMPLOYEE_ID,
    CEIL(JOB_H.END_DATE - JOB_H.START_DATE) AS DAYS_WORKED
FROM JOBS
LEFT JOIN JOB_HISTORY JOB_H ON JOBS.JOB_ID = JOB_H.JOB_ID
WHERE JOB_H.DEPARTMENT_ID = 80;



/*---------------------------------------------------------------------------
 * 23. Write a SQL query to find full name (first and last name), and salary 
   of all employees working in any department in the city of London.
*/

SELECT 
    EMP.FIRST_NAME,
    EMP.LAST_NAME,
    EMP.SALARY,
    LOC.CITY
FROM EMPLOYEES EMP 
LEFT JOIN DEPARTMENTS DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
LEFT JOIN LOCATIONS LOC ON DEP.LOCATION_ID = LOC.LOCATION_ID
WHERE 
    REGEXP_LIKE(LOC.CITY, 'London');



/*---------------------------------------------------------------------------
 * 24. Write a SQL query to find full name (first and last name), job title, 
   start and end date of last jobs of employees who did not receive commissions.
*/

SELECT
    EMP.FIRST_NAME || ' ' || EMP.LAST_NAME,
    JOBS.JOB_TITLE,
    JOB_H.START_DATE,
    JOB_H.END_DATE
FROM EMPLOYEES EMP
LEFT JOIN JOBS ON EMP.JOB_ID = JOBS.JOB_ID
LEFT JOIN JOB_HISTORY JOB_H ON JOBS.JOB_ID = JOB_H.JOB_ID
WHERE
    COMMISSION_PCT IS NULL
ORDER BY
    EMP.FIRST_NAME || ' ' || EMP.LAST_NAME;



/*---------------------------------------------------------------------------
 * 25. Write a SQL query to find the department name, department ID, 
   and number of employees in each department.  
*/

SELECT
    DEP.DEPARTMENT_ID,
    DEP.DEPARTMENT_NAME,
    COUNT(EMPLOYEE_ID) AS EMP_NUM
FROM DEPARTMENTS DEP
LEFT JOIN EMPLOYEES EMP ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID
GROUP BY 
    DEP.DEPARTMENT_ID, DEP.DEPARTMENT_NAME;



/*---------------------------------------------------------------------------
 * 26. Write a SQL query to find out the full name (first and last name) 
   of the employee with ID and the name of the country where he/she 
   is currently employed.
*/

SELECT
    FIRST_NAME || LAST_NAME AS EMP_NAME,
    EMPLOYEE_ID,
    COUNTRY_NAME
FROM EMPLOYEES EMP 
LEFT JOIN DEPARTMENTS DEP ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
LEFT JOIN LOCATIONS LOC ON DEP.LOCATION_ID = LOC.LOCATION_ID
LEFT JOIN COUNTRIES CNT ON LOC.COUNTRY_ID = CNT.COUNTRY_ID;


