**Schema (MySQL v5.7)**

    
    
    CREATE TABLE instructors (
        instructor_id INT PRIMARY KEY,
        instructor_name VARCHAR(100),
        department VARCHAR(100)
    );
    
    CREATE TABLE students (
        student_id INT PRIMARY KEY,
        student_name VARCHAR(100),
        email VARCHAR(100)
    );
    
    CREATE TABLE courses (
        course_id INT PRIMARY KEY,
        course_name VARCHAR(100),
        instructor_id INT NULL,
        FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
    );
    
    CREATE TABLE enrollments (
        enrollment_id INT PRIMARY KEY,
        student_id INT,
        course_id INT,
        enrollment_date DATE,
        FOREIGN KEY (student_id) REFERENCES students(student_id),
        FOREIGN KEY (course_id) REFERENCES courses(course_id)
    );
    
    -- Insert instructors
    INSERT INTO instructors VALUES
    (1, 'Sarah Connor', 'Databases'),
    (2, 'Michael Scott', 'Programming'),
    (3, 'Tony Stark', 'Cloud Computing'),
    (4, 'Bruce Wayne', 'Cyber Security');
    
    -- Insert students
    INSERT INTO students VALUES
    (1, 'Alice Johnson', 'alice@email.com'),
    (2, 'Bob Smith', 'bob@email.com'),
    (3, 'Charlie Brown', 'charlie@email.com'),
    (4, 'Diana Prince', 'diana@email.com'),
    (5, 'Ethan Hunt', 'ethan@email.com'),
    (6, 'Fiona Green', 'fiona@email.com');
    
    -- Insert courses
    INSERT INTO courses VALUES
    (101, 'SQL Basics', 1),
    (102, 'Python Fundamentals', 2),
    (103, 'Data Analytics', NULL),
    (104, 'Cloud Computing', 3),
    (105, 'Machine Learning', NULL),
    (106, 'Cyber Security', 4);
    
    -- Insert enrollments
    INSERT INTO enrollments VALUES
    (1, 1, 101, '2024-01-10'),
    (2, 1, 102, '2024-01-12'),
    (3, 2, 101, '2024-01-15'),
    (4, 3, 104, '2024-01-20'),
    (5, 4, 106, '2024-01-25');
    
    -- Notes:
    -- Student 5 and 6 are not enrolled in any course.
    -- Courses 103 and 105 have no instructor assigned.
    -- Courses 103 and 105 also have no enrollments.
    -- Instructor 4 teaches one course.
    

---

**Query #1**

    -- SQL Joins Assignment – LEFT JOIN, RIGHT JOIN, FULL JOIN
    
    -- 1. Display all students and the courses they are enrolled in. Include students who are not enrolled in any course.
    
    SELECT s.student_name,
           c.course_name
    FROM students s
    LEFT JOIN enrollments e
        ON s.student_id = e.student_id
    LEFT JOIN courses c
        ON e.course_id = c.course_id;

| student_name  | course_name         |
| ------------- | ------------------- |
| Alice Johnson | SQL Basics          |
| Alice Johnson | Python Fundamentals |
| Bob Smith     | SQL Basics          |
| Charlie Brown | Cloud Computing     |
| Diana Prince  | Cyber Security      |
| Ethan Hunt    |                     |
| Fiona Green   |                     |

---
**Query #2**

    -- 2. Find all courses that currently have no students enrolled.
    
    SELECT c.course_id,
           c.course_name
    FROM courses c
    LEFT JOIN enrollments e
        ON c.course_id = e.course_id
    WHERE e.enrollment_id IS NULL;

| course_id | course_name      |
| --------- | ---------------- |
| 103       | Data Analytics   |
| 105       | Machine Learning |

---
**Query #3**

    -- 3. Display all instructors and the courses they teach, including instructors who are not assigned to any course.
    
    SELECT i.instructor_name,
           c.course_name
    FROM courses c
    RIGHT JOIN instructors i
        ON c.instructor_id = i.instructor_id;

| instructor_name | course_name         |
| --------------- | ------------------- |
| Sarah Connor    | SQL Basics          |
| Michael Scott   | Python Fundamentals |
| Tony Stark      | Cloud Computing     |
| Bruce Wayne     | Cyber Security      |

---
**Query #4**

    -- 4. Find all courses that do not have an instructor assigned.
    
    SELECT course_id,
           course_name
    FROM courses
    WHERE instructor_id IS NULL;

| course_id | course_name      |
| --------- | ---------------- |
| 103       | Data Analytics   |
| 105       | Machine Learning |

---
**Query #5**

    -- 5. Display all students and enrollment information using a RIGHT JOIN.
    
    SELECT s.student_name,
           e.enrollment_id,
           e.course_id,
           e.enrollment_date
    FROM enrollments e
    RIGHT JOIN students s
        ON e.student_id = s.student_id;

| student_name  | enrollment_id | course_id | enrollment_date |
| ------------- | ------------- | --------- | --------------- |
| Alice Johnson | 1             | 101       | 2024-01-10      |
| Alice Johnson | 2             | 102       | 2024-01-12      |
| Bob Smith     | 3             | 101       | 2024-01-15      |
| Charlie Brown | 4             | 104       | 2024-01-20      |
| Diana Prince  | 5             | 106       | 2024-01-25      |
| Ethan Hunt    |               |           |                 |
| Fiona Green   |               |           |                 |

