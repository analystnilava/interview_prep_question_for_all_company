-- 1> find the second highest salary from employee table
select * from employees;
select avg(salary) from employees
where salary < (select max(salary) from employees);

-- 2> display employee who earn more their manager
select * from employees e
join employees m
on e.managerid = m.employeeid
where e.salary > m.salary;

-- 3> find the employee who have same salary
select salary,count(*) cnt
from employees
group by salary
having count(*)>1;

-- 4> delete DUPLICATE ROW KEEPING RECORD
delete from employees
WHERE employeeid not in (
select * from (
select min(employeeid) from employees
group by firstname , salary , department
) as temp 
);

 SET SQL_SAFE_UPDATES = 0;

-- 5> find the department with no employee
 select d.* from 
depertment d
left join employees e
on d.dept_id = e.dept_id
where e.employeeid is null; 

-- 6> display to 3 hight paid employee in each department
select * from (select e.* , dense_rank() over(partition by department order by salary desc)
				as rnk from employee e ) as t 
                where rnk <=3;
            
-- 7> find the employee who joind in last 30 days
select * from employees
where hire_date >= date_sub(current_date(), interval 30 day);

-- 8> calculate salary difference between employee and deperment
select e.* , e.salary - avg(e.salary)
over(partition by department) as diff
from employees e;

-- 9> find the employee whose salary is above company average 
select * from employees e
where e.salary > (select avg(salary) from employees);
 
-- 10> display employee who report to manager in different depertment 
select e.*
from employees e 
join employees m
on e.managerid = m.employeeid
and e.department != m.department;

-- 11> find the customer who never places any orders 
select * from orders;
select * from customers;
select 
*
from 
customers c
left join orders o
on c.customerid = o.customerid
where o.customerid is null;

-- 12 > display total order amount for each customers 
 select 
 c.firstname,
 sum(sales*quantity) as total_sum
 from 
orders o
join customers c
on o.customerid = c.customerid
 group by c.customerid, c.firstname  order by total_sum desc ;
 
-- 13> find the customers with highest total purchase amount
select c.firstname,  o.customerid , sum(sales*quantity) as total_sum
from orders o
join customers c
group by c.firstname , o.customerid 
order by total_sum limit 1;

-- 14> list order placed in the last quarter
SELECT *
FROM orders
WHERE orderdate >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH);

-- 15 display the customers is more than 2 orders
select customerid , count(*) as order_count
from orders
group by customerid 
having order_count >2;
 

