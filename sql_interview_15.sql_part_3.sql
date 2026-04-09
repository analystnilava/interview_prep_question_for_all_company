-- 30> Display employee hired on the same date 
select hire_date , count(*)
from employees
group by hire_date
having count(*) > 1;

-- 31> get all employee from the sales  department 
select * from employees
where department = 'Sales';
-- 32> find the employee earning more than 50000
 select * from employees
 where salary > 50000;
-- 33> get all employee whose name start with c
select * from employees
 where firstname LIKE 'c%';
 -- 34> find the employee hired after 2020
 select * from employees
 where hire_date > 2020;
 
 -- 35> list employee who not have manager
 select e.* from employees e
 left join employees m
 on e.managerid = m.employeeid
 where e.managerid is null;
 
 -- 36> display the employee order by salary
  select e.* from employees e
  order by e.salary desc;
  
  -- 37 > sort employee by depatment name and than salary
  select e.* , d.department_name from  employees e
 left join department d
on d.department_id = e.department_id 
order by (d.department_name) and (e.salary);

-- 38> list third highest paid employee
select * from employees
order by salary desc
limit 3; 
						-- or
 select firstname
 , salary
from (
select
firstname
 , salary,
rank() over(order by salary desc) as rnk
from employees
)t 

where rnk =3;
 
 -- 39> list employee with their manger name 
 select e1.firstname as employee , e2.firstname as manager
 from 
 employees e1
 join employees e2
 on e1.managerid = e2.employeeid;
 
--  40> get all employee and the project they are assigned
select * from projects;
select * from employees;

select e.firstname , p.project_name from employees e
join projects p 
on e.department_id = p.department_id;

-- 41> list project along with depertment name 
select p.project_name as 'project name' , d.department_name
from projects p
left join department d
on p.department_id = d.department_id;

-- 42> list employee who are not assigned to any project
select * from employee_project;
select
 *
from 
employees e 
join employee_project p
on e.employeeid = p.emp_id
where e.employeeid is null;

-- 43 > find the first order and last order by customers 
select customerid , min(orderdate) as first_date,
max(orderdate) as 'last date'
from orders
group by customerid;