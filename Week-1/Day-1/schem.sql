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

