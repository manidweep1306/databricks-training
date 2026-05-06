**Schema (MySQL v5.7)**

    CREATE TABLE Department (
        department_id INT,
        name VARCHAR(50)
    );
    
    CREATE TABLE Employee (
        emp_id INT,
        name VARCHAR(100),
        age INT,
        salary INT,
        department_id INT,
        hire_date DATE
    );
    
    CREATE TABLE Project (
        project_id INT,
        name VARCHAR(100),
        department_id INT
    );
    
    INSERT INTO Department VALUES (1, 'IT'), (2, 'HR'), (3, 'Finance'), (4, 'Marketing');
    
    INSERT INTO Employee VALUES 
    (1, 'John Doe', 28, 50000, 1, '2020-01-15'),
    (2, 'Jane Smith', 34, 60000, 2, '2019-07-23'),
    (3, 'Bob Brown', 45, 80000, 1, '2018-02-12'),
    (4, 'Alice Blue', 25, 45000, 3, '2021-03-22'),
    (5, 'Charlie P.', 29, 50000, 2, '2019-12-01');
    
    INSERT INTO Project VALUES 
    (1, 'Project Alpha', 1),
    (2, 'Project Beta', 2),
    (3, 'Project Gamma', 1),
    (4, 'Project Delta', 3),
    (5, 'Project Epsilon', 4);
    

---

**Query #1**

    -- Basic queries
    
    -- 1. Select all columns from the Employee table.
    SELECT * FROM Employee;

| emp_id | name       | age | salary | department_id | hire_date  |
| ------ | ---------- | --- | ------ | ------------- | ---------- |
| 1      | John Doe   | 28  | 50000  | 1             | 2020-01-15 |
| 2      | Jane Smith | 34  | 60000  | 2             | 2019-07-23 |
| 3      | Bob Brown  | 45  | 80000  | 1             | 2018-02-12 |
| 4      | Alice Blue | 25  | 45000  | 3             | 2021-03-22 |
| 5      | Charlie P. | 29  | 50000  | 2             | 2019-12-01 |

---
**Query #2**

    -- 2. Select only the name and salary columns from the Employee table.
    SELECT name, salary FROM Employee;

| name       | salary |
| ---------- | ------ |
| John Doe   | 50000  |
| Jane Smith | 60000  |
| Bob Brown  | 80000  |
| Alice Blue | 45000  |
| Charlie P. | 50000  |

---
**Query #3**

    -- 3. Select employees who are older than 30.
    SELECT * FROM Employee WHERE age > 30;

| emp_id | name       | age | salary | department_id | hire_date  |
| ------ | ---------- | --- | ------ | ------------- | ---------- |
| 2      | Jane Smith | 34  | 60000  | 2             | 2019-07-23 |
| 3      | Bob Brown  | 45  | 80000  | 1             | 2018-02-12 |

---
**Query #4**

    -- 4. Select the names of all departments.
    SELECT name FROM Department;

| name      |
| --------- |
| IT        |
| HR        |
| Finance   |
| Marketing |

---
**Query #5**

    -- 5. Select employees who work in the IT department.
    SELECT * FROM Employee WHERE department_id = 1;

| emp_id | name      | age | salary | department_id | hire_date  |
| ------ | --------- | --- | ------ | ------------- | ---------- |
| 1      | John Doe  | 28  | 50000  | 1             | 2020-01-15 |
| 3      | Bob Brown | 45  | 80000  | 1             | 2018-02-12 |

---
**Query #6**

    -- String matching queries
    
    -- 6. Select employees whose names start with 'J'.
    SELECT * FROM Employee WHERE name LIKE 'J%';

| emp_id | name       | age | salary | department_id | hire_date  |
| ------ | ---------- | --- | ------ | ------------- | ---------- |
| 1      | John Doe   | 28  | 50000  | 1             | 2020-01-15 |
| 2      | Jane Smith | 34  | 60000  | 2             | 2019-07-23 |

