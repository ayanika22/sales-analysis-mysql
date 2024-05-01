create database wsales; -- Create a new database
use wsales; -- set the present working database

-- Create a new table 
-- ------------------------------------------------------------------------------------------------------------------
create table if not exists wstore_sales (
invoice_id VARCHAR(30) not null primary key,
branch VARCHAR(5),
city VARCHAR(30),
customer_type VARCHAR(30),
gender VARCHAR(10),
product_line VARCHAR(100),
unit_price DECIMAL(10, 2),
quantity INT,
VAT FLOAT(6, 4),
total DECIMAL(10, 2),
date DATE,
time TIME,
payment_method varchar(30),
cogs DECIMAL(10, 2),
gross_margin_percentage FLOAT(11, 9),
gross_income DECIMAL(10, 2),
rating FLOAT(2, 1)
);

-- ------------------------------------------------------------------------------------------------------------------------------------
-- Add a new column named time_of_day to give insight of sales in the Morning, Afternoon and Evening.
-- This will help answer the question on which part of the day most sales are made.
-- ------------------------------------------------------------------------------------------------------------------------------------

alter table wstore_sales add column time_of_day varchar(25);
UPDATE wstore_sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);
select time_of_day, count(invoice_id) as total_transactions 
from wstore_sales 
group by time_of_day 
order by total_transactions desc;

-- ------------------------------------------------------------------------------------------------------------------------------------
-- Add a new column named day_name that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). 
-- This will help answer the question on which week of the day each branch is busiest.
-- ------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE wstore_sales ADD COLUMN week_day VARCHAR(10);
UPDATE wstore_sales
SET week_day = dayname(date);

select week_day, count(invoice_id) as total_transactions 
from wstore_sales 
group by week_day 
order by total_transactions desc;

-- ------------------------------------------------------------------------------------------------------------------------------------
-- Add a new column named month_name that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). 
-- Help determine which month of the year has the most sales and profit.
-- ------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE wstore_sales ADD COLUMN month_name VARCHAR(10);
UPDATE wstore_sales
SET month_name = monthname(date);

-- ------------------------------------------------------------------------------------------------------------------------------------
-- How many unique cities does the data have?
-- In which city is each branch?
-- ------------------------------------------------------------------------------------------------------------------------------------
select count(distinct(city)) from wstore_sales; -- 3
select distinct city, branch from wstore_sales; 

-- ------------------------------------------------------------------------------------------------------------------------------------
-- How many unique product lines does the data have?
-- 3 most common payment methods used?
-- Top 3 selling product lines?
-- What is the total revenue by month?
-- ------------------------------------------------------------------------------------------------------------------------------------

select count(distinct product_line) as count from wstore_sales;
select payment_method, count(payment_method) as count from wstore_sales group by payment_method order by count desc limit 3;
select product_line, count(product_line) as count from wstore_sales group by product_line order by count desc limit 3;
select month_name, sum(total) as total_revenue from wstore_sales group by month_name;

-- ------------------------------------------------------------------------------------------------------------------------------------
-- What month had the largest COGS?
-- What product line had the largest revenue?
-- ------------------------------------------------------------------------------------------------------------------------------------

select month_name, sum(cogs) from wstore_sales group by month_name limit 1; -- March
select product_line, sum(total) from wstore_sales group by product_line limit 1; -- Food and beverages

-- ------------------------------------------------------------------------------------------------------------------------------------
-- Total revenue, average unit price, and quantity sold for each product line.
-- List of the top 5 best-selling products overall, along with their sales quantities and percentages of total sales.
-- ------------------------------------------------------------------------------------------------------------------------------------

select product_line, concat("$ ",sum(total)) as total_revenue, 
concat("$ ",truncate(avg(unit_price),2)) as avg_unit_price, sum(quantity) as total_qty
from wstore_sales group by product_line;

select product_line, sum(quantity) as total_qty, 
concat(truncate(sum(quantity)/(select sum(quantity) as total_qty from wstore_sales)*100, 0), "%") as percent_sales 
from wstore_sales group by product_line limit 5;

-- ------------------------------------------------------------------------------------------------------------------------------------
-- How does the total number of transactions, total sales amount, and average transaction amount vary over time?
-- ------------------------------------------------------------------------------------------------------------------------------------

select month_name, 
	sum(invoice_id) as total_transactions, 
	concat("$",sum(total)) as total_transaction_amt, 
	concat("$",truncate(avg(total),2)) as avg_transaction_amt
from wstore_sales
group by month_name;

-- ------------------------------------------------------------------------------------------------------------------------------------
-- Average customer rating for each branch, and any correlation between ratings and sales performance.
-- ------------------------------------------------------------------------------------------------------------------------------------

select branch, 
truncate(avg(rating),2) as avg_rating, 
sum(quantity) as total_qty, 
round(avg(quantity)) as avg_qty,
concat("$ ",sum(total)) as total_revenue, 
concat("$ ",truncate(avg(total),2)) as avg_amt
from wstore_sales group by branch
order by avg_rating desc;

-- ------------------------------------------------------------------------------------------------------------------------------------
-- Sales by Demographics 
-- ------------------------------------------------------------------------------------------------------------------------------------

select city,gender, count(invoice_id) as count from wstore_sales group by gender, city;
