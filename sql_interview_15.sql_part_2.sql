-- 16> FIND THE CUSTOMER WHO PLACED ORDERS IN CONSECUTIVE MONTH 
select * from orders;

select distinct o1.customerid
from orders o1
join  orders o2
on o1.customerid = o2.customerid
and month(o1.orderdate) = month(o2.orderdate)+1
and year(o1.orderdate) = year(o2.orderdate)
order by o1.customerid desc;

-- 17 find the average order value per customer 
select * from orders;
select * from products;
select
o.customerid,
c.firstname, 
avg(o.quantity * o.sales)
from orders o 
join customers c
    ON o.customerid = c.customerid
group by o.customerid, c.firstname;

-- 18> list product that have been never been order 
select * from products;
select p.* from products p
left join orders od
on p.productid = od.productid
where od.productid is null;

-- 19> find the customer who orderd the same product more from once
 select * from orders;
 select *  from orders_archive;
 
 select 
 o.customerid,
 od.productid,
 count(*) as times
 from orders o
 join orders_archive od
 on o.orderid = od.orderid
 and o.productid = od.productid
 and o.customerid = od.customerid
 group by od.orderid , o.productid
 having count(*) > 1;
 
 -- 20> FIND PRODUCT WITH SALES GREATER THAN AVERAGE  
  select * from orders_archive;
  
 SELECT o.productid , 
 sum(quantity * sales) AS TOTAL 
 FROM orders_archive o
 GROUP BY o.productid
 having TOTAL > (select avg(total) from
 (select sum(quantity * sales) as total from orders_archive group by productid) t
 );
 
 -- 22> dislay top 5 selling product
   select * from orders_archive;
   select productid , sum(quantity) total_sold
   from orders_archive
   group by productid 
   order by total_sold desc
   limit 5;
   
-- 23> find the product that are out of the stock
  select * from orders_archive;
  select * from orders_archive
  where quantity = 0
  or quantity is null;
  
  -- 24> calculate the running total of sales by date 
  select * from orders;
  select orderdate , sum(quantity * sales)
  over(order by orderdate rows between unbounded preceding and current row)as running_total
  from orders;
  
 -- 25 > find the product sold in all regions 
select * from sales;
select product_id , count(region)
from sales
group by product_id
having count(distinct region) = (select count(distinct region) from sales );

-- 26> display year-over-year sales comparisions
 select * from orders;
 select year(orderdate) as years,
sum(quantity * sales) as sales,
LAG(sum(quantity * sales)) OVER(ORDER BY year(orderdate)) AS PREV_YEAR
from orders
GROUP BY years;

-- 27> LIST PRODUCT IN AT LEAST 10 DIFFERENT ORDERS 
  select * from orders_archive;
select
productid,
count(distinct orderid) as order_count
FROM 
orders_archive
GROUP BY productid
HAVING COUNT(distinct orderid)>=5;

-- 28 > find product category with high revenue
select * from products; 
select
p.category,
sum(od.quantity*od.sales) as total_rev
from 
products p
join orders_archive od 
on p.productid = od.productid
group by p.category
order by total_rev DESC 
limit 1;

-- 29> display product never sold in a specefic region 
 select * from products;
 select * from sales;
 select 
 p.*
 from products p 
 where p.productid not in (select distinct product_id from sales
							where region = "North"
                            );

-- 30> Display employee hired on the same date 
select hire_date , count(*)
from employees
group by hire_date
having count(*) > 1;