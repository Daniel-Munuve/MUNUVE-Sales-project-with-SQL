# Retail SQL Project

Retail Sales SQL Analysis Project
This project explores a Retail Sales Dataset using SQL to uncover insights into customer behavior, product categories, and sales performance. The project answers key business questions through structured queries, helping stakeholders make data-driven decisions.

# Project Overview
Database: sql_project_p1

Main Table: retail_sales

Tools Used: MySQL (with ONLY_FULL_GROUP_BY enabled)

Key Focus Areas: Data cleaning, sales performance, customer segmentation, category trends, and time-based sales patterns.

📊 Table of Contents
Table Creation & Basic Checks
Data Exploration
Business Questions & Analysis
Time-based Sales Analysis
Customer Behavior
Shift-based Performance

1. # Table Creation & Basic Checks
# Creating the retail_sales table:
CREATE TABLE retail_sales (
  transactions_id INT PRIMARY KEY,
  sale_date DATE,
  sale_time TIME,
  customer_id INT,
  gender VARCHAR(15),
  age INT,
  category VARCHAR(15),
  quantiy INT,
  price_per_unit FLOAT,
  cogs FLOAT,
  total_sale FLOAT
);
# Null Value Checks:

SELECT * FROM retail_sales WHERE transactions_id IS NULL;
-- Repeat for other columns like sale_date, sale_time, customer_id, etc.
# Data Exploration
# Total Number of Transactions:

# How many sales we have
    SELECT 
		COUNT(total_sale) as total_sales
    FROM 
		sql_project_p1.retail_sales;

SELECT 
		SUM(total_sale) as total_sales
    FROM 
		sql_project_p1.retail_sales;

# How many unique customers we have 
SELECT
    COUNT(DISTINCT customer_id) AS number_of_customers
FROM 
	retail_sales;

# Business Questions & Analysis

# write sql query to retrieve all columns for sales made on 2022-11-06
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-06';
# write aql query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of Nov-2022.
SELECT
	*
FROM retail_sales
WHERE category = 'clothing'
AND quantiy >=4
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
# write a sql query to calculate the total sales (total_sale) for each category
SELECT
	category,
    SUM(total_sale) AS net_sale
FROM retail_sales
GROUP BY category;
# write a sql query to find average age of customers who purchased items from the beauty category
SELECT
    AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
# write sql query to find all transactions where the total_sale is gretaer than 1000
SELECT * 
FROM retail_sales
WHERE total_sale > '1000';
# write sql query to find the total nu,ber of transactions (transaction_id) made by each gender in each category
SELECT category,
	gender,
    COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
# write sql query to calculate the average sale for each month . find out the best selling month in each year
SELECT * FROM
(
	SELECT
		YEAR(sale_date) AS sale_year,
		MONTH(sale_date) AS sale_month,
		AVG(total_sale) AS avg_total_sale,
		RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank_sales
	FROM retail_sales
	GROUP BY YEAR(sale_date), MONTH(sale_date)
) as t1
WHERE rank_sales = 1;
# write a sql query to find the top 5 customers based on the highest total sales
SELECT 
	customer_id,
    sum(total_sale) as customer_total_sales
from retail_sales
group by customer_id
ORDER BY customer_total_sales DESC
LIMIT 5;
 # write sql query to find the number of unique customers who purschased items from each category
 SELECT 
    category,
    COUNT(DISTINCT customer_id) 
FROM retail_sales
GROUP BY category;
# write sql query to create each shift and number of orders (example morning < 12, afternoon Between 12 and 17, evening >17)
with hourly_rate
AS
(
SELECT *,
		CASE
			WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            Else 'Evening'
		End as shift_time
FROM retail_sales
)
SELECT 
	shift_time,
    COUNT(*) AS total_orders
FROM hourly_rate
GROUP BY shift_time;

-- End of Project

📌 Conclusion
This project provides an end-to-end analysis of retail sales using SQL—from data validation and cleaning to business insights and customer segmentation. It is useful for businesses looking to optimize their marketing, inventory, and staffing strategies based on real-time data insights.


