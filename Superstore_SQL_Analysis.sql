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