---
**Query #7**

    -- 7. Select employees whose names end with 'e'.
    SELECT * FROM Employee WHERE name LIKE '%e';

| emp_id | name       | age | salary | department_id | hire_date  |
| ------ | ---------- | --- | ------ | ------------- | ---------- |
| 1      | John Doe   | 28  | 50000  | 1             | 2020-01-15 |
| 4      | Alice Blue | 25  | 45000  | 3             | 2021-03-22 |

---
**Query #8**

    -- 8. Select employees whose names contain 'a'.
    SELECT * FROM Employee WHERE name LIKE '%a%';

| emp_id | name       | age | salary | department_id | hire_date  |
| ------ | ---------- | --- | ------ | ------------- | ---------- |
| 2      | Jane Smith | 34  | 60000  | 2             | 2019-07-23 |
| 4      | Alice Blue | 25  | 45000  | 3             | 2021-03-22 |
| 5      | Charlie P. | 29  | 50000  | 2             | 2019-12-01 |

---
**Query #9**

    -- 9. Select employees whose names are exactly 9 characters long.
    SELECT * FROM Employee WHERE LENGTH(name) = 9;

| emp_id | name      | age | salary | department_id | hire_date  |
| ------ | --------- | --- | ------ | ------------- | ---------- |
| 3      | Bob Brown | 45  | 80000  | 1             | 2018-02-12 |

---
**Query #10**

    -- 10. Select employees whose names have 'o' as the second character.
    SELECT * FROM Employee WHERE name LIKE '_o%';

| emp_id | name      | age | salary | department_id | hire_date  |
| ------ | --------- | --- | ------ | ------------- | ---------- |
| 1      | John Doe  | 28  | 50000  | 1             | 2020-01-15 |
| 3      | Bob Brown | 45  | 80000  | 1             | 2018-02-12 |

---
**Query #11**

    -- Date queries
    
    -- 11. Select employees hired in the year 2020.
    SELECT * FROM Employee WHERE hire_date LIKE '2020%';

| emp_id | name     | age | salary | department_id | hire_date  |
| ------ | -------- | --- | ------ | ------------- | ---------- |
| 1      | John Doe | 28  | 50000  | 1             | 2020-01-15 |

---
**Query #12**

    -- 12. Select employees hired in January of any year.
    SELECT * FROM Employee WHERE hire_date LIKE '%-01-%';

| emp_id | name     | age | salary | department_id | hire_date  |
| ------ | -------- | --- | ------ | ------------- | ---------- |
| 1      | John Doe | 28  | 50000  | 1             | 2020-01-15 |

---
**Query #13**

    -- 13. Select employees hired before 2019.
    SELECT * FROM Employee WHERE hire_date < '2019-01-01';

| emp_id | name      | age | salary | department_id | hire_date  |
| ------ | --------- | --- | ------ | ------------- | ---------- |
| 3      | Bob Brown | 45  | 80000  | 1             | 2018-02-12 |

---
**Query #14**

    -- 14. Select employees hired on or after March 1, 2021.
    SELECT * FROM Employee WHERE hire_date >= '2021-03-01';

| emp_id | name       | age | salary | department_id | hire_date  |
| ------ | ---------- | --- | ------ | ------------- | ---------- |
| 4      | Alice Blue | 25  | 45000  | 3             | 2021-03-22 |

---
**Query #15**

    -- 15. Select employees hired in the last 2 years.
    SELECT * FROM Employee 
    WHERE YEAR(hire_date) >= (SELECT MAX(YEAR(hire_date)) FROM Employee) - 1;

| emp_id | name       | age | salary | department_id | hire_date  |
| ------ | ---------- | --- | ------ | ------------- | ---------- |
| 1      | John Doe   | 28  | 50000  | 1             | 2020-01-15 |
| 4      | Alice Blue | 25  | 45000  | 3             | 2021-03-22 |

