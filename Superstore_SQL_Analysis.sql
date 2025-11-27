CREATE DATABASE IF NOT EXISTS Superstore;

USE Superstore;

# Dataset has imported directly as text datatype as errors lead to import failure

SELECT COUNT(*) FROM sales_original;		#checking the count of reports imported from the dataset

DESCRIBE sales_original;

CREATE TABLE sales AS SELECT * FROM sales_original;		#creating copy of dataset for safe operations

DESCRIBE sales;

SELECT * FROM sales;

SELECT order_date FROM sales;	# date format is in dd/mm/yyyy. this should be converted to yyyy/mm/dd. same with ship_date

SELECT RIGHT(order_date, 4) as Year FROM sales; 	# For extracting year from order_date

SELECT SUBSTRING_INDEX(order_date, '/', 1) AS Day FROM sales;	# For extracting day from order_date

SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(order_date, '/', 2), '/', -1) AS Month FROM sales;	# For extracting month from order_date

UPDATE sales 	# modifying order_date values to proper format yyyy/mm/dd 
SET order_date = CONCAT(
			RIGHT(order_date, 4),
			'/',
			SUBSTRING_INDEX(SUBSTRING_INDEX(order_date, '/', 2), '/', -1),
			'/',
			SUBSTRING_INDEX(order_date, '/', 1)
        );
        
UPDATE sales 	# modifying ship_date values to proper format yyyy/mm/dd 
SET ship_date = CONCAT(
			RIGHT(ship_date, 4),
			'/',
			SUBSTRING_INDEX(SUBSTRING_INDEX(ship_date, '/', 2), '/', -1),
			'/',
			SUBSTRING_INDEX(ship_date, '/', 1)
        );
        
UPDATE sales	#updating order_date format to yyyy/mm/dd
SET order_date = str_to_date(order_date, '%Y/%c/%e');

UPDATE sales	#updating ship_date format to yyyy/mm/dd
SET ship_date = STR_TO_DATE(ship_date, '%Y/%c/%e');

ALTER TABLE sales	# modifying order_date to DATE datatype
MODIFY order_date DATE;

ALTER TABLE sales	# modifying ship_date to DATE datatype
MODIFY ship_date DATE;

DESCRIBE sales;		#checking datatypes

SELECT * FROM sales;	# now the dataset is ready for analysis

-- 1. Revenue per year ordered by year
SELECT 
	YEAR(order_date) AS period, 
    ROUND(SUM(sales * quantity), 2) AS revenue 
FROM sales
GROUP BY period 
ORDER BY period;

-- 2. Revenue per year, month ordered by year, month
SELECT 
	YEAR(order_date) AS year_, 
    month(order_date) AS month_num, 
    MONTHNAME(order_date) AS month_, 
    ROUND(SUM(sales * quantity), 2) AS revenue 
FROM sales
GROUP BY year_, month_num, month_ 
ORDER BY year_, month_num;

-- 3. revenue per state & year
SELECT 
	state,
    YEAR(order_date) AS year_,
    SUM(sales * quantity) AS revenue
FROM sales
GROUP BY state, year_
ORDER BY year_, state;

-- 4. revenue per customer 2011-2014
SELECT
	customer_name,
    SUM(sales * quantity) AS revenue_generated
FROM sales
GROUP BY customer_name
ORDER BY revenue_generated DESC;

-- 5. total orders per customer 2011-2025
SELECT 
	customer_name,
    COUNT(order_id) AS total_visits
FROM sales
GROUP BY customer_name
ORDER BY total_visits DESC;

-- 6. NEW QUERY
