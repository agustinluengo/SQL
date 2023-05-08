'Query 1'
/* null values */

SELECT count(*)
FROM employees.employees
WHERE emp_no IS NULL OR birth_date IS NULL OR first_name IS NULL OR last_name IS NULL OR gender IS NULL OR hire_date IS NULL;

'Query 2'
/* Count total employees, men employees, women employees*/
SELECT COUNT(DISTINCT(emp_no)) AS amount_of_employees, 
(SELECT COUNT(DISTINCT(emp_no)) AS amount_of_employees FROM employees.employees WHERE gender = 'M') AS 'Male', 
(SELECT COUNT(DISTINCT(emp_no)) AS amount_of_employees FROM employees.employees WHERE gender = 'F') AS 'Female'
FROM employees.employees;

'Query 3'
/* max and min hire date*/
SELECT MAX(hire_date),MIN(hire_date)
FROM employees.employees;

'Query 4'
SELECT emp_no, CONCAT(first_name,' ',last_name) AS 'full_name', YEAR(hire_date) AS hiring,
CASE
	WHEN YEAR(hire_date) BETWEEN 1985 AND 1990 THEN 3
	WHEN YEAR(hire_date) BETWEEN 1991 AND 1995 THEN 2
ELSE 1
END AS tier
FROM employees.employees
/* HAVING tier = 3 */
ORDER BY tier DESC;



/* not working yet, I'm trying to have the employees' tier and count amount of ppl within each tier


WITH tiers AS 
(SELECT emp_no, CONCAT(first_name,' ',last_name) AS 'full_name' ,YEAR(hire_date) AS hiring,
CASE
	WHEN YEAR(hire_date) BETWEEN 1985 AND 1990 THEN 3
	WHEN YEAR(hire_date) BETWEEN 1991 AND 1995 THEN 2
ELSE 1
END AS tier
FROM employees.employees
ORDER BY tier)

SELECT COUNT(tier)
FROM employees.employees
GROUP BY tier

*/

'Query 6'
/* amount of employees and the avg salary by department */

SELECT d2.dept_name, COUNT(d1.emp_no) AS emp_n, ROUND(AVG(s.salary),2) AS avg_salary
FROM employees.dept_emp d1
LEFT JOIN employees.departments d2 ON d2.dept_no = d1.dept_no
LEFT JOIN employees.salaries s ON s.emp_no = d1.emp_no
GROUP BY d1.dept_no
ORDER BY emp_n DESC, avg_salary;


WITH depts AS
(SELECT d1.dept_no, d2.dept_name, emp_no FROM dept_emp d1 LEFT JOIN departments d2 ON d1.dept_no = d2.dept_no)

'Query 7'
/* Salary rank and department */

SELECT DISTINCT(s.emp_no),
CONCAT(e.first_name,' ',e.last_name) AS full_name,
FIRST_VALUE(s.salary) OVER (partition by emp_no order by salary DESC) AS 'salary', /* this statement is necessary because there are more than a salary for the same emp due to rises */
depts.dept_name
FROM employees.salaries s
LEFT JOIN employees.employees e ON e.emp_no = s.emp_no
LEFT JOIN depts ON s.emp_no = depts.emp_no 
ORDER BY salary DESC
LIMIT 50;
