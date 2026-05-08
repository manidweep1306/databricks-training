-- SQL Joins Assignment – LEFT JOIN, RIGHT JOIN, FULL JOIN

-- 1. Display all students and the courses they are enrolled in. Include students who are not enrolled in any course.

SELECT s.student_name,
       c.course_name
FROM students s
LEFT JOIN enrollments e
    ON s.student_id = e.student_id
LEFT JOIN courses c
    ON e.course_id = c.course_id;


-- 2. Find all courses that currently have no students enrolled.

SELECT c.course_id,
       c.course_name
FROM courses c
LEFT JOIN enrollments e
    ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;


-- 3. Display all instructors and the courses they teach, including instructors who are not assigned to any course.

SELECT i.instructor_name,
       c.course_name
FROM courses c
RIGHT JOIN instructors i
    ON c.instructor_id = i.instructor_id;


-- 4. Find all courses that do not have an instructor assigned.

SELECT course_id,
       course_name
FROM courses
WHERE instructor_id IS NULL;


-- 5. Display all students and enrollment information using a RIGHT JOIN.

SELECT s.student_name,
       e.enrollment_id,
       e.course_id,
       e.enrollment_date
FROM enrollments e
RIGHT JOIN students s
    ON e.student_id = s.student_id;


-- 6. Find students who are not enrolled in any course.

SELECT s.student_name
FROM students s
LEFT JOIN enrollments e
    ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;


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


-- 8. Find all courses that have never appeared in the enrollments table.

SELECT c.course_name
FROM courses c
LEFT JOIN enrollments e
    ON c.course_id = e.course_id
WHERE e.course_id IS NULL;


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


-- Bonus Challenge: Write a query that lists every student and every course, even if there is no enrollment relationship between them.

SELECT s.student_name,
       c.course_name
FROM students s
CROSS JOIN courses c
ORDER BY s.student_name,
         c.course_name;
