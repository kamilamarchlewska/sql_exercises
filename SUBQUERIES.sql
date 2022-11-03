/*---------------------------------------------------------------------------
 * HR Database - SUBQUERIES: Exercises
 https://www.w3resource.com/sql-exercises/sql-subqueries-exercises.php
 * Author:  Kamila Marchlewska
 *---------------------------------------------------------------------------
*/


/*---------------------------------------------------------------------------
 * 1. Write a SQL query to find those employees who 
   receive a higher salary than the employee with ID 163. 
   Return first name, last name.
*/

SELECT
    FIRST_NAME,
    LAST_NAME--,
    --SALARY
FROM
    EMPLOYEES
WHERE
    SALARY > (SELECT SALARY 
                FROM EMPLOYEES 
                WHERE EMPLOYEE_ID = 163);



/*---------------------------------------------------------------------------
 * 2. Write a SQL query to find out which employees 
   have the same JOB_ID as the employee whose ID is 169. 
   Return first name, last name, department ID and job ID.
*/

SELECT
    FIRST_NAME,
    LAST_NAME,
    DEPARTMENT_ID,
    JOB_ID
FROM 
    EMPLOYEES
WHERE
    JOB_ID = (SELECT JOB_ID 
                FROM EMPLOYEES 
                WHERE EMPLOYEE_ID = 169);



/*---------------------------------------------------------------------------
 * 3. Write a SQL query to find those employees whose 
   salary matches the lowest salary of any of the departments. 
   Return first name, last name and department ID.
*/

SELECT 
    FIRST_NAME,
    LAST_NAME,
    DEPARTMENT_ID
FROM
    EMPLOYEES
WHERE
    SALARY = (SELECT MIN(SALARY) 
                FROM EMPLOYEES 
                WHERE DEPARTMENT_ID IS NOT NULL)



/*---------------------------------------------------------------------------
 * 4. From the following table, write a SQL query to find those employees 
   who earn more than the average salary. 
   Return employee ID, first name, last name.
*/

SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME
FROM
    EMPLOYEES
WHERE
    SALARY > (SELECT AVG(SALARY) 
                FROM EMPLOYEES)



/*---------------------------------------------------------------------------
 * 5. From the following table, write a SQL query to find those employees who 
   report to that manager whose first name is ‘Payam’. 
   Return first name, last name, employee ID and salary.
*/

SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    SALARY
FROM 
    EMPLOYEES
WHERE MANAGER_ID = (SELECT EMPLOYEE_ID 
                        FROM EMPLOYEES 
                        WHERE REGEXP_LIKE(FIRST_NAME, 'Payam'));



/*---------------------------------------------------------------------------
 * 6. Write a SQL query to find all those employees
   who work in the Finance department. 
   Return department ID, name(first&last), job ID.
*/

SELECT
    DEPARTMENT_ID,
    FIRST_NAME || ' ' || LAST_NAME,
    JOB_ID
FROM 
    EMPLOYEES 
WHERE
    DEPARTMENT_ID = (SELECT DEPARTMENT_ID 
                            FROM DEPARTMENTS 
                            WHERE REGEXP_LIKE(DEPARTMENT_NAME, 'Finance'));



/*---------------------------------------------------------------------------
 *  7. Write a SQL query to find the employee whose 
    salary is 3000 and reporting person’s ID is 121. Return all fields.
*/

SELECT
    *
FROM
    EMPLOYEES
WHERE
    MANAGER_ID = 121
AND
    SALARY = 3000;



/*---------------------------------------------------------------------------
 * 8. Write a SQL query to find those employees whose ID matches 
    any of the numbers 134, 159 and 183. Return all the fields.
*/

SELECT
    *
FROM
    EMPLOYEES
WHERE
    EMPLOYEE_ID IN (134,159,183);



/*---------------------------------------------------------------------------
 * 9. Write a SQL query to find those employees 
    whose salary is in the range of 1000, and 3000 
   (Begin and end values have included.). Return all the fields.
*/

SELECT
    *
FROM
    EMPLOYEES
WHERE
    SALARY BETWEEN 1000 AND 3000;



/*---------------------------------------------------------------------------
 * 10. Write a SQL query to find those employees whose salary falls 
   within the range of the smallest salary and 3500. 
   Return all the fields. 
*/

SELECT 
    *
FROM 
    EMPLOYEES
WHERE
    SALARY < 3500
ORDER BY
    SALARY;



/*---------------------------------------------------------------------------
 * 11. Write a SQL query to find those employees who do not work 
   in the departments where managers’IDs are between 100 and 200 
   (Begin and end values are included.). 
   Return all the fields of the employeess
*/

SELECT
    *
FROM
    EMPLOYEES
WHERE 
    DEPARTMENT_ID IN (SELECT DEPARTMENT_ID 
                        FROM EMPLOYEES 
                        WHERE MANAGER_ID BETWEEN 100 AND 200);



