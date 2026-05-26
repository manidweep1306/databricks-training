
-- Q26: Find the city with the maximum number of students.
select 
    city,
    count(student_id) as student_count
from Student
where city is not null
group by city
order by student_count desc
limit 1;


-- Q27: Display all departments and their staff count, including empty departments.
select 
    d.department_id,
    d.department_name,
    count(st.staff_id) as staff_count
from Department d
left join Staff st on d.department_id = st.department_id
group by d.department_id, d.department_name
order by staff_count desc;


-- Q28: Find students who have failed in at least one subject (marks < 50).
select distinct
    s.student_id,
    s.student_name,
    d.department_name,
    s.cgpa
from Student s
left join Department d on s.department_id = d.department_id
join Mark m on s.student_id = m.student_id
where m.marks < 50
order by s.student_id;


-- Q29: Display staff hired before 2018.
select 
    staff_id,
    staff_name,
    designation,
    hire_date,
    d.department_name,
    salary
from Staff st
left join Department d on st.department_id = d.department_id
where year(hire_date) < 2018
order by hire_date;


-- Q30: Find departments where no staff salary is recorded as NULL.
select 
    d.department_id,
    d.department_name,
    count(st.staff_id) as staff_count
from Department d
left join Staff st on d.department_id = st.department_id
group by d.department_id, d.department_name
having count(case when st.salary is null then 1 end) = 0
order by staff_count desc;


-- Q31: Assign a row number to students ordered by CGPA.
select 
    row_number() over (order by s.cgpa desc nulls last) as row_num,
    s.student_id,
    s.student_name,
    d.department_name,
    s.cgpa
from Student s
left join Department d on s.department_id = d.department_id;


-- Q32: Rank students based on their CGPA.
select 
    rank() over (order by s.cgpa desc nulls last) as cgpa_rank,
    s.student_id,
    s.student_name,
    d.department_name,
    s.cgpa
from Student s
left join Department d on s.department_id = d.department_id
where s.cgpa is not null;


-- Q33: Display dense rank of staff salaries.
select 
    dense_rank() over (order by st.salary desc nulls last) as salary_dense_rank,
    st.staff_id,
    st.staff_name,
    d.department_name,
    st.salary
from Staff st
left join Department d on st.department_id = d.department_id
where st.salary is not null;


-- Q34: Find the top 3 highest scoring students.
with student_avg_marks as (
    select 
        s.student_id,
        s.student_name,
        d.department_name,
        round(avg(m.marks), 2) as avg_marks
    from Student s
    left join Department d on s.department_id = d.department_id
    join Mark m on s.student_id = m.student_id
    group by s.student_id, s.student_name, d.department_name
)
select * 
from student_avg_marks
order by avg_marks desc
limit 3;


-- Q35: Display running total of marks for each student (cumulative sum).
select 
    s.student_id,
    s.student_name,
    subj.subject_name,
    m.marks,
    m.exam_date,
    sum(m.marks) over (partition by s.student_id order by m.exam_date) as running_total
from Student s
join Mark m on s.student_id = m.student_id
join Subject subj on m.subject_id = subj.subject_id
order by s.student_id, m.exam_date;

-- Q36: Find the average marks for each subject.
select
    subj.subject_id,
    subj.subject_name,
    round(avg(m.marks), 2) as subject_avg_marks,
    count(m.marks) as marks_count
from Subject subj
left join Mark m on subj.subject_id = m.subject_id
group by subj.subject_id, subj.subject_name
order by subj.subject_id;

-- Q37: Display previous exam marks for each student using LAG().
select 
    s.student_id,
    s.student_name,
    m.exam_date,
    subj.subject_name,
    m.marks,
    lag(m.marks) over (partition by s.student_id order by m.exam_date) as previous_marks
from Student s
join Mark m on s.student_id = m.student_id
join Subject subj on m.subject_id = subj.subject_id
order by s.student_id, m.exam_date;

-- Q38: Display next exam marks for each student using LEAD().
select 
    s.student_id,
    s.student_name,
    m.exam_date,
    subj.subject_name,
    m.marks,
    lead(m.marks) over (partition by s.student_id order by m.exam_date) as next_marks
from Student s
join Mark m on s.student_id = m.student_id
join Subject subj on m.subject_id = subj.subject_id
order by s.student_id, m.exam_date;

-- Q39: Find the highest marks within each subject.
select 
    subj.subject_id,
    subj.subject_name,
    s.student_id,
    s.student_name,
    m.marks,
    max(m.marks) over (partition by subj.subject_id) as subject_max_marks
from Student s
join Mark m on s.student_id = m.student_id
join Subject subj on m.subject_id = subj.subject_id
order by subj.subject_id, m.marks desc;

-- Q40: Display cumulative average marks ordered by exam date.
select 
    s.student_id,
    s.student_name,
    m.exam_date,
    subj.subject_name,
    m.marks,
    round(avg(m.marks) over (partition by s.student_id order by m.exam_date), 2) as cumulative_avg
from Student s
join Mark m on s.student_id = m.student_id
join Subject subj on m.subject_id = subj.subject_id
order by s.student_id, m.exam_date;

-- Q41: Find the first student admitted in each department.
with ranked_students as (
    select 
        d.department_id,
        d.department_name,
        s.student_id,
        s.student_name,
        s.admission_year,
        row_number() over (partition by d.department_id order by s.admission_year asc, s.student_id asc) as admission_order
    from Department d
    left join Student s on d.department_id = s.department_id
)
select * from ranked_students
where admission_order = 1;

