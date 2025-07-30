-- Retail Sales Analysis
USE sql_project_p1;
CREATE TABLE retail_sales(
	transactions_id	INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id	INT,
    gender	VARCHAR (15),
    age INT,
    category VARCHAR (15),	
    quantiy	INT,
    price_per_unit FLOAT,
    cogs FLOAT,	
    total_sale FLOAT

);
SELECT* FROM retail_sales;
SELECT 
	COUNT(*)
FROM retail_sales;
-- checking for null values in the dataset
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE customer_id IS NULL;

SELECT * FROM retail_sales
WHERE gender IS NULL;

SELECT * FROM retail_sales
WHERE 
	age IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR 
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR 
    total_sale IS NULL;
    
    -- Data exploration 
    -- How many sales we have
    SELECT 
		COUNT(total_sale) as total_sales
    FROM 
		sql_project_p1.retail_sales;

SELECT 
		SUM(total_sale) as total_sales
    FROM 
		sql_project_p1.retail_sales;

-- How many unique customers we have 
SELECT
    COUNT(DISTINCT customer_id) AS number_of_customers
FROM 
	retail_sales;

SELECT DISTINCT category FROM retail_sales;

-- Data Analysis & Business Key problems 
-- write sql query to retrieve all columns for sales made on 2022-11-06
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-06';
-- write aql query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of Nov-2022.
SELECT
	*
FROM retail_sales
WHERE category = 'clothing'
AND quantiy >=4
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
-- write a sql query to calculate the total sales (total_sale) for each category
SELECT
	category,
    SUM(total_sale) AS net_sale
FROM retail_sales
GROUP BY category;
-- write a sql query to find average age of customers who purchased items from the beauty category
SELECT
    AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
-- write sql query to find all transactions where the total_sale is gretaer than 1000
SELECT * 
FROM retail_sales
WHERE total_sale > '1000';
-- write sql query to find the total nu,ber of transactions (transaction_id) made by each gender in each category
SELECT category,
	gender,
    COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
-- write sql query to calculate the average sale for each month . find out the best selling month in each year
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
-- write a sql query to find the top 5 customers based on the highest total sales
SELECT 
	customer_id,
    sum(total_sale) as customer_total_sales
from retail_sales
group by customer_id
ORDER BY customer_total_sales DESC
LIMIT 5;
 -- write sql query to find the number of unique customers who purschased items from each category
 SELECT 
    category,
    COUNT(DISTINCT customer_id) 
FROM retail_sales
GROUP BY category;
-- write sql query to create each shift and number of orders (example morning < 12, afternoon Between 12 and 17, evening >17)
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