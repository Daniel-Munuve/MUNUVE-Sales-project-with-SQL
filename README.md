# Retail SQL Project

Retail Sales SQL Analysis Project
This project explores a Retail Sales Dataset using SQL to uncover insights into customer behavior, product categories, and sales performance. The project answers key business questions through structured queries, helping stakeholders make data-driven decisions.

📂 Project Overview
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

1. 📌 Table Creation & Basic Checks
✅ Creating the retail_sales table:
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
✅ Null Value Checks:

SELECT * FROM retail_sales WHERE transactions_id IS NULL;
-- Repeat for other columns like sale_date, sale_time, customer_id, etc.
2. 📊 Data Exploration
🔸 Total Number of Transactions:

SELECT COUNT(*) FROM retail_sales;
🔸 Total Sales Amount:

SELECT SUM(total_sale) AS total_sales FROM retail_sales;
🔸 Unique Customers:

SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
🔸 Categories Available:

SELECT DISTINCT category FROM retail_sales;
3. 📈 Business Questions & Analysis
🔍 Sales on a Specific Date:

SELECT * FROM retail_sales WHERE sale_date = '2022-11-06';
👕 High-quantity Clothing Sales in Nov 2022:

SELECT * 
FROM retail_sales 
WHERE category = 'clothing' 
  AND quantiy > 10 
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
💰 Total Sales per Category:

SELECT category, SUM(total_sale) AS net_sale 
FROM retail_sales 
GROUP BY category;
💄 Average Age for Beauty Product Buyers:

SELECT AVG(age) AS avg_age 
FROM retail_sales 
WHERE category = 'Beauty';
💸 Transactions Over 1000 in Total Sale:

SELECT * 
FROM retail_sales 
WHERE total_sale > 1000;
🧍‍♀️ Transaction Count by Gender and Category:

SELECT category, gender, COUNT(*) AS total_trans 
FROM retail_sales 
GROUP BY category, gender 
ORDER BY category;
4. 📅 Time-Based Sales Analysis
🏆 Best Selling Month Each Year:

SELECT * FROM (
  SELECT
    YEAR(sale_date) AS sale_year,
    MONTH(sale_date) AS sale_month,
    AVG(total_sale) AS avg_total_sale,
    RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank_sales
  FROM retail_sales
  GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t1
WHERE rank_sales = 1;
5. 👥 Customer Behavior
🥇 Top 5 Customers by Total Spend:

SELECT customer_id, SUM(total_sale) AS customer_total_sales 
FROM retail_sales 
GROUP BY customer_id 
ORDER BY customer_total_sales DESC 
LIMIT 5;
📦 Unique Customers per Category:

SELECT category, COUNT(DISTINCT customer_id) 
FROM retail_sales 
GROUP BY category;
6. 🕒 Shift-Based Sales Performance
⏰ Number of Orders by Time of Day:

WITH hourly_rate AS (
  SELECT *, 
    CASE
      WHEN HOUR(sale_time) < 12 THEN 'Morning'
      WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
    END AS shift_time
  FROM retail_sales
)
SELECT shift_time, COUNT(*) AS total_orders 
FROM hourly_rate 
GROUP BY shift_time;

📌 Conclusion
This project provides an end-to-end analysis of retail sales using SQL—from data validation and cleaning to business insights and customer segmentation. It is useful for businesses looking to optimize their marketing, inventory, and staffing strategies based on real-time data insights.