-- Q42: Display the latest hired staff member in each department.
with staff_ranking as (
    select 
        d.department_id,
        d.department_name,
        st.staff_id,
        st.staff_name,
        st.hire_date,
        row_number() over (partition by d.department_id order by st.hire_date desc nulls last) as hire_order
    from Department d
    left join Staff st on d.department_id = st.department_id
)
select * from staff_ranking where hire_order = 1;


-- Q43: Divide students into 4 groups (quartiles) based on CGPA.
select 
    ntile(4) over (order by s.cgpa desc nulls last) as cgpa_quartile,
    s.student_id,
    s.student_name,
    d.department_name,
    s.cgpa
from Student s
left join Department d on s.department_id = d.department_id
where s.cgpa is not null
order by cgpa_quartile, s.cgpa desc;


-- Q44: Find percentage rank of students based on CGPA (0 to 1 scale).
select 
    s.student_id,
    s.student_name,
    d.department_name,
    s.cgpa,
    round(100 * count(*) over (order by s.cgpa) / count(*) over(), 2) as percentile_rank
from Student s
left join Department d on s.department_id = d.department_id
where s.cgpa is not null
order by s.cgpa desc;


-- Q45: Show salaries ordered from highest to lowest with row number.
select 
    st.staff_id,
    st.staff_name,
    d.department_name,
    st.salary,
    row_number() over (order by st.salary desc) as salary_rank,
    round(100 * st.salary / sum(st.salary) over(), 2) as percentage_of_total
from Staff st
left join Department d on st.department_id = d.department_id
where st.salary is not null
order by st.salary desc;


-- Q46: Find subjects where a student's marks are above the subject average.
with subject_avg as (
    select 
        subject_id,
        round(avg(marks), 2) as avg_marks
    from Mark
    group by subject_id
)
select 
    s.student_id,
    s.student_name,
    subj.subject_name,
    m.marks,
    sa.avg_marks,
    round(m.marks - sa.avg_marks, 2) as above_average_by
from Student s
join Mark m on s.student_id = m.student_id
join Subject subj on m.subject_id = subj.subject_id
join subject_avg sa on subj.subject_id = sa.subject_id
where m.marks > sa.avg_marks
order by subj.subject_id, m.marks desc;


-- Q47: Find departments with above-average staff salary.
with dept_salary_calc as (
    select 
        d.department_id,
        d.department_name,
        round(avg(st.salary), 2) as dept_avg_salary,
        count(st.staff_id) as staff_count
    from Department d
    left join Staff st on d.department_id = st.department_id
    where st.salary is not null
    group by d.department_id, d.department_name
)
, overall_calc as (
    select round(avg(salary), 2) as overall_avg_salary
    from Staff
    where salary is not null
)
select 
    dsc.department_id,
    dsc.department_name,
    dsc.dept_avg_salary,
    oc.overall_avg_salary,
    round(dsc.dept_avg_salary - oc.overall_avg_salary, 2) as salary_difference,
    dsc.staff_count
from dept_salary_calc dsc, overall_calc oc
where dsc.dept_avg_salary > oc.overall_avg_salary
order by dsc.dept_avg_salary desc;


-- Q48: Display students who scored above their department average marks.
with dept_avg_marks as (
    select 
        d.department_id,
        round(avg(m.marks), 2) as dept_avg_marks
    from Department d
    left join Student s on d.department_id = s.department_id
    left join Mark m on s.student_id = m.student_id
    group by d.department_id
)
select 
    s.student_id,
    s.student_name,
    d.department_name,
    subj.subject_name,
    m.marks,
    dam.dept_avg_marks,
    round(m.marks - dam.dept_avg_marks, 2) as above_dept_avg_by
from Student s
join Department d on s.department_id = d.department_id
join Mark m on s.student_id = m.student_id
join Subject subj on m.subject_id = subj.subject_id
join dept_avg_marks dam on d.department_id = dam.department_id
where m.marks > dam.dept_avg_marks
order by d.department_id, m.marks desc;


-- Q49: Find the 3rd highest mark and show which students achieved it.
with distinct_marks as (
    select distinct m.marks
    from Mark m
    where m.marks is not null
    order by m.marks desc
    limit 1 offset 2
)
select 
    s.student_id,
    s.student_name,
    subj.subject_name,
    m.marks,
    'This is the 3rd highest mark' as mark_position
from Mark m
join Student s on m.student_id = s.student_id
join Subject subj on m.subject_id = subj.subject_id
join distinct_marks dm on m.marks = dm.marks
order by s.student_id;

-- Q50: Generate a comprehensive report with marks, averages, and rankings.
with dept_avg_calc as (
    select 
        department_id,
        round(avg(m.marks), 2) as dept_avg_marks
    from Student s
    left join Mark m on s.student_id = m.student_id
    group by department_id
),
overall_avg_calc as (
    select round(avg(marks), 2) as overall_avg_marks
    from Mark
    where marks is not null
)
select 
    s.student_id,
    s.student_name,
    d.department_name,
    subj.subject_name,
    m.exam_type,
    m.marks,
    dac.dept_avg_marks,
    oac.overall_avg_marks,
    rank() over (partition by d.department_id order by m.marks desc) as dept_rank,
    rank() over (order by m.marks desc) as overall_rank
from Student s
left join Department d on s.department_id = d.department_id
left join Mark m on s.student_id = m.student_id
left join Subject subj on m.subject_id = subj.subject_id
left join dept_avg_calc dac on d.department_id = dac.department_id
cross join overall_avg_calc oac
where m.marks is not null
order by d.department_name, m.marks desc;