---
**Query #6**

    -- 6. Find students who are not enrolled in any course.
    
    SELECT s.student_name
    FROM students s
    LEFT JOIN enrollments e
        ON s.student_id = e.student_id
    WHERE e.enrollment_id IS NULL;

| student_name |
| ------------ |
| Ethan Hunt   |
| Fiona Green  |

---
**Query #7**

    -- 7. Use a FULL OUTER JOIN to display all students and enrollments, including unmatched rows from both tables.
    -- note: Full outer join is not there in mysql(DB FIDDLE)
    
    SELECT s.student_name,
           e.enrollment_id,
           e.course_id
    FROM students s
    LEFT JOIN enrollments e
        ON s.student_id = e.student_id
    
    UNION
    
    SELECT s.student_name,
           e.enrollment_id,
           e.course_id
    FROM students s
    RIGHT JOIN enrollments e
        ON s.student_id = e.student_id;

| student_name  | enrollment_id | course_id |
| ------------- | ------------- | --------- |
| Alice Johnson | 1             | 101       |
| Alice Johnson | 2             | 102       |
| Bob Smith     | 3             | 101       |
| Charlie Brown | 4             | 104       |
| Diana Prince  | 5             | 106       |
| Ethan Hunt    |               |           |
| Fiona Green   |               |           |

---
**Query #8**

    -- 8. Find all courses that have never appeared in the enrollments table.
    
    SELECT c.course_name
    FROM courses c
    LEFT JOIN enrollments e
        ON c.course_id = e.course_id
    WHERE e.course_id IS NULL;

| course_name      |
| ---------------- |
| Data Analytics   |
| Machine Learning |

---
**Query #9**

    -- 9. Display all instructors and courses using a FULL OUTER JOIN and identify unmatched rows.
    -- note: Full outer join is not there in mysql(DB FIDDLE)
    
    SELECT i.instructor_name,
           c.course_name
    FROM instructors i
    LEFT JOIN courses c
        ON i.instructor_id = c.instructor_id
    
    UNION
    
    SELECT i.instructor_name,
           c.course_name
    FROM instructors i
    RIGHT JOIN courses c
        ON i.instructor_id = c.instructor_id;

| instructor_name | course_name         |
| --------------- | ------------------- |
| Sarah Connor    | SQL Basics          |
| Michael Scott   | Python Fundamentals |
| Tony Stark      | Cloud Computing     |
| Bruce Wayne     | Cyber Security      |
|                 | Data Analytics      |
|                 | Machine Learning    |

---
**Query #10**

    -- 10. Create a report showing: student name, course name, and instructor name. Include rows even if course or instructor information is missing.
    
    SELECT s.student_name,
           c.course_name,
           i.instructor_name
    FROM students s
    LEFT JOIN enrollments e
        ON s.student_id = e.student_id
    LEFT JOIN courses c
        ON e.course_id = c.course_id
    LEFT JOIN instructors i
        ON c.instructor_id = i.instructor_id;

| student_name  | course_name         | instructor_name |
| ------------- | ------------------- | --------------- |
| Alice Johnson | SQL Basics          | Sarah Connor    |
| Alice Johnson | Python Fundamentals | Michael Scott   |
| Bob Smith     | SQL Basics          | Sarah Connor    |
| Charlie Brown | Cloud Computing     | Tony Stark      |
| Diana Prince  | Cyber Security      | Bruce Wayne     |
| Ethan Hunt    |                     |                 |
| Fiona Green   |                     |                 |

---
**Query #11**

    -- Bonus Challenge: Write a query that lists every student and every course, even if there is no enrollment relationship between them.
    
    SELECT s.student_name,
           c.course_name
    FROM students s
    CROSS JOIN courses c
    ORDER BY s.student_name,
             c.course_name;

| student_name  | course_name         |
| ------------- | ------------------- |
| Alice Johnson | Cloud Computing     |
| Alice Johnson | Cyber Security      |
| Alice Johnson | Data Analytics      |
| Alice Johnson | Machine Learning    |
| Alice Johnson | Python Fundamentals |
| Alice Johnson | SQL Basics          |
| Bob Smith     | Cloud Computing     |
| Bob Smith     | Cyber Security      |
| Bob Smith     | Data Analytics      |
| Bob Smith     | Machine Learning    |
| Bob Smith     | Python Fundamentals |
| Bob Smith     | SQL Basics          |
| Charlie Brown | Cloud Computing     |
| Charlie Brown | Cyber Security      |
| Charlie Brown | Data Analytics      |
| Charlie Brown | Machine Learning    |
| Charlie Brown | Python Fundamentals |
| Charlie Brown | SQL Basics          |
| Diana Prince  | Cloud Computing     |
| Diana Prince  | Cyber Security      |
| Diana Prince  | Data Analytics      |
| Diana Prince  | Machine Learning    |
| Diana Prince  | Python Fundamentals |
| Diana Prince  | SQL Basics          |
| Ethan Hunt    | Cloud Computing     |
| Ethan Hunt    | Cyber Security      |
| Ethan Hunt    | Data Analytics      |
| Ethan Hunt    | Machine Learning    |
| Ethan Hunt    | Python Fundamentals |
| Ethan Hunt    | SQL Basics          |
| Fiona Green   | Cloud Computing     |
| Fiona Green   | Cyber Security      |
| Fiona Green   | Data Analytics      |
| Fiona Green   | Machine Learning    |
| Fiona Green   | Python Fundamentals |
| Fiona Green   | SQL Basics          |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/vbSyE7jLUfzReeqGXjGtst/10)
