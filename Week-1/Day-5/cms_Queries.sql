
-- Q1: List all students along with their department names.
select 
    s.student_id,
    s.student_name,
    d.department_name,
    s.cgpa
from Student s
left join Department d on s.department_id = d.department_id
order by s.student_id;

-- Q2: Display all staff members and their department names, including staff without departments.
select 
    st.staff_id,
    st.staff_name,
    st.designation,
    d.department_name,
    st.salary
from Staff st
left join Department d on st.department_id = d.department_id
order by st.staff_id;

-- Q3: Find all departments that currently have no students assigned.
select 
    d.department_id,
    d.department_name,
    d.department_block_number
from Department d
left join Student s on d.department_id = s.department_id
where s.student_id is null
group by d.department_id, d.department_name, d.department_block_number;

-- Q4: Show students who do not have any marks recorded.
select 
    s.student_id,
    s.student_name,
    s.admission_year,
    d.department_name
from Student s
left join Department d on s.department_id = d.department_id
left join Mark m on s.student_id = m.student_id
where m.student_id is null
order by s.student_id;

-- Q5: Display subjects that are not assigned to any staff member.
select 
    subject_id,
    subject_name,
    subject_code,
    semester,
    credits
from Subject
where staff_id is null;

-- Q6: Find the average CGPA department-wise.
select 
    d.department_id,
    d.department_name,
    round(avg(s.cgpa), 2) as avg_cgpa,
    count(s.student_id) as student_count
from Department d
left join Student s on d.department_id = s.department_id
group by d.department_id, d.department_name
order by avg_cgpa desc nulls last;

-- Q7: Display departments where the average CGPA is greater than 8.0.
select 
    d.department_id,
    d.department_name,
    round(avg(s.cgpa), 2) as avg_cgpa
from Department d
left join Student s on d.department_id = s.department_id
group by d.department_id, d.department_name
having avg(s.cgpa) > 8.0
order by avg_cgpa desc;

-- Q8: Find the total number of students in each department.
select 
    d.department_id,
    d.department_name,
    count(s.student_id) as student_count
from Department d
left join Student s on d.department_id = s.department_id
group by d.department_id, d.department_name
order by student_count desc;

-- Q9: Display the highest and lowest marks scored in each subject.
select 
    subj.subject_id,
    subj.subject_name,
    max(m.marks) as highest_marks,
    min(m.marks) as lowest_marks,
    count(m.marks) as total_marks_recorded
from Subject subj
left join Mark m on subj.subject_id = m.subject_id
group by subj.subject_id, subj.subject_name
order by subj.subject_id;

-- Q10: Find students who scored more than 90 in any exam.
select distinct
    s.student_id,
    s.student_name,
    s.cgpa,
    max(m.marks) as highest_marks
from Student s
join Mark m on s.student_id = m.student_id
where m.marks > 90
group by s.student_id, s.student_name, s.cgpa
order by highest_marks desc;

-- Q11: Display the names of students who belong to the Computer Science department.
select 
    s.student_id,
    s.student_name,
    s.gender,
    s.city,
    s.cgpa
from Student s
where s.department_id = 1
order by s.student_id;

-- Q12: Find the number of subjects handled by each staff member.
select 
    st.staff_id,
    st.staff_name,
    st.designation,
    count(subj.subject_id) as subject_count
from Staff st
left join Subject subj on st.staff_id = subj.staff_id
group by st.staff_id, st.staff_name, st.designation
order by subject_count desc;

-- Q13: Display students along with the total marks they obtained across all subjects.
select 
    s.student_id,
    s.student_name,
    d.department_name,
    sum(m.marks) as total_marks,
    count(m.marks) as exam_count,
    round(avg(m.marks), 2) as avg_marks
from Student s
left join Department d on s.department_id = d.department_id
left join Mark m on s.student_id = m.student_id
group by s.student_id, s.student_name, d.department_name
order by total_marks desc nulls last;

-- Q14: Find departments with more than 2 staff members.
select 
    d.department_id,
    d.department_name,
    count(st.staff_id) as staff_count