---
**Query #16**

    -- Aggregate queries
    
    -- 16. Select the total salary of all employees.
    SELECT SUM(salary) FROM Employee;

| SUM(salary) |
| ----------- |
| 285000      |

---
**Query #17**

    -- 17. Select the average salary of employees.
    SELECT AVG(salary) FROM Employee;

| AVG(salary) |
| ----------- |
| 57000.0     |

---
**Query #18**

    -- 18. Select the minimum salary in the Employee table.
    SELECT MIN(salary) FROM Employee;

| MIN(salary) |
| ----------- |
| 45000       |

---
**Query #19**

    -- 19. Select the number of employees in each department.
    SELECT department_id, COUNT(*) FROM Employee GROUP BY department_id;

| department_id | COUNT(*) |
| ------------- | -------- |
| 1             | 2        |
| 2             | 2        |
| 3             | 1        |

---
**Query #20**

    -- 20. Select the average salary of employees in each department.
    SELECT department_id, AVG(salary) FROM Employee GROUP BY department_id;

| department_id | AVG(salary) |
| ------------- | ----------- |
| 1             | 65000.0     |
| 2             | 55000.0     |
| 3             | 45000.0     |

---
**Query #21**

    -- Group By Queries
    
    -- 21. Select the total salary for each department.
    SELECT department_id, SUM(salary) FROM Employee GROUP BY department_id;

| department_id | SUM(salary) |
| ------------- | ----------- |
| 1             | 130000      |
| 2             | 110000      |
| 3             | 45000       |

---
**Query #22**

    -- 22. Select the average age of employees in each department.
    SELECT department_id, AVG(age) FROM Employee GROUP BY department_id;

| department_id | AVG(age) |
| ------------- | -------- |
| 1             | 36.5     |
| 2             | 31.5     |
| 3             | 25.0     |

---
**Query #23**

    -- 23. Select the number of employees hired in each year.
    SELECT YEAR(hire_date), COUNT(*) FROM Employee GROUP BY YEAR(hire_date);

| YEAR(hire_date) | COUNT(*) |
| --------------- | -------- |
| 2018            | 1        |
| 2019            | 2        |
| 2020            | 1        |
| 2021            | 1        |

---
**Query #24**

    -- 24. Select the highest salary in each department.
    SELECT department_id, MAX(salary) FROM Employee GROUP BY department_id;

| department_id | MAX(salary) |
| ------------- | ----------- |
| 1             | 80000       |
| 2             | 60000       |
| 3             | 45000       |

---
**Query #25**

    -- 25. Select the department with the highest average salary.
    SELECT department_id, AVG(salary) 
    FROM Employee 
    GROUP BY department_id 
    ORDER BY AVG(salary) DESC 
    LIMIT 1;

| department_id | AVG(salary) |
| ------------- | ----------- |
| 1             | 65000.0     |

---
**Query #26**

    -- Having queries
    
    -- 26. Select departments with more than 2 employees.
    SELECT department_id, COUNT(*) 
    FROM Employee 
    GROUP BY department_id 
    HAVING COUNT(*) > 2;

There are no results to be displayed.

---
**Query #27**

    -- 27. Select departments with an average salary greater than 55000.
    SELECT department_id, AVG(salary) 
    FROM Employee 
    GROUP BY department_id 
    HAVING AVG(salary) > 55000;

| department_id | AVG(salary) |
| ------------- | ----------- |
| 1             | 65000.0     |

---
**Query #28**

    -- 28. Select years with more than 1 employee hired.
    SELECT YEAR(hire_date), COUNT(*) 
    FROM Employee 
    GROUP BY YEAR(hire_date) 
    HAVING COUNT(*) > 1;

| YEAR(hire_date) | COUNT(*) |
| --------------- | -------- |
| 2019            | 2        |

---
**Query #29**

    -- 29. Select departments with a total salary expense less than 100000.
    SELECT department_id, SUM(salary) 
    FROM Employee 
    GROUP BY department_id 
    HAVING SUM(salary) < 100000;

