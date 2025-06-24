-- SQL Retail Sales Analysis
Create database p1_retail_db;

Create table retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT (5, 2),
    total_sale FLOAT
);

select * from retail_sales;

-- How many sales do we have?
SELECT COUNT(*) FROM retail_sales;

-- How many unique customers do we have?
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- How many Category do we have?
SELECT DISTINCT category FROM retail_sales;

-- Null Value Check
SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- Data Analysis & Business Key problems & Answers

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales
where sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equal to 4 in the month of Nov-2022
select * from retail_sales
where category = 'Clothing'
and
sale_date like'%2022-11%'
and
quantity >= 4;

-- Write a SQL query to calculate the total sales (total_sale) for each category
select sum(total_sale) as category_sale,
category,
count(*) as total_order from retail_sales
group by category
order by category_sale desc;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age), 0) as avg_age,
category from retail_sales
where category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales
where total_sale > 1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select count(transaction_id) as total_transaction,
gender,
category from retail_sales
group by gender, category
order by total_transaction desc;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
with mp as (select extract(year from sale_date) as year,
extract(month from sale_date) as month,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as ranking,
avg(total_sale) as avg_sale from retail_sales
group by year, month)

select year, month, avg_sale from mp
where ranking = 1;

-- Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id, sum(total_sale) as max_sale from retail_sales
group by customer_id
order by max_sale desc
limit 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.
select count(distinct customer_id) as customers, category from retail_sales
group by category;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).
with time_of_day as (select *,
case
when extract(hour from sale_time) < 12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift from retail_sales)

select count(*) as total_order, shift from time_of_day
group by shift
order by total_order desc;

-- End of project