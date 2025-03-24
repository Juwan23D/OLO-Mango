-- 1. What is the date of the earliest and latest order, returned in one query?
-- Select min and max from purchase_ts from orders table

Select min(purchase_ts) as earliest_order,
  max(purchase_ts) as latest_order
From core.orders;


-- 2. What is the average order value for purchases made in USD? What about average order value for purchases made in USD in 2019?
-- Select avg usd_price from orders table and filter to where currency = usd, and filter to where purchase_ts is in the year 2019. 

Select avg(usd_price) as avg_US_order,
From core.orders
Where currency = "USD"
and purchase_ts between "2019-01-01" and "2019-12-31";

-- 3. Return the id, loyalty program status, and account creation date for customers who made an account on desktop or mobile. Rename the columns to more descriptive names.
-- Select these columns from customers table where account_creation_method = desktop or mobile - rename columns

Select id as customer_id,
loyalty_program as is_loyalty_customer,
created_on as account_created_on
from core.customers
where account_creation_method = "desktop" or account_creation_method = "mobile";

-- checked for capitilization
Select distinct account_creation_method from core.customers;

-- 4. What are all the unique products that were sold in AUD on website, sorted alphabetically?
-- select product name from orders table and filter to where currency = aud, order by asc

Select distinct product_name
from core.orders
where currency = "AUD"
and purchase_platform = "mobile app"
order by 1 asc;

-- 5. What are the first 10 countries in the North American region, sorted in descending alphabetical order?
-- Select country from geo_lookup where region = NA order by desc, limit 10

select *
from core.geo_lookup
where region = 'NA'
order by 1 desc
limit 10;

-- 1. What is the total number of orders by shipping month, sorted from most recent to oldest?
-- calculate the month for each shipping timestamp, and then count the order ids for each month from the order_status, order by the shipping month in desc

select date_trunc(ship_ts, month) as month,
  count(distinct order_id) as order_count
from core.order_status
group by 1
order by 1 desc;

-- 2. What is the average order value by year? Can you round the results to 2 decimals?
-- Select the year from the purchase_ts, the calculate average usd_price per year, from the orders table and round 2 decimals 

select extract(year from purchase_ts) as year, 
  round(avg(usd_price),2) as aov
from core.orders
group by 1
order by 1;

-- 3. Create a helper column `is_refund`  in the `order_status`  table that returns 1 if there is a refund, 0 if not. Return the first 20 records.
-- Select a case when where if my refund_ts is null then 0 otherwise its 1 and return first 20 records

select *, 
  case when refund_ts is not null then 1 else 0 end as is_refund
from core.order_status
limit 20;

-- 4. Return the product IDs and product names of all Apple products.
-- select distinct product names from orders table to see all product names

select distinct product_id,
  product_name
from core.orders
where product_name like '%Apple%'
or product_name = 'Macbook Air Laptop';
--where product_name in ('Apple Airpods Headphones','Apple iPhone','Macbook Air Laptop')



-- 5. Calculate the time to ship in days for each order and return all original columns from the table.
-- select * and the difference between purchase_ts and ship_ts is from order status

select *, 
  date_diff(ship_ts,purchase_ts, day) as days_to_ship
from core.order_status;
