# 🛒 Retail Sales Analysis with SQL

![SQL Badge](https://img.shields.io/badge/SQL-Analysis-blue)  
![Project Status](https://img.shields.io/badge/status-completed-brightgreen

## Project Overview

**Project Title**: Retail Sales Analysis

**Database**: `p1_retail_db`

This project demonstrates practical SQL skills by analyzing a retail sales dataset. From cleaning the data to extracting insights, I used SQL to answer key business questions and uncover patterns in customer behavior, revenue trends, and product performance.

## Objectives

1. Design and structure a relational retail database.
2. Clean and validate transactional data
3. Use SQL queries to answer key business questions
4. Perform aggregations and rankings to find high-value customers, categories, and time-based patterns

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales (
  transactions_id INT PRIMARY KEY,
  sale_date DATE,
  sale_time TIME,
  customer_id INT,
  gender VARCHAR(10),
  age INT,
  category VARCHAR(35),
  quantity INT,
  price_per_unit FLOAT,
  cogs FLOAT(5, 2),
  total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equal to 4 in the month of Nov-2022**:
```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND sale_date LIKE '%2022-11%'
  AND quantity >= 4;
```

3. **Write a SQL query to calculate each category's total sales (total_sale).**:
```sql
SELECT category, SUM(total_sale) AS category_sale,
COUNT(*) AS total_order
FROM retail_sales
GROUP BY category
ORDER BY category_sale DESC;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT ROUND(AVG(age), 0) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT gender,
category,
COUNT(transaction_id) AS total_transaction
FROM retail_sales
GROUP BY gender, category
ORDER BY total_transaction DESC;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
WITH mp AS (
  SELECT EXTRACT(YEAR FROM sale_date) AS year,
         EXTRACT(MONTH FROM sale_date) AS month,
         RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS ranking,
         AVG(total_sale) AS avg_sale
  FROM retail_sales
  GROUP BY year, month
)
SELECT year,
month,
avg_sale
FROM mp
WHERE ranking = 1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT customer_id,
SUM(total_sale) AS max_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY max_sale DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT category,
COUNT(DISTINCT customer_id) AS customers
FROM retail_sales
GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH mode_of_day AS (
  SELECT *,
         CASE
           WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
           WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
         END AS shift
  FROM retail_sales
)
SELECT shift, COUNT(*) AS total_order
FROM mode_of_day
GROUP BY shift
ORDER BY total_order DESC;
```

## Findings

- **Top Category:** Clothing ranked highest in revenue and volume.
- **Demographic Note:** Beauty products attracted younger buyers on average.
- **High Spenders:** Top 5 customers contributed significantly to overall revenue.
- **Time-Based Trends:** Evening was the busiest time slot for sales.
- **Seasonal Highlight:** November showed strong performance year-over-year.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## Author - Engineerjosh7

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:

- **Instagram**: [Follow me for daily tips and updates](https://www.instagram.com/ogunsola901/)
- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/joshua-ogunsola)
- **Email**: joshusogunsola7@gmail.com

Thank you for your support, and I look forward to connecting with you!
