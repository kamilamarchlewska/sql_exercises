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


    


/*---------------------------------------------------------------------------
 * 17. Write a SQL query to find the department name and the full name 
   (first and last name) of the manager.
*/





/*---------------------------------------------------------------------------
 * 18. Write a SQL query to calculate the average salary 
  of employees for each job title.
*/





/*---------------------------------------------------------------------------
 * 19. Write a SQL query to find the employees who earn $12000 or more. 
   Return employee ID, starting date, end date, job ID and department ID.
*/





/*---------------------------------------------------------------------------
 * 20. write a SQL query to find out which departments have at least 
   two employees. Group the result set on country name and city. 
   Return country name, city, and number. 
*/






/*---------------------------------------------------------------------------
 * 21. Write a SQL query to find the department name, full name 
   (first and last name) of the manager and their city.
*/






/*---------------------------------------------------------------------------
 * 22. Write a SQL query to calculate the number of days worked by employees in 
   a department of ID 80. Return employee ID, job title, number of days worked.
*/





/*---------------------------------------------------------------------------
 * 23. Write a SQL query to find full name (first and last name), and salary 
   of all employees working in any department in the city of London.
*/





/*---------------------------------------------------------------------------
 * 24. Write a SQL query to find full name (first and last name), job title, 
   start and end date of last jobs of employees who did not receive commissions.
*/





/*---------------------------------------------------------------------------
 * 25. Write a SQL query to find the department name, department ID, 
   and number of employees in each department.  
*/





/*---------------------------------------------------------------------------
 * 26. Write a SQL query to find out the full name (first and last name) 
   of the employee with an ID and the name of the country where he/she 
   is currently employed.
*/

