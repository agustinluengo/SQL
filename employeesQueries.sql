'Query 1'
''Show the different average salaries for each title''

SELECT t.title, AVG(s.salary) AS 
FROM salaries s
RIGHT JOIN titles t ON t.emp_no = s.emp_no
GROUP BY t.title
ORDER BY ttl_amt DESC

