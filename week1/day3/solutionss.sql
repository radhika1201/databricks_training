-- List all students along with their department names.
select student_name,department_name from Student s join Department d on s.department_id=d.department_id;

-- Display all staff members and their department names, including staff without departments.
select staff_name,department_name from Staff s left join Department d on s.department_id=d.department_id;

-- Find all departments that currently have no students assigned.
select department_name from Department d left join Student s on d.department_id=s.department_id where s.student_id is null;

-- Show students who do not have any marks recorded.
select student_name from Student s left join Mark m on s.student_id=m.student_id where m.student_id is null;

-- Display subjects that are not assigned to any staff member.
select subject_name from Subject s left join Staff d on s.staff_id=d.staff_id where d.staff_id is null;

-- Find the average CGPA department-wise.
select department_name,avg(cgpa) from Student s join Department d on s.department_id=d.department_id group by department_name;

-- Display departments where the average CGPA is greater than 8.0.
select department_name,avg(cgpa) from Student s join Department d on s.department_id=d.department_id group by department_name having avg(cgpa)>8.0;

-- Find the total number of students in each department.
select department_name,count(student_id) from Student s join Department d on s.department_id=d.department_id group by department_name;

-- Display the highest and lowest marks scored in each subject.
select subject_name,max(marks),min(marks) from Subject s join Mark m on s.subject_id=m.subject_id group by subject_name;

-- Find students who scored more than 90 in any exam.
select student_name,marks from Student s join Mark m on s.student_id=m.student_id where marks>90;

-- Display the names of students who belong to the Computer Science department.
select student_name from Student s join Department d on s.department_id=d.department_id where department_name='Computer Science';

-- Find the number of subjects handled by each staff member.
select staff_name,count(subject_id) from Staff s join Subject d on d.staff_id=s.staff_id group by staff_name;

-- Display students along with the total marks they obtained across all subjects.
select student_name,sum(marks) from Student s join Mark m on m.student_id=s.student_id group by student_name;

-- Find departments with more than 2 staff members.
select department_name,count(staff_id) from Department d join Staff s on s.department_id=d.department_id group by department_name having count(staff_id)>2;

-- Display students whose CGPA is above the average CGPA.
select student_name,cgpa from Student where cgpa>(select avg(cgpa) from Student);

-- Find staff members earning more than the average salary of their department.
select staff_name,salary from Staff s where salary>(select avg(salary) from Staff where department_id=s.department_id);

-- Display the second highest salary among staff members.
select max(salary) from Staff where salary<(select max(salary) from Staff);

-- Find students who scored the highest marks in each subject.
select student_name,subject_id,marks from Student s join Mark m on m.student_id=s.student_id where marks in (select max(marks)from Mark group by subject_id);

-- Display all students and their marks, including students without marks.
select student_name,marks from Student s left join Mark m on m.student_id=s.student_id;

-- Find subjects where the average marks are below 70.
select subject_name,avg(marks) from Subject s join Mark m on m.subject_id=s.subject_id group by subject_name having avg(marks)<70;

-- Display students ordered by CGPA in descending order.
select student_name,cgpa from Student order by cgpa desc;

-- Find the total salary expenditure department-wise.
select department_name,sum(salary) from Department d join Staff s on s.department_id=d.department_id group by department_name;

-- Display departments where the total salary exceeds 200000.
select department_name,sum(salary)from Department d join Staff s on s.department_id=d.department_id group by department_name having sum(salary)>200000;

-- Find students admitted after 2021 and having CGPA above 7.5.
select student_name from Student where admission_year>2021 and cgpa>7.5;

-- Display the number of students admitted each year.
select admission_year,count(student_id) from Student group by admission_year;

-- Find the city with the maximum number of students.
select city,count(student_id)from Student group by city order by count(student_id) desc limit 1;

-- Display all departments and their staff count, including empty departments.
select department_name,count(staff_id) from Department d left join Staff s on s.department_id=d.department_id group by department_name;

-- Find students who have failed in at least one subject (marks < 50).
select student_name,marks from Student s join Mark m on m.student_id=s.student_id where marks<50;