/*---------------------------------------------------------------------------
 * 12. Write a SQL query to find those employees 
   who get second-highest salary. Return all the fields of the employees.
*/

SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE_NUMBER,
    HIRE_DATE,
    JOB_ID,
    SALARY,
    COMMISSION_PCT,
    MANAGER_ID,
    DEPARTMENT_ID
FROM
    (SELECT 
        EMPLOYEE_ID, 
        FIRST_NAME, 
        LAST_NAME, 
        EMAIL, 
        PHONE_NUMBER, 
        HIRE_DATE, 
        JOB_ID, 
        SALARY, 
        COMMISSION_PCT, 
        MANAGER_ID, 
        DEPARTMENT_ID, 
        DENSE_RANK() OVER (ORDER BY SALARY DESC) AS RANKING 
    FROM 
        EMPLOYEES) RANK_SAL
WHERE
     RANK_SAL.RANKING = 2 ;



/*---------------------------------------------------------------------------
 * 13. Write a SQL query to find those employees 
   who work in the same department as 'Clara'.  
   Return first name, last name and hire date.
*/

SELECT
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE
FROM
    EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID 
                            FROM EMPLOYEES 
                            WHERE REGEXP_LIKE(FIRST_NAME, 'Clara'));



/*---------------------------------------------------------------------------
 * 14. Write a SQL query to find those employees 
   who work in a department where the employee’s first name contains 
   the letter 'T'. Return employee ID, first name and last name.  
*/

SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME
FROM
    EMPLOYEES
WHERE
    DEPARTMENT_ID IN (SELECT DISTINCT DEPARTMENT_ID 
                            FROM EMPLOYEES 
                            WHERE REGEXP_LIKE(FIRST_NAME, 'T'));



/*---------------------------------------------------------------------------
 * 15. Write a SQL query to find those employees 
   who earn more than the average salary and work in the same department as 
   an employee whose first name contains the letter 'J'. 
   Return employee ID, first name and salary.
*/

SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    SALARY
FROM
    EMPLOYEES
WHERE
    SALARY > (SELECT AVG(SALARY) 
                 FROM EMPLOYEES)
AND
    DEPARTMENT_ID IN (SELECT DISTINCT DEPARTMENT_ID 
                        FROM EMPLOYEES 
                        WHERE REGEXP_LIKE(FIRST_NAME, 'J'));



/*---------------------------------------------------------------------------
 * 16. Write a SQL query to find those employees 
   whose department is located at ‘Toronto’. 
   Return first name, last name, employee ID, job ID. 
*/





/*---------------------------------------------------------------------------
 * 17. Write a SQL query to find those employees 
   whose salary is lower than that of employees whose job title is ‘MK_MAN’. 
   Return employee ID, first name, last name, job ID.
*/





/*---------------------------------------------------------------------------
 * 18. Write a SQL query to find those employees 
   whose salary is lower than that of employees whose job title is "MK_MAN". 
   Exclude employees of Job title ‘MK_MAN’. 
   Return employee ID, first name, last name, job ID. 
*/





/*---------------------------------------------------------------------------
 * 19. Write a SQL query to find those employees 
   whose salary exceeds the salary of all those employees whose job title 
   is "PU_MAN". Exclude job title ‘PU_MAN’. 
   Return employee ID, first name, last name, job ID.
*/





/*---------------------------------------------------------------------------
 * 20. Write a SQL query to find those employees 
   whose salaries are higher than the average for all departments. 
   Return employee ID, first name, last name, job ID.
*/





/*---------------------------------------------------------------------------
 * 21. Write a SQL query to check whether there are 
   any employees with salaries exceeding 3700. 
   Return first name, last name and department ID.
*/






/*---------------------------------------------------------------------------
 * 22. Write a SQL query to calculate total salary 
   of the departments where at least one employee works. 
   Return department ID, total salary. 
*/






/*---------------------------------------------------------------------------
 * 23. Write a query to display the employee id,name (first name and last name)
   and the job id column with a modified title SALESMAN for those employees 
   whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG. 
*/





/*---------------------------------------------------------------------------
 * 24. Write a query to display the employee id,name (first name and last name), 
   salary and the SalaryStatus column with a title HIGH and LOW respectively 
   for those employees whose salary is more than and less than the average 
   salary of all employees. 
*/





/*---------------------------------------------------------------------------
 * 25. Write a query to display the employee id,name (first name and last name), 
   SalaryDrawn, AvgCompare (salary - the average salary of all employees) 
   and the SalaryStatus column with a title HIGH and LOW respectively for those 
   employees whose salary is more than and less than the average 
   salary of all employees.
*/





/*---------------------------------------------------------------------------
 * 26. Write a SQL query to find all those departments where 
   at least one employee is employed. Return department name.  
*/





/*---------------------------------------------------------------------------
 * 27. Write a SQL query to find employees who work 
   in departments located in the United Kingdom. Return first name. 
*/






