-- 46> FIND PRODUCT WITH DECLING SALES TREND 
select * from orders_archive;

select productid 
from ( select productid , month(orderdate) ,
		sum(quantity) as sales,
        lag(sum(quantity))
        over(partition by  productid  order by month(orderdate)) as prev_sales
        from orders_archive
        group by productid ,  month(orderdate)
) t 
where sales <  prev_sales;

-- 47> find product categoy with high revenue 
select 
p.category,
sum(od.quantity * od.sales) as revenue
from
products p 
join orders_archive od
on p.productid = od.productid
group by category
order by revenue desc 
limit 1;

-- 48> calculate the median salary in each department
select * from employees;

select department_id , avg(salary) as median_salary
from 
(select department_id , salary,
row_number() over(partition by department_id order by salary ) as rn,
count(*)
over(partition by department_id ) as cnt
from employees 
) t
where rn in( floor((cnt+1)/2),
 ceil((cnt+1)/2)
 )
 group by department_id;
 
--  49> find the overlapping date range in booking 
select * from bookings;

select 
b1.*
from bookings b1
join bookings b2
on b1.room_id = b2.room_id
and b1.booking_id < b2.booking_id
and b1.check_in < b2.check_out
and b1.check_out > b2.check_in;
 
 -- 50 >  Find the customer who purchase in q1 but q2
 select 
 distinct customerid
 from orders
 where quarter(orderdate)=1
 and customerid not in (select customerid
 from orders 
 where quarter(orderdate)=2);
 
 
-- 51> FIND ALL EMAIL WITH INVALID FORMAT
select * FROM
users
where email not like '%@%.@';

SELECT *
FROM users
WHERE email not LIKE '%@%.%' 
or email  LIKE '%@%@%';

-- 52> find the name that contain number 
select * from employees
where firstname regexp'[0-9]';

-- 53> split first name into first and last name
select * from employees3;
select substring_index(full_name , ' ' , 1) as first_name ,
substring_index(full_name , ' ' , -1) as last_name 
from employees3;

-- 54> find the all order placed in weekend 
select * from orders
where dayofweek(orderdate) in (1,7);