| department_id | SUM(salary) |
| ------------- | ----------- |
| 3             | 45000       |

---
**Query #30**

    -- 30. Select departments with the maximum salary above 75000.
    SELECT department_id, MAX(salary) 
    FROM Employee 
    GROUP BY department_id 
    HAVING MAX(salary) > 75000;

| department_id | MAX(salary) |
| ------------- | ----------- |
| 1             | 80000       |

---
**Query #31**

    -- Order By Queries
    
    -- 31. Select all employees ordered by their salary in ascending order.
    SELECT * FROM Employee ORDER BY salary ASC;

| emp_id | name       | age | salary | department_id | hire_date  |
| ------ | ---------- | --- | ------ | ------------- | ---------- |
| 4      | Alice Blue | 25  | 45000  | 3             | 2021-03-22 |
| 1      | John Doe   | 28  | 50000  | 1             | 2020-01-15 |
| 5      | Charlie P. | 29  | 50000  | 2             | 2019-12-01 |
| 2      | Jane Smith | 34  | 60000  | 2             | 2019-07-23 |
| 3      | Bob Brown  | 45  | 80000  | 1             | 2018-02-12 |

---
**Query #32**

    -- 32. Select all employees ordered by their age in descending order.
    SELECT * FROM Employee ORDER BY age DESC;

| emp_id | name       | age | salary | department_id | hire_date  |
| ------ | ---------- | --- | ------ | ------------- | ---------- |
| 3      | Bob Brown  | 45  | 80000  | 1             | 2018-02-12 |
| 2      | Jane Smith | 34  | 60000  | 2             | 2019-07-23 |
| 5      | Charlie P. | 29  | 50000  | 2             | 2019-12-01 |
| 1      | John Doe   | 28  | 50000  | 1             | 2020-01-15 |
| 4      | Alice Blue | 25  | 45000  | 3             | 2021-03-22 |

---
**Query #33**

    -- 33. Select all employees ordered by their hire date in ascending order.
    SELECT * FROM Employee ORDER BY hire_date ASC;

| emp_id | name       | age | salary | department_id | hire_date  |
| ------ | ---------- | --- | ------ | ------------- | ---------- |
| 3      | Bob Brown  | 45  | 80000  | 1             | 2018-02-12 |
| 2      | Jane Smith | 34  | 60000  | 2             | 2019-07-23 |
| 5      | Charlie P. | 29  | 50000  | 2             | 2019-12-01 |
| 1      | John Doe   | 28  | 50000  | 1             | 2020-01-15 |
| 4      | Alice Blue | 25  | 45000  | 3             | 2021-03-22 |

---
**Query #34**

    -- 34. Select employees ordered by their department and then by their salary.
    SELECT * FROM Employee ORDER BY department_id, salary;

| emp_id | name       | age | salary | department_id | hire_date  |
| ------ | ---------- | --- | ------ | ------------- | ---------- |
| 1      | John Doe   | 28  | 50000  | 1             | 2020-01-15 |
| 3      | Bob Brown  | 45  | 80000  | 1             | 2018-02-12 |
| 5      | Charlie P. | 29  | 50000  | 2             | 2019-12-01 |
| 2      | Jane Smith | 34  | 60000  | 2             | 2019-07-23 |
| 4      | Alice Blue | 25  | 45000  | 3             | 2021-03-22 |

---
**Query #35**

    -- 35. Select departments ordered by the total salary of their employees.
    SELECT department_id, SUM(salary) 
    FROM Employee 
    GROUP BY department_id 
    ORDER BY SUM(salary);

| department_id | SUM(salary) |
| ------------- | ----------- |
| 3             | 45000       |
| 2             | 110000      |
| 1             | 130000      |

---
**Query #36**

    -- Join queries
    
    -- 36. Select employee names along with their department names.
    SELECT e.name AS Employee_Name, d.name AS Department_Name
    FROM Employee e
    JOIN Department d ON e.department_id = d.department_id;

