-- 1. Select all columns from the Employee table.
SELECT * FROM Employee;

-- 2. Select only the name and salary columns from the Employee table.
SELECT name, salary FROM Employee;

-- 3. Select employees who are older than 30.
SELECT name, emp_id FROM Employee WHERE age > 30;

-- 4. Select the names of all departments.
SELECT name FROM Department;

-- 5. Select employees who work in the IT department.
SELECT name FROM Employee WHERE department_id = 1;

-- 6. Select employees whose names start with 'J'.
SELECT name FROM Employee WHERE name LIKE 'J%';

-- 7. Select employees whose names end with 'e'.
SELECT name FROM Employee WHERE name LIKE '%e';

-- 8. Select employees whose names contain 'a'.
SELECT name FROM Employee WHERE name LIKE '%a%';

-- 9. Select employees whose names are exactly 9 characters long.
SELECT name FROM Employee WHERE LENGTH(name) = 9;

-- 10. Select employees whose names have 'o' as the second character.
SELECT name FROM Employee WHERE name LIKE '_o%';

-- 11. Select employees hired in the year 2020.
SELECT name FROM Employee WHERE YEAR(hire_date) = 2020;

-- 12. Select employees hired in January of any year.
SELECT name FROM Employee WHERE MONTH(hire_date) = 1;

-- 13. Select employees hired before 2019.
SELECT name FROM Employee WHERE hire_date < '2019-01-01';

-- 14. Select employees hired on or after March 1, 2021.
SELECT name FROM Employee WHERE hire_date >= '2021-03-01';

-- 15. Select employees hired in the last 2 years.
SELECT name FROM Employee WHERE hire_date >= CURRENT_DATE - 2;

-- 16. Select the total salary of all employees.
SELECT SUM(salary) FROM Employee;

-- 17. Select the average salary of employees.
SELECT AVG(salary) FROM Employee;

-- 18. Select the minimum salary in the Employee table.
SELECT MIN(salary) FROM Employee;

-- 19. Select the number of employees in each department.
SELECT department_id, COUNT(emp_id) FROM Employee GROUP BY department_id;

-- 20. Select the average salary of employees in each department.
SELECT department_id, AVG(salary) FROM Employee GROUP BY department_id;

-- 21. Select the total salary for each department.
SELECT department_id, SUM(salary) FROM Employee GROUP BY department_id;

-- 22. Select the average age of employees in each department.
SELECT department_id, AVG(age) FROM Employee GROUP BY department_id;

-- 23. Select the number of employees hired in each year.
SELECT YEAR(hire_date), COUNT(emp_id) FROM Employee GROUP BY YEAR(hire_date);

-- 24. Select the highest salary in each department.
SELECT department_id, MAX(salary) FROM Employee GROUP BY department_id;

-- 25. Select the department with the highest average salary.
SELECT department_id, AVG(salary) FROM Employee GROUP BY department_id ORDER BY AVG(salary) DESC LIMIT 1;

-- 26. Select departments with more than 2 employees.
SELECT department_id, COUNT(emp_id) FROM Employee GROUP BY department_id HAVING COUNT(emp_id) > 2;

-- 27. Select departments with an average salary greater than 55000.
SELECT department_id, AVG(salary) FROM Employee GROUP BY department_id HAVING AVG(salary) > 55000;

-- 29. Select departments with a total salary expense less than 100000.
SELECT department_id, SUM(salary) FROM Employee GROUP BY department_id HAVING SUM(salary) < 100000;

-- 30. Select departments with the maximum salary above 75000.
SELECT department_id, MAX(salary) FROM Employee GROUP BY department_id HAVING MAX(salary) > 75000;

-- 31. Select all employees ordered by their salary in ascending order.
SELECT * FROM Employee ORDER BY salary ASC;

-- 32. Select all employees ordered by their age in descending order.
SELECT * FROM Employee ORDER BY age DESC;

-- 33. Select all employees ordered by their hire date in ascending order.
SELECT * FROM Employee ORDER BY hire_date ASC;

-- 34. Select employees ordered by their department and then by their salary.
SELECT * FROM Employee ORDER BY department_id, salary;

-- 35. Select departments ordered by the total salary of their employees.
SELECT department_id, SUM(salary) FROM Employee GROUP BY department_id ORDER BY SUM(salary);

-- 36. Select employee names along with their department names.
SELECT e.name AS Employee_Name, d.name AS Department_Name FROM Employee e JOIN Department d ON e.department_id = d.department_id;

-- 37. Select project names along with the department names they belong to.
SELECT p.name AS Project_Name, d.name AS Department_Name FROM Project p JOIN Department d ON p.department_id = d.department_id;

-- 38. Select employee names and their corresponding project names.
SELECT e.name as Employee_Name, p.name as Project_Name FROM Employee e JOIN Project p ON e.department_id = p.department_id;

-- 39. Select all employees and their departments, including those without a department.
SELECT e.name as Employee_Name, d.name as Department_Name FROM Employee e LEFT JOIN Department d ON e.department_id = d.department_id;

-- 40. Select all departments and their employees, including departments without employees.
SELECT d.name as Department_Name, e.name as Employee_Name FROM Department d LEFT JOIN Employee e ON d.department_id = e.department_id;