/*---------------------------------------------------------------------------
 * 28. Write a SQL query to find out which employees are earning more than 
   the average salary and who work in any of the IT departments. 
   Return last name, employee_id.
*/





/*---------------------------------------------------------------------------
 * 29. Write a SQL query to find all those employees 
   who earn more than an employee whose last name is 'Ozer'. 
   Sort the result in ascending order by last name. 
   Return first name, last name and salary.
*/




/*---------------------------------------------------------------------------
 * 30. Write a SQL query find the employees who report to a manager based 
   in the United States. Return first name, last name, employee id.
*/




/*---------------------------------------------------------------------------
 * 31. Write a SQL query to find those employees 
   whose salaries exceed 50% of their department's total salary bill. 
   Return first name, last name.
*/





/*---------------------------------------------------------------------------
 * 32. Write a SQL query to find those employees who are managers. 
   Return all the fields of employees table.
*/





/*---------------------------------------------------------------------------
 * 33. Write a SQL query to find those employees who manage a department. 
   Return all the fields of employees table.  
*/






/*---------------------------------------------------------------------------
 * 34. Write a SQL query to search for employees who receive such a salary, 
   which is the maximum salary for salaried employees, 
   hired between January 1st, 2002 and December 31st, 2003. 
   Return employee ID, first name, last name, salary, department name and city. 
*/





/*---------------------------------------------------------------------------
 * 35. Write a SQL query to find those departments that are located 
   in the city of London. Return department ID, department name.
*/





/*---------------------------------------------------------------------------
 * 36. Write a SQL query to find those employees who earn more than the average 
   salary. Sort the result-set in descending order by salary. 
   Return first name, last name, salary, and department ID. 
*/





/*---------------------------------------------------------------------------
 * 37. Write a SQL query to find those employees who earn more than the maximum 
   salary for a department of ID 40. Return first name, last name and 
   department ID. 
*/





/*---------------------------------------------------------------------------
 * 38. Write a SQL query to find departments for a particular location. 
   The location matches the location of the department of ID 30. 
   Return department name and department ID.
*/





/*---------------------------------------------------------------------------
 * 39. Write a SQL query to find employees who work for the department in which 
   employee ID 201 is employed. Return first name, last name, salary, 
   and department ID.
*/





/*---------------------------------------------------------------------------
 * 40. Write a SQL query to find those employees whose salary matches that of 
   the employee who works in department ID 40. 
   Return first name, last name, salary, and department ID. 
*/





/*---------------------------------------------------------------------------
 * 41. Write a SQL query to find those employees 
   who work in the department 'Marketing'. 
   Return first name, last name and department ID.
*/





/*---------------------------------------------------------------------------
 * 42. Write a SQL query to find those employees who earn more 
   than the minimum salary of a department of ID 40. 
   Return first name, last name, salary, and department ID.
*/





/*---------------------------------------------------------------------------
 * 43. Write a SQL query to find those employees who joined after the employee 
   whose ID is 165. Return first name, last name and hire date. 
*/





/*---------------------------------------------------------------------------
 * 44. Write a SQL query to find those employees who earn less than 
   the minimum salary of a department of ID 70. 
   Return first name, last name, salary, and department ID.
*/





/*---------------------------------------------------------------------------
 * 45. Write a SQL query to find those employees who earn less than 
   the average salary and work at the department where Laura (first name) 
   is employed. Return first name, last name, salary, and department ID. 
*/





/*---------------------------------------------------------------------------
 * 46. Write a SQL query to find all employees whose department is located 
   in London. Return first name, last name, salary, and department ID. 
*/





/*---------------------------------------------------------------------------
 * 47. Write a SQL query to find the city of the employee of ID 134.Return city.
*/





/*---------------------------------------------------------------------------
 * 48. Write a SQL query to find those departments where maximum salary 
   is 7000 and above. The employees worked in those departments have already 
   completed one or more jobs. Return all the fields of the departments
*/





/*---------------------------------------------------------------------------
 * 49. Write a SQL query to find those departments where the starting salary 
   is at least 8000. Return all the fields of departments.
*/





/*---------------------------------------------------------------------------
 * 50. Write a SQL query to find those managers who supervise four 
   or more employees. Return manager name, department ID.
*/





/*---------------------------------------------------------------------------
 * 51. Write a SQL query to find employees who have previously worked as 
   'Sales Representatives'. Return all the fields of jobs.
*/





/*---------------------------------------------------------------------------
 * 52. Write a SQL query to find those employees who earn the second-lowest 
   salary of all the employees. Return all the fields of employees.
*/





/*---------------------------------------------------------------------------
 * 53. Write a SQL query to find the departments managed by Susan. 
   Return all the fields of departments.
*/





/*---------------------------------------------------------------------------
 * 54. Write a SQL query to find those employees who earn the highest salary
   in a department. Return department ID, employee name, and salary.
*/





/*---------------------------------------------------------------------------
 * 55. Write a SQL query to find those employees who have not had 
   a job in the past. Return all the fields of employees.
*/