| Employee_Name | Department_Name |
| ------------- | --------------- |
| John Doe      | IT              |
| Jane Smith    | HR              |
| Bob Brown     | IT              |
| Alice Blue    | Finance         |
| Charlie P.    | HR              |

---
**Query #37**

    -- 37. Select project names along with the department names they belong to.
    SELECT p.name AS Project_Name, d.name AS Department_Name
    FROM Project p
    JOIN Department d ON p.department_id = d.department_id;

| Project_Name    | Department_Name |
| --------------- | --------------- |
| Project Alpha   | IT              |
| Project Beta    | HR              |
| Project Gamma   | IT              |
| Project Delta   | Finance         |
| Project Epsilon | Marketing       |

---
**Query #38**

    -- 38. Select employee names and their corresponding project names.
    -- (Note: Employees are linked to projects via their department)
    SELECT e.name AS Employee_Name, p.name AS Project_Name
    FROM Employee e
    JOIN Project p ON e.department_id = p.department_id;

| Employee_Name | Project_Name  |
| ------------- | ------------- |
| John Doe      | Project Alpha |
| Bob Brown     | Project Alpha |
| Jane Smith    | Project Beta  |
| Charlie P.    | Project Beta  |
| John Doe      | Project Gamma |
| Bob Brown     | Project Gamma |
| Alice Blue    | Project Delta |

---
**Query #39**

    -- 39. Select all employees and their departments, including those without a department.
    SELECT e.name, d.name
    FROM Employee e
    LEFT JOIN Department d ON e.department_id = d.department_id;

| name       | name    |
| ---------- | ------- |
| John Doe   | IT      |
| Bob Brown  | IT      |
| Jane Smith | HR      |
| Charlie P. | HR      |
| Alice Blue | Finance |

---
**Query #40**

    -- 40. Select all departments and their employees, including departments without employees.
    SELECT d.name, e.name
    FROM Department d
    LEFT JOIN Employee e ON d.department_id = e.department_id;

| name      | name       |
| --------- | ---------- |
| IT        | John Doe   |
| HR        | Jane Smith |
| IT        | Bob Brown  |
| Finance   | Alice Blue |
| HR        | Charlie P. |
| Marketing |            |

---
**Query #41**

    -- 41. Select employees who are not assigned to any project.
    -- (Note: Finds employees in departments that have no projects listed in the Project table)
    SELECT e.name
    FROM Employee e
    LEFT JOIN Project p ON e.department_id = p.department_id
    WHERE p.project_id IS NULL;

There are no results to be displayed.

---
**Query #42**

    -- 42. Select employees and the number of projects their department is working on.
    SELECT e.name, COUNT(p.project_id) AS Project_Count
    FROM Employee e
    LEFT JOIN Project p ON e.department_id = p.department_id
    GROUP BY e.emp_id, e.name;

| name       | Project_Count |
| ---------- | ------------- |
| John Doe   | 2             |
| Jane Smith | 1             |
| Bob Brown  | 2             |
| Alice Blue | 1             |
| Charlie P. | 1             |

---
**Query #43**

    -- 43. Select the departments that have no employees.
    SELECT d.name
    FROM Department d
    LEFT JOIN Employee e ON d.department_id = e.department_id
    WHERE e.emp_id IS NULL;

| name      |
| --------- |
| Marketing |

---
**Query #44**

    -- 44. Select employee names who share the same department with 'John Doe'.
    SELECT name 
    FROM Employee 
    WHERE department_id = (SELECT department_id FROM Employee WHERE name = 'John Doe')
    AND name <> 'John Doe';

| name      |
| --------- |
| Bob Brown |

---
**Query #45**

    -- 45. Select the department name with the highest average salary.
    SELECT d.name
    FROM Department d
    JOIN Employee e ON d.department_id = e.department_id
    GROUP BY d.name
    ORDER BY AVG(e.salary) DESC
    LIMIT 1;