from Department d
left join Staff st on d.department_id = st.department_id
group by d.department_id, d.department_name
having count(st.staff_id) > 2
order by staff_count desc;

-- Q15: Display students whose CGPA is above the average CGPA.
select 
    s.student_id,
    s.student_name,
    d.department_name,
    s.cgpa,
    round((select avg(cgpa) from Student where cgpa is not null), 2) as avg_cgpa
from Student s
left join Department d on s.department_id = d.department_id
where s.cgpa > (select avg(cgpa) from Student where cgpa is not null)
order by s.cgpa desc;

-- Q16: Find staff members earning more than the average salary of their department.
with dept_avg_salary as (
    select 
        department_id,
        avg(salary) as dept_avg_salary
    from Staff
    where salary is not null
    group by department_id
)
select 
    st.staff_id,
    st.staff_name,
    d.department_name,
    st.salary,
    round(das.dept_avg_salary, 2) as dept_avg_salary
from Staff st
left join Department d on st.department_id = d.department_id
left join dept_avg_salary das on st.department_id = das.department_id
where st.salary is not null and st.salary > das.dept_avg_salary
order by st.salary desc;

-- Q17: Display the second highest salary among staff members.
select 
    staff_id,
    staff_name,
    designation,
    salary
from Staff
where salary is not null
order by salary desc
limit 1 offset 1;

-- Q18: Find students who scored the highest marks in each subject.
with subject_max_marks as (
    select 
        subject_id,
        max(marks) as max_marks
    from Mark
    group by subject_id
)
select 
    s.student_id,
    s.student_name,
    subj.subject_name,
    m.marks,
    m.exam_type
from Mark m
join subject_max_marks smm on m.subject_id = smm.subject_id and m.marks = smm.max_marks
join Student s on m.student_id = s.student_id
join Subject subj on m.subject_id = subj.subject_id
order by subj.subject_id;

-- Q19: Display all students and their marks, including students without marks.
select 
    s.student_id,
    s.student_name,
    d.department_name,
    subj.subject_name,
    m.exam_type,
    m.marks,
    m.exam_date
from Student s
left join Department d on s.department_id = d.department_id
left join Mark m on s.student_id = m.student_id
left join Subject subj on m.subject_id = subj.subject_id
order by s.student_id, m.exam_date;

-- Q20: Find subjects where the average marks are below 70.
select 
    subj.subject_id,
    subj.subject_name,
    subj.subject_code,
    round(avg(m.marks), 2) as avg_marks,
    count(m.marks) as total_marks_recorded
from Subject subj
left join Mark m on subj.subject_id = m.subject_id
group by subj.subject_id, subj.subject_name, subj.subject_code
having avg(m.marks) < 70
order by avg_marks;

-- Q21: Display students ordered by CGPA in descending order.
select 
    s.student_id,
    s.student_name,
    d.department_name,
    s.cgpa,
    s.admission_year
from Student s
left join Department d on s.department_id = d.department_id
where s.cgpa is not null
order by s.cgpa desc;

-- Q22: Find the total salary expenditure department-wise.
select 
    d.department_id,
    d.department_name,
    round(sum(st.salary), 2) as total_salary,
    count(st.staff_id) as staff_count
from Department d
left join Staff st on d.department_id = st.department_id
group by d.department_id, d.department_name
order by total_salary desc nulls last;

-- Q23: Display departments where the total salary exceeds 200000.
select 
    d.department_id,
    d.department_name,
    round(sum(st.salary), 2) as total_salary,
    count(st.staff_id) as staff_count
from Department d
left join Staff st on d.department_id = st.department_id
group by d.department_id, d.department_name
having sum(st.salary) > 200000
order by total_salary desc;

-- Q24: Find students admitted after 2021 and having CGPA above 7.5.
select 
    s.student_id,
    s.student_name,
    d.department_name,
    s.admission_year,
    s.cgpa
from Student s
left join Department d on s.department_id = d.department_id
where s.admission_year > 2021 and s.cgpa > 7.5
order by s.cgpa desc;

-- Q25: Display the number of students admitted each year.
select 
    admission_year,
    count(student_id) as student_count
from Student
where admission_year is not null
group by admission_year
order by admission_year desc;
