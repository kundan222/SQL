/*  HR Database Exercises  */
-- 1. Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name" 
USE hr;
SELECT first_name AS 'First Name',
	last_name AS 'Last Name'
From employees;

-- 2. Write a query to get unique department ID from employee table 
USE hr;
SELECT DISTINCT department_id
FROM employees;

-- 3. Write a query to get all employee details from the employee table order by first name, descending 
USE hr;
SELECT *
FROM employees
ORDER BY first_name DESC;

-- 4. Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is calculated as 15% of salary)
USE hr;
SELECT first_name,
       last_name,
       salary, 
       salary*1.15 AS PF  /* PF=salary + 15% of salary = 1.15* salary */
FROM employees;

-- 5. Write a query to get the employee ID, names (first_name, last_name), salary in ascending order of salary 
USE hr;
SELECT employee_id,
       first_name,
       last_name,
       salary
FROM employees
ORDER BY salary ASC;   /* by default ASC if not entered in ORDER BY manually  */

-- 6. Write a query to get the total salaries payable to employees 
USE hr;
SELECT SUM(salary) AS 'Total salary payable to employees'
FROM employees;

-- 7. Write a query to get the maximum and minimum salary from employees table 
USE hr;
SELECT MAX(salary) AS 'Maximum salary from employees table',
       MIN(salary) AS 'Minimum salary from employees table'
FROM employees;

-- 8. Write a query to get the average salary and number of employees in the employees table
USE hr;
SELECT AVG(salary) AS 'Average salary in the employees table',
       COUNT(DISTINCT employee_id) AS 'Number of employees in the employees table'     /*   as emplyee_id is unique to employee  */
FROM employees; 

-- 9. Write a query to get the number of employees working with the company 
USE hr;
SELECT COUNT(DISTINCT employee_id) AS 'number of employees working with company'    /*   as emplyee_id is unique to employee  */
FROM employees;

-- 10. Write a query to get the number of jobs available in the employees table 
USE hr;
SELECT COUNT(DISTINCT job_id) AS 'number of jobs available in the employees table'     /*   as job_id is unique to each job available  */
FROM employees;
    
-- 11. Write a query get all first name from employees table in upper case
USE hr;
SELECT UPPER(first_name) AS 'first name from employees table in upper case'        /* used aggregate function UPPER  */
FROM employees;

-- 12. Write a query to get the first 3 characters of first name from employees table 
USE hr;
SELECT SUBSTRING(first_name,1,3) AS 'first 3 characters of first name from employees table'   /* used aggregate function SUBSTRING where 1 represent start letter and 3 number of strings from there */
FROM employees;

-- 13. Write a query to get first name from employees table after removing white spaces from both side 
USE hr;
SELECT TRIM(first_name) AS 'first name from employees table after removing white spaces from both side'        /*   used aggregate function TRIM to remove white space from both side */
FROM employees;

-- 14. Write a query to get the length of the employee names (first_name, last_name) from employees table
USE hr;
SELECT first_name,
       last_name, 
       LENGTH(first_name)+LENGTH(last_name)  'Total Length of Names'   /* another format for using alias */
FROM employees;
    
-- 15.  Write a query to check if the first_name fields of the employees table contains numbers 
USE hr;
SELECT * 
FROM employees 
WHERE  first_name REGEXP  '[0-9]';       /* as no number in first_name answer will be null */
   
-- 16. Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000 
USE hr;
SELECT first_name, 
	   last_name, 
       salary
FROM employees
WHERE salary NOT BETWEEN 10000 AND 15000;

-- 17. Write a query to display the name (first_name, last_name) and department ID of all employees in departments 30 or 100 in ascending order 
USE hr;
SELECT first_name, 
       last_name, 
       department_id
FROM employees
WHERE department_id IN (30, 100)
ORDER BY  department_id  ASC;        /*    by default will also be in ascending if not entered manually */

-- 18. Write a query to display the name (first_name, last_name) and salary for all employees 
-- whose salary is not in the range $10,000 through $15,000 and are in department 30 or 100  
USE hr;
SELECT first_name, 
       last_name, 
       salary, 
       department_id
FROM employees
WHERE salary NOT BETWEEN 10000 AND 15000 
AND department_id IN (30, 100);

-- 19. Write a query to display the name (first_name, last_name) and hire date for all employees who were hired in 1987 
USE hr;
SELECT first_name, 
       last_name, 
       hire_date 
FROM employees 
WHERE YEAR(hire_date)  LIKE '1987%';