| name |
| ---- |
| IT   |

---
**Query #46**

    -- Nested and Correlated Queries
    
    -- 46. Select the employee with the highest salary.
    SELECT * FROM Employee 
    WHERE salary = (SELECT MAX(salary) FROM Employee);

| emp_id | name      | age | salary | department_id | hire_date  |
| ------ | --------- | --- | ------ | ------------- | ---------- |
| 3      | Bob Brown | 45  | 80000  | 1             | 2018-02-12 |

---
**Query #47**

    -- 47. Select employees whose salary is above the average salary.
    SELECT * FROM Employee 
    WHERE salary > (SELECT AVG(salary) FROM Employee);

| emp_id | name       | age | salary | department_id | hire_date  |
| ------ | ---------- | --- | ------ | ------------- | ---------- |
| 2      | Jane Smith | 34  | 60000  | 2             | 2019-07-23 |
| 3      | Bob Brown  | 45  | 80000  | 1             | 2018-02-12 |

---
**Query #48**

    -- 48. Select the second highest salary from the Employee table.
    SELECT MAX(salary) FROM Employee 
    WHERE salary < (SELECT MAX(salary) FROM Employee);

| MAX(salary) |
| ----------- |
| 60000       |

---
**Query #49**

    -- 49. Select the department with the most employees.
    SELECT department_id FROM Employee 
    GROUP BY department_id 
    ORDER BY COUNT(*) DESC 
    LIMIT 1;

| department_id |
| ------------- |
| 1             |

---
**Query #50**

    -- 50. Select employees who earn more than the average salary of their department.
    SELECT * FROM Employee e1 
    WHERE salary > (SELECT AVG(salary) FROM Employee e2 WHERE e2.department_id = e1.department_id);

| emp_id | name       | age | salary | department_id | hire_date  |
| ------ | ---------- | --- | ------ | ------------- | ---------- |
| 2      | Jane Smith | 34  | 60000  | 2             | 2019-07-23 |
| 3      | Bob Brown  | 45  | 80000  | 1             | 2018-02-12 |

---
**Query #51**

    -- 51. Select the nth highest salary (Example: 3rd highest).
    SELECT DISTINCT salary FROM Employee 
    ORDER BY salary DESC 
    LIMIT 1 OFFSET 2;

| salary |
| ------ |
| 50000  |

---
**Query #52**

    -- Offset 2 skips the first two to get the 3rd
    
    -- 52. Select employees who are older than all employees in the HR department.
    SELECT * FROM Employee 
    WHERE age > ALL (SELECT age FROM Employee WHERE department_id = 2);

| emp_id | name      | age | salary | department_id | hire_date  |
| ------ | --------- | --- | ------ | ------------- | ---------- |
| 3      | Bob Brown | 45  | 80000  | 1             | 2018-02-12 |

---
**Query #53**

    -- 53. Select departments where the average salary is greater than 55000.
    SELECT d.name FROM Department d
    WHERE (SELECT AVG(salary) FROM Employee e WHERE e.department_id = d.department_id) > 55000;

| name |
| ---- |
| IT   |

---
**Query #54**

    -- 54. Select employees who work in a department with at least 2 projects.
    SELECT * FROM Employee 
    WHERE department_id IN (SELECT department_id FROM Project GROUP BY department_id HAVING COUNT(*) >= 2);

| emp_id | name      | age | salary | department_id | hire_date  |
| ------ | --------- | --- | ------ | ------------- | ---------- |
| 1      | John Doe  | 28  | 50000  | 1             | 2020-01-15 |
| 3      | Bob Brown | 45  | 80000  | 1             | 2018-02-12 |

---
**Query #55**

    -- 55. Select employees who were hired on the same date as 'Jane Smith'.
    SELECT * FROM Employee 
    WHERE hire_date = (SELECT hire_date FROM Employee WHERE name = 'Jane Smith')
    AND name <> 'Jane Smith';

There are no results to be displayed.

