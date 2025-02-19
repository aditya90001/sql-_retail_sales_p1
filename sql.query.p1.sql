create table retail_sales(
	transactions_id	int,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(15),
	age int,
	category varchar(15),
	quantity int,
	price_per_unit numeric(10,2),
	cogs numeric(10,2),
	total_sale numeric(10,2)
);
select * from retail_sales;
copy retail_sales(transactions_id,	sale_date,	sale_time,	customer_id,
gender,	age,	category,	quantiy,	price_per_unit,	cogs,	total_sale
)
from 'C:\Program Files\PostgreSQL\17\SQL - Retail Sales Analysis_utf .csv'
csv header;
alter table retail_sales
rename quantity to quantiy
select count(*) from retail_sales;

--data cleaning
select * from retail_sales
where
transactions_id is null
or
sale_date is null
or 
sale_time is null
or
customer_id is null 
or
gender is null
or
age is null
or 
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;
delete from retail_sales
where
transactions_id is null
or
sale_date is null
or 
sale_time is null
or
customer_id is null 
or
gender is null
or
 
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;
select * from retail_sales
where 
age is null;
--data exploration
--how many sales we have
select count(transactions_id) as total_sales from retail_sales;
--how many customer we have
select count( distinct customer_id) as total_customer from retail_sales;
--how many revenue generated
select sum(total_sale) as total_revenue from retail_sales;
select count(distinct category) from retail_sales;
--data analysis and buisness key problem
---- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales
where  sale_date='2022-11-05';
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
select * from retail_sales
where category='Clothing'
and quantiy>=4
and sale_date between '2022-11-01' and '2022-11-30';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select sum(total_sale) ,count(transactions_id) as total_order,  category from retail_sales
group by distinct category;

-- Q.4 Write a SQL query to find the average age of customers who purchased
--items from the 'Beauty' category.
select round(avg(age), 2) from retail_sales
where category='Beauty';
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales
where total_sale>1000 ;
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id)
--made by each gender in each category.
select count(transactions_id),gender,category
from retail_sales
group by gender,category;
-- Q.7 Write a SQL query to calculate the average sale 
--for each month. Find out best selling month in each year
select 
extract (year from sale_date) as sale_year,
extract (month from sale_date) as sale_month,
avg(total_sale)as average_sales,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc)
from retail_sales
group by 1,2


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id from retail_sales
order by total_sale desc
limit 5;
-- Q.9 Write a SQL query to find the number of unique customers who purchased items
--from each category.
select count(distinct customer_id), category
from retail_sales
group by category;
-- Q.10 Write a SQL query to create each shift and number of orders 
--(Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
--in this we use case function
with hourly_sale
as(
select * ,
case
	when extract (hour from sale_time)<12 then 'morning'
	when extract (hour from sale_time) between 12 and 17 then'afternoon'
	else 'evening'
	end as shift
from retail_sales
)
select shift,count(transactions_id)
from hourly_sale
group by shift
--end of project