-- 41. Select employees who are not assigned to any project.
SELECT name FROM Employee WHERE department_id NOT IN (SELECT DISTINCT department_id FROM Project WHERE department_id IS NOT NULL);

-- 42. Select employees and the number of projects their department is working on.
SELECT e.name, (SELECT COUNT(*) FROM Project p WHERE p.department_id = e.department_id) AS Project_Count FROM Employee e;

-- 43. Select the departments that have no employees.
SELECT d.name FROM Department d LEFT JOIN Employee e ON d.department_id = e.department_id WHERE e.emp_id IS NULL;

-- 44. Select employee names who share the same department with 'John Doe'.
SELECT name FROM Employee WHERE department_id = (SELECT department_id FROM Employee WHERE name = 'John Doe') AND name != 'John Doe';

-- 45. Select the department name with the highest average salary.
SELECT d.name FROM Department d JOIN Employee e ON d.department_id = e.department_id  GROUP BY d.name ORDER BY AVG(e.salary) DESC LIMIT 1;

-- 46. Select the employee with the highest salary.
SELECT name FROM Employee WHERE salary = (SELECT MAX(salary) FROM Employee);

-- 47. Select employees whose salary is above the average salary.
SELECT name FROM Employee WHERE salary > (SELECT AVG(salary) FROM Employee);

-- 48. Select the second highest salary from the Employee table.
SELECT DISTINCT salary FROM Employee ORDER BY salary DESC LIMIT 1 OFFSET 1;

-- 49. Select the department with the most employees.
SELECT department_id FROM Employee GROUP BY department_id ORDER BY COUNT(*) DESC LIMIT 1;

-- 50. Select employees who earn more than the average salary of their department.
SELECT e1.name FROM Employee e1 WHERE e1.salary > (SELECT AVG(e2.salary) FROM Employee e2 WHERE e2.department_id = e1.department_id);

-- 51. Select the nth highest salary (e.g., 3rd highest).
SELECT DISTINCT salary FROM Employee ORDER BY salary DESC LIMIT 1 OFFSET 2;

-- 52. Select employees who are older than all employees in the HR department.
SELECT name FROM Employee WHERE age > (SELECT MAX(age) FROM Employee e JOIN Department d ON e.department_id = d.department_id WHERE d.name = 'HR');

-- 53. Select departments where the average salary is greater than 55000.
SELECT d.name FROM Department d JOIN Employee e ON d.department_id = e.department_id GROUP BY d.name HAVING AVG(e.salary) > 55000;

-- 54. Select employees who work in a department with at least 2 projects.
SELECT e.name FROM Employee e WHERE e.department_id IN (SELECT department_id FROM Project GROUP BY department_id HAVING COUNT(*) >= 2);

-- 55. Select employees who were hired on the same date as 'Jane Smith'.
SELECT name FROM Employee WHERE hire_date = (SELECT hire_date FROM Employee WHERE name = 'Jane Smith') AND name != 'Jane Smith';

-- 56. Select the total salary of employees hired in the year 2020.
SELECT SUM(salary) FROM Employee WHERE YEAR(hire_date) = 2020;

-- 57. Select the average salary of employees in each department, ordered by average salary DESC.
SELECT department_id, AVG(salary) FROM Employee GROUP BY department_id ORDER BY AVG(salary) DESC;

-- 58. Select departments with more than 1 employee and an average salary > 55000.
SELECT department_id FROM Employee GROUP BY department_id HAVING COUNT(emp_id) > 1 AND AVG(salary) > 55000;

-- 59. Select employees hired in the last 2 years, ordered by hire date.
SELECT name, hire_date FROM Employee WHERE hire_date >= CURRENT_DATE - INTERVAL 2 YEAR ORDER BY hire_date;

-- 60. Select total employees and average salary for departments with more than 2 employees.
SELECT COUNT(emp_id), AVG(salary) FROM Employee GROUP BY department_id HAVING COUNT(emp_id) > 2;

-- 61. Select name and salary of employees whose salary is above the average of their department.
SELECT name, salary FROM Employee e1 WHERE salary > (SELECT AVG(salary) FROM Employee e2 WHERE e1.department_id = e2.department_id);

-- 62. Select names of employees hired on the same date as the oldest employee.
SELECT name FROM Employee WHERE hire_date = (SELECT hire_date FROM Employee WHERE age = (SELECT MAX(age) FROM Employee));

-- 63. Select department names with total number of projects, ordered by project count.
SELECT d.name, COUNT(p.project_id) FROM Department d LEFT JOIN Project p ON d.department_id = p.department_id GROUP BY d.name ORDER BY COUNT(p.project_id);

-- 64. Select the employee name with the highest salary in each department.
SELECT name FROM Employee e1 WHERE salary = (SELECT MAX(salary) FROM Employee e2 WHERE e1.department_id = e2.department_id);

-- 65. Select names and salaries of employees older than the average age of their department.
SELECT name, salary FROM Employee e1 WHERE age > (SELECT AVG(age) FROM Employee e2 WHERE e1.department_id = e2.department_id);