---
**Query #56**

    -- Combined Moderate Difficulty Queries
    
    -- 56. Select the total salary of employees hired in the year 2020.
    SELECT SUM(salary) FROM Employee WHERE YEAR(hire_date) = 2020;

| SUM(salary) |
| ----------- |
| 50000       |

---
**Query #57**

    -- 57. Select the average salary of employees in each department, ordered by average salary descending.
    SELECT department_id, AVG(salary) as avg_sal
    FROM Employee 
    GROUP BY department_id 
    ORDER BY avg_sal DESC;

| department_id | avg_sal |
| ------------- | ------- |
| 1             | 65000.0 |
| 2             | 55000.0 |
| 3             | 45000.0 |

---
**Query #58**

    -- 58. Select departments with more than 1 employee and an average salary greater than 55000.
    SELECT department_id 
    FROM Employee 
    GROUP BY department_id 
    HAVING COUNT(*) > 1 AND AVG(salary) > 55000;

| department_id |
| ------------- |
| 1             |

---
**Query #59**

    -- 59. Select employees hired in the last 2 years of the data (2020-2021), ordered by hire date.
    SELECT * FROM Employee 
    WHERE YEAR(hire_date) >= 2020 
    ORDER BY hire_date;

| emp_id | name       | age | salary | department_id | hire_date  |
| ------ | ---------- | --- | ------ | ------------- | ---------- |
| 1      | John Doe   | 28  | 50000  | 1             | 2020-01-15 |
| 4      | Alice Blue | 25  | 45000  | 3             | 2021-03-22 |

---
**Query #60**

    -- 60. Select the total number of employees and the average salary for departments with more than 2 employees.
    SELECT COUNT(*) as total_emp, AVG(salary) as avg_sal
    FROM Employee 
    GROUP BY department_id 
    HAVING COUNT(*) > 2;

There are no results to be displayed.

---
**Query #61**

    -- 61. Select the name and salary of employees whose salary is above the average salary of their department.
    SELECT name, salary 
    FROM Employee e1 
    WHERE salary > (SELECT AVG(salary) FROM Employee e2 WHERE e2.department_id = e1.department_id);

| name       | salary |
| ---------- | ------ |
| Jane Smith | 60000  |
| Bob Brown  | 80000  |

---
**Query #62**

    -- 62. Select the names of employees who are hired on the same date as the oldest employee in the company.
    SELECT name 
    FROM Employee 
    WHERE hire_date = (SELECT MIN(hire_date) FROM Employee);

| name      |
| --------- |
| Bob Brown |

---
**Query #63**

    -- 63. Select the department names along with the total number of projects they are working on, ordered by the number of projects.
    SELECT d.name, COUNT(p.project_id) AS total_projects
    FROM Department d
    LEFT JOIN Project p ON d.department_id = p.department_id
    GROUP BY d.name
    ORDER BY total_projects;

| name      | total_projects |
| --------- | -------------- |
| HR        | 1              |
| Finance   | 1              |
| Marketing | 1              |
| IT        | 2              |

---
**Query #64**

    -- 64. Select the employee name with the highest salary in each department.
    SELECT name, department_id, salary
    FROM Employee e1
    WHERE salary = (SELECT MAX(salary) FROM Employee e2 WHERE e2.department_id = e1.department_id);

| name       | department_id | salary |
| ---------- | ------------- | ------ |
| Jane Smith | 2             | 60000  |
| Bob Brown  | 1             | 80000  |
| Alice Blue | 3             | 45000  |

---
**Query #65**

    -- 65. Select the names and salaries of employees who are older than the average age of employees in their department.
    SELECT name, salary 
    FROM Employee e1 
    WHERE age > (SELECT AVG(age) FROM Employee e2 WHERE e2.department_id = e1.department_id);

| name       | salary |
| ---------- | ------ |
| Jane Smith | 60000  |
| Bob Brown  | 80000  |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/vbSyE7jLUfzReeqGXjGtst/1)
