# Sales-Analysis-MySQL
## Overview
This SQL script is designed to analyze sales data stored in a database named wsales. It includes various queries to extract valuable insights regarding sales performance, customer demographics, and transaction patterns. The script operates on a table named wstore_sales, which contains detailed information about each transaction, including invoice ID, branch, city, customer demographics, product details, sales figures, and more.
Table Schema
The wstore_sales table schema includes the following columns:
* invoice_id: Unique identifier for each transaction.
* branch: Branch code or identifier.
* city: City where the transaction took place.
* customer_type: Type of customer (e.g., regular, member, etc.).
* gender: Gender of the customer.
* product_line: Type or category of the product sold.
* unit_price: Unit price of the product.
* quantity: Quantity of products sold.
* VAT: Value-added tax.
* total: Total transaction amount.
* date: Date of the transaction.
* time: Time of the transaction.
* payment_method: Method of payment.
* cogs: Cost of goods sold.
* gross_margin_percentage: Gross margin percentage.
* gross_income: Gross income.
* rating: Customer rating.
* time_of_day: Time of day (Morning, Afternoon, Evening).
* week_day: Day of the week (Mon, Tue, Wed, Thu, Fri).
* month_name: Month of the year (Jan, Feb, Mar, etc.).



## Queries Included
The script contains the following queries to analyze the sales data:
1. Determine the distribution of transactions by time of day and day of the week.
2. Identify the most common payment methods, top-selling product lines, and total revenue by month.
3. Analyze the largest COGS (Cost of Goods Sold) by month and the product line with the highest revenue.
4. Calculate total revenue, average unit price, and quantity sold for each product line.
5. Determine the top 5 best-selling products overall and their sales quantities.
6. Explore variations in the total number of transactions, total sales amount, and average transaction amount over time.
7. Assess the average customer rating for each branch and its correlation with sales performance.
8. Analyze sales by demographics, including city and gender distribution.
