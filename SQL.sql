/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Brazilian E-Commerce SQL Analysis

Objective:
Analyze customer behavior, sales trends, payment methods,and product performance using SQL.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*=========================================================
SECTION 1 : DATABASE OVERVIEW
=========================================================*/

/*
-- Create database
CREATE DATABASE ecommerce;
USE ecommerce ;
*/

/* 
Q1. Find total number of orders 
SELECT COUNT(*) AS total_orders
FROM orders ;

OBSERVATION :
The platform processed 99,441 orders, indicating a large volume of e-commerce transactions during the analysis period.

-- Q2. Find the total number of customers
SELECT COUNT(*) AS total_customer
FROM customer;
OBSERVATION:
The platform processed 99,441 total customers, indicating a large number of e-commerce customers during the analysis period.

-- Q3. Find the total number of products
SELECT COUNT(*) AS total_products
FROM products;

OBSERVATION:
The platform processed 32,951 total products, indicating a total number of e-commerce products during the analysis period.

-- Q4. Total Number of Payments
SELECT COUNT(*) AS total_payments
FROM payments;

OBSERVATION:
The platform processed 1,03,886 total payments, indicating a total number of e-commerce payments during the analysis period.

-- Q5. Total Number of Reviews
SELECT COUNT(*) AS total_reviews
FROM reviews;

OBSERVATION:
The platform processed 314 total reviews, indicating a total number of e-commerce productreviews during the analysis period.
*/

/*=========================================================
SECTION 2 : CUSTOMER ANALYSIS
=========================================================*/
/*
-- Q1. Which states have the highest number of customers?
SELECT customer_state, COUNT(customer_id) AS total_customers
FROM customer
GROUP BY customer_state
ORDER BY total_customers DESC
LIMIT 5;

-- Q2. Which states place the highest number of orders?
SELECT customer_state, COUNT(order_id) AS Total_Orders
FROM orders o
INNER JOIN customer c
ON o.customer_id = c.customer_id
GROUP BY customer_state
ORDER BY Total_Orders DESC;

-- Trick :
-- SELECT → the columns you want to see (customer_state, COUNT(order_id))
-- GROUP BY → the non-aggregated column (customer_state)
-- ORDER BY → the metric you're ranking (Total_Orders DESC)

--Every column in the SELECT must either:
-- Be included in the GROUP BY, or
-- Be wrapped in an aggregate function (SUM, COUNT, AVG, MIN, MAX).

-- Q3. Top 10 Customers by Total Spending
SELECT 
	c.customer_id, 
    SUM(payment_value) AS Total_Payment
FROM customer c 
INNER JOIN orders o
	ON o.customer_id = c.customer_id
INNER JOIN payments p 
	ON o.order_id = p.order_id 
GROUP BY c.customer_id
ORDER BY Total_Payment DESC
LIMIT 10;

-- Q4. Find customers (customer_unique_id) who have placed multiple orders.
SELECT c.customer_unique_id, COUNT(o.order_id) AS Total_Orders_Placed
FROM orders o
INNER JOIN customer c
	On o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
ORDER BY Total_Orders_Placed DESC;

-- Q5. Which states have the highest average payment amount?
SELECT c.customer_state, AVG(p.payment_value) AS Avg_Payment
FROM customer c
INNER JOIN orders o
	ON o.customer_id = c.customer_id
INNER JOIN payments p
	ON p.order_id = o.order_id
 GROUP BY c.customer_state   
ORDER BY Avg_Payment DESC
LIMIT 10;
*/

/*=========================================================
SECTION 3 : SALES AND PAYMENT ANALYSIS ANALYSIS
=========================================================*/
/*
-- Q1. Which product categories generate the highest revenue?
SELECT p.product_category_name, SUM(i.price) AS Total_Price
FROM items i
INNER JOIN products p
	ON p.product_id = i.product_id
GROUP BY p.product_category_name
ORDER BY Total_price DESC
LIMIT 10;

-- Q2. Which sellers generated the highest revenue?
SELECT seller_id, SUM(price) AS Total_Revenue
FROM items
GROUP BY seller_id
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Q3. Which orders had the highest payment value?
SELECT o.order_id, SUM(p.payment_value) AS Heightest_Payment
FROM orders o
INNER JOIN payments p 
	ON p.order_id = o.order_id
GROUP BY o.order_id
ORDER BY Heightest_Payment DESC
LIMIT 10;

-- Q4. Which payment methods are most popular among customers?
SELECT payment_type, COUNT(payment_type) AS Times_Used
FROM payments
GROUP BY payment_type
ORDER BY Times_Used DESC
LIMIT 10;

-- Q5. Which states generate the highest total sales revenue?
SELECT c.customer_state, SUM(p.payment_value) 
FROM customer c
INNER JOIN orders o
	ON o.customer_id = c.customer_id
INNER JOIN payments p 
	ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY sum(p.payment_value) DESC
LIMIT 10;
*/

/*=========================================================
SECTION 4 : PRODUCT ANALYSIS
=========================================================*/
/*

/*
-- Q1. Which product categories generate the highest revenue?
SELECT p.product_category_name, SUM(i.price)
FROM products p 
INNER JOIN items i
	ON i.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY SUM(i.price) DESC
LIMIT 10;

-- Q2. Which sellers generated the highest revenue?
SELECT seller_id, SUM(price) AS Heighest_Revenue
FROM items
GROUP BY seller_id
ORDER BY Heighest_Revenue DESC
LIMIT 10;
*/