-- 20. Write a query to display the first_name of all employees who have both "b" and "c" in their first name 
USE hr;
SELECT first_name
FROM employees
WHERE first_name LIKE '%b%'
AND first_name LIKE '%c%';

-- 21. Write a query to display the last name, job, and salary for all employees whose job is that
-- of a Programmer or a Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,000 
USE hr;
SELECT last_name, 
       job_id, 
       salary
FROM employees
WHERE job_id IN ('IT_PROG', 'SH_CLERK')           /* each job has unique job_id */
AND salary NOT IN (4500,10000, 15000);

-- 22. Write a query to display the last name of employees whose names have exactly 6 characters 
USE hr;
SELECT last_name 
FROM employees 
WHERE last_name LIKE '______';    /*  six underscore for exact six characters */

-- 23. Write a query to display the last name of employees having 'e' as the third character 
USE hr;
SELECT last_name 
FROM employees 
WHERE last_name LIKE '__e%';

/*   24. Write a query to get the job_id and related employee's id 
     Partial output of the query :  
     job_id       Employees ID 
     AC_ACCOUNT    206 
     AC_MGR        205 
     AD_ASST       200 
     AD_PRES       100 
     AD_VP         101 ,102 
     FI_ACCOUNT    110 ,113 ,111 ,109 ,112        */
USE hr;
SELECT job_id, 
       GROUP_CONCAT(employee_id, ' ') AS 'Employees ID' 
FROM employees 
GROUP BY job_id;

-- 25. Write a query to update the portion of the phone_number in the employees table, within the phone number
-- the substring '124' will be replaced by '999' 
USE hr;
UPDATE employees 
SET phone_number = REPLACE(phone_number, '124', '999') 
WHERE phone_number LIKE '%124%';

-- 26. Write a query to get the details of the employees where the length of the first name greater than or equal to 8 
USE hr;
SELECT * 
FROM employees
WHERE LENGTH(first_name) >= 8;

-- 27. Write a query to append '@example.com' to email field 
USE hr;
UPDATE employees SET email = CONCAT(email, '@example.com');

-- 28. Write a query to extract the last 4 character of phone numbers
USE hr;
SELECT RIGHT(phone_number, 4) AS 'last 4 character of phone numbers' 
FROM employees;

-- 29. Write a query to get the last word of the street address 
USE hr;
SELECT location_id, 
       street_address, 
SUBSTRING_INDEX(REPLACE(REPLACE(REPLACE(street_address,',',' '),')',' '),'(',' '),' ',-1) 
AS 'Last--word-of-street_address' 
FROM locations;

-- 30. Write a query to get the locations that have minimum street length 
USE hr;
SELECT * 
FROM locations
WHERE LENGTH(street_address) <= (SELECT  MIN(LENGTH(street_address)) 
FROM locations);

-- 31. Write a query to display the first word from those job titles which contains more than one words 
USE hr;
SELECT job_title, 
       SUBSTR(job_title,1, INSTR(job_title, ' ')-1) AS 'first word from those job titles which contains more than one words'
FROM jobs;

-- 32. Write a query to display the length of first name for employees where last name contain character 'c' after 2nd position 
USE hr;
SELECT first_name,
       last_name 
FROM employees 
WHERE INSTR(last_name,'C') > 2;

-- 33. Write a query that displays the first name and the length of the first name for all employees whose name starts with the 
-- letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees' first names 
USE hr;
SELECT first_name "First Name",
       LENGTH(first_name) "Length"
FROM employees
WHERE first_name LIKE 'J%'
   OR first_name LIKE 'M%'
   OR first_name LIKE 'A%'
ORDER BY first_name ;

-- 34. Write a query to display the first name and salary for all employees. Format the salary to be 10 characters long, left-padded
-- with the $ symbol. Label the column SALARY 
USE hr;
SELECT first_name,
       LPAD(salary, 10, '$') 'SALARY'
FROM employees;

-- 35. Write a query to display the first eight characters of the employees' first names and indicates the amounts of their salaries 
-- with '$' sign. Each '$' sign signifies a thousand dollars. Sort the data in descending order of salary 
USE hr;
SELECT left(first_name, 8) 'first eight characters of the employees first names',
	   REPEAT('$', FLOOR(salary/1000))  'SALARY($)', 
       salary
FROM employees
ORDER BY salary DESC;

-- 36. Write a query to display the employees with their code, first name, last name and hire date who hired either on seventh day 
-- of any month or seventh month in any year
USE hr;
SELECT employee_id,
       first_name,
	   last_name,
       hire_date 
FROM employees 
WHERE POSITION("07" IN DATE_FORMAT(hire_date, '%d %m %Y'))>0;