-- Display staff hired before 2018.
select staff_name,hire_date from Staff where hire_date<'2018-01-01';

-- Find departments where no staff salary is recorded as NULL.
select department_name from Department d join Staff s on s.department_id=d.department_id group by department_name having count(case when salary is null then 1 end)=0;

-- Assign a row number to students ordered by CGPA.
select student_name,row_number() over(order by cgpa desc) as row_num from Student;

-- Rank students based on their CGPA.
select student_name,rank() over(order by cgpa desc) as rank_num from Student;

-- Display dense rank of staff salaries.
select staff_name,salary,
dense_rank() over(order by salary desc) as dense_rank_num from Staff;

-- Find the top 3 highest scoring students using window functions.
select student_name,total_marks
from
(
select student_name,sum(marks) as total_marks,
dense_rank() over(order by sum(marks) desc) as rnk
from Student s
join Mark m
on s.student_id=m.student_id
group by student_name
) a
where rnk<=3;

-- Display running total of marks for each student.
select student_id,marks,sum(marks) over(partition by student_id order by exam_date) as running_total from Mark;

-- Find the average marks for each subject using window functions.
select subject_id,marks,avg(marks) over(partition by subject_id) as avg_marks from Mark;

-- Display previous exam marks for each student using LAG().
select student_id,marks,lag(marks) over(partition by student_id order by exam_date) as previous_marks from Mark;

-- Display next exam marks for each student using LEAD().
select student_id,marks,lead(marks) over(partition by student_id order by exam_date) as next_exam_marks from Mark;

-- Find the highest marks within each subject using MAX() OVER().
select subject_id,marks,max(marks) over(partition by subject_id) as highest_marks from Mark;

-- Display cumulative average marks ordered by exam date.
select exam_date,marks,avg(marks) over(order by exam_date) as cumulative_avg from Mark;

-- Find the first student admitted in each department.
select student_name,department_id,admission_year
from
(
select student_name,department_id,admission_year,
row_number() over(partition by department_id order by admission_year) as rn
from Student
) a
where rn=1;

-- Display the latest hired staff member in each department.
select staff_name,department_id,hire_date
from
(
select staff_name,department_id,hire_date,
row_number() over(partition by department_id order by hire_date desc) as rn
from Staff
) a
where rn=1;

-- Divide students into 4 CGPA quartiles using NTILE().
select student_name,cgpa,
ntile(4) over(order by cgpa desc) as quartile
from Student;

-- Find percentage rank of students based on CGPA.
select student_name,cgpa,
percent_rank() over(order by cgpa desc) as percent_rank_num
from Student;

-- Display cumulative distribution of salaries.
select staff_name,salary,
cume_dist() over(order by salary desc) as cumulative_distribution
from Staff;

-- Find subjects where a student's marks are above the subject average.
select student_id,subject_id,marks
from
(
select student_id,subject_id,marks,
avg(marks) over(partition by subject_id) as avg_marks
from Mark
) a
where marks>avg_marks;

-- Find departments whose average staff salary is higher than overall average salary.
select department_name,avg(salary)from Department d join Staff s on s.department_id=d.department_id group by department_name having avg(salary)>(select avg(salary)from Staff);

-- Display students who scored above department average marks.
select student_name,marks
from
(
select student_name,marks,
avg(marks) over(partition by department_id) as avg_marks
from Student s
join Mark m
on s.student_id=m.student_id
) a
where marks>avg_marks;

-- Find the nth highest mark (3rd highest) using DENSE_RANK().
select marks
from
(
select marks,
dense_rank() over(order by marks desc) as rnk
from Mark
) a
where rnk=3;

-- Generate a report showing student name, department, subject, exam type, marks, department average, and overall rank.
select student_name,department_name,subject_name,exam_type,marks,
avg(marks) over(partition by department_name) as department_avg,
rank() over(order by marks desc) as overall_rank
from Student s
join Department d
on s.department_id=d.department_id
join Mark m
on s.student_id=m.student_id
join Subject sub
on m.subject_id=sub.subject_id;