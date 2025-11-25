CREATE DATABASE IF NOT EXISTS Superstore;

USE Superstore;

CREATE TABLE Orders_Original (
	row_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(100),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(100),
    customer_id VARCHAR(100),
    customer_name VARCHAR(100),
    segment VARCHAR(100),
    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    postalcode VARCHAR(100),
    region VARCHAR(100),
    product_id VARCHAR(100),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    product_name VARCHAR(100),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2)
);

ALTER TABLE orders_original
MODIFY COLUMN order_date VARCHAR(100);

ALTER TABLE orders_original
MODIFY COLUMN ship_date VARCHAR(100);

select count(*) from orders_original;
