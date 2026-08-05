/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Brazilian E-Commerce SQL Analysis

Project Objective:
Analyze the Brazilian E-Commerce dataset to uncover business insights related to customers, sales, payments, products, delivery performance, and customer satisfaction using SQL.

Skills Demonstrated:
• Data Exploration
• SQL Joins
• Aggregate Functions
• Date Functions
• CASE WHEN
• Subqueries
• Business Analysis
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

/*
Section Summary

• Successfully explored the dataset structure.
• Identified key tables and relationships.
• Calculated overall business metrics such as total orders,
  customers, sellers, and products.

Business Value:
Understanding the dataset structure is essential before performing any business analysis.
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

/*
Section Summary

• Identified customer distribution across different states.
• Analyzed order patterns by customer location.
• Detected repeat customers using customer_unique_id.
• Identified customers with the highest spending.

Business Value:
Customer segmentation helps businesses understand their strongest markets and improve customer retention.
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

/*
Section Summary

• Calculated total revenue generated from sales.
• Identified preferred payment methods.
• Found highest-value orders.
• Analyzed revenue generated by different states.

Business Value:
These insights help businesses understand purchasing behavior and optimize revenue generation strategies.
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

-- Q3 Which products have been sold the most?
SELECT p.product_category_name, COUNT(i.product_id) AS Total_Sold
FROM products p
INNER JOIN items i
	ON p.product_id = i.product_id
GROUP BY p.product_category_name
ORDER BY Total_Sold DESC
LIMIT 10 ;

-- Q4. Which sellers sell the highest number of products?
SELECT seller_id, COUNT(product_id) AS Product_Sold
FROM items
GROUP BY seller_id
ORDER BY Product_Sold DESC
LIMIT 10;

-- Q5. Which product categories have the highest average selling price?
SELECT p.product_category_name, AVG(i.price) AS Selling_Price
FROM products p
INNER JOIN items i
	ON i.product_id = p.product_id
GROUP BY p.product_category_name 
ORDER BY Selling_Price DESC;
*/

/*
Section Summary

• Identified best-performing product categories.
• Ranked sellers based on revenue.
• Measured product sales volume.
• Compared average selling prices across categories.

Business Value:
Understanding product performance enables businesses to improve inventory planning and maximize profits.
*/

/*=========================================================
SECTION 5 : DELIVERY AND CUSTOEMR EXPERIENCE ANALYSIS
=========================================================*/

/*
-- Q1. Find all orders that were delivered after the estimated delivery date.
SELECT order_id, 
		order_estimated_delivery_date, 
        order_delivered_customer_date,
        DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) AS DATE_DIFF
FROM orders
WHERE order_delivered_customer_date  > order_estimated_delivery_date
ORDER BY order_delivered_customer_date ;

-- Q2. What is the average delivery time?
SELECT AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp))
			AS Avg_Delivery_Days
FROM orders;

-- Q3. Which states have the longest average delivery time?
SELECT c.customer_state, AVG(DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp)) AS Avg_Delivery_Time
FROM orders o
INNER JOIN customer c
	ON c.customer_id = o.customer_id
GROUP BY customer_state;

-- Q4. Which customers experienced the longest delivery delays?
SELECT customer_id, DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) AS Delivery_Delay_Days
FROM orders
ORDER BY Delivery_Delay_Days DESC
LIMIT 10;

-- Q5. Which states have the highest percentage of late deliveries?
SELECT
    c.customer_state,
    COUNT(o.order_id) AS Total_Orders,
    SUM(
        CASE
            WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) AS Late_Orders,
    (SUM(
            CASE
                WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(o.order_id)
    ) AS Late_Delivery_Percentage

FROM orders o
INNER JOIN customer c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY Late_Delivery_Percentage DESC;
*/

/*
Section Summary

• Measured average delivery time.
• Identified delayed deliveries.
• Compared delivery performance across states.
• Evaluated the percentage of late deliveries.

Business Value:
Delivery performance directly impacts customer experience and operational efficiency.
*/
 
/*=========================================================
SECTION 6 : CUSTOMER REVIEWS & SATISFACTION ANALYSIS
=========================================================*/

/*
-- Q1. What is the average review score?
SELECT AVG(review_score) AS Avg_Review
FROM reviews;

-- Q2. How many 1-star, 2-star, 3-star, 4-star and 5-star reviews are there?
SELECT review_score, COUNT(review_id) AS Total_Review
FROM reviews
GROUP BY review_score
ORDER BY Total_Review DESC;

-- Q3. Which states have the avg happiest customers?
SELECT c.customer_state, AVG(r.review_score) AS Avg_Review_Score
FROM customer c
INNER JOIN orders o
    ON o.customer_id = c.customer_id
INNER JOIN reviews r
    ON r.order_id = o.order_id
GROUP BY c.customer_state
ORDER BY Avg_Review_Score DESC;

-- Q4. Does delivery delay affect customer reviews?
SELECT DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date) AS Delv_Delay,
		AVG(r.review_score) AS AVG_Score
FROM orders o
INNER JOIN reviews r 
	ON r.order_id = o.order_id
GROUP BY Delv_Delay
ORDER BY Delv_Delay DESC;

-- Q5. Which product categories receive the highest average review score?
SELECT p.product_category_name, AVG(r.review_score) AS Avg_Score
FROM products p
INNER JOIN items i 
	ON p.product_id = i.product_id
INNER JOIN reviews r 
	on r.order_id = i.order_id
GROUP BY p.product_category_name
ORDER BY Avg_Score desc;
*/

/*
Section Summary

• Calculated average customer review scores.
• Analyzed review score distribution.
• Compared customer satisfaction across states.
• Studied the relationship between delivery delays
  and customer ratings.
• Evaluated product category ratings.

Business Value:
Customer reviews provide valuable feedback regarding product quality and delivery performance.
*/

/*=========================================================
SECTION 7 : BUSINESS INSIGHTS & ADVANCED SQL
=========================================================*/

/*
-- Q1. How has total revenue changed month by month?
 SELECT DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS Month, SUM(p.payment_value) AS Total_Revenue
 FROM orders o 
 INNER JOIN payments p 
	ON p.order_id = o.order_id
GROUP BY Month 
ORDER BY Month ASC;

-- Q2. Top 10 Customers by Total Spending ?
SELECT c.customer_unique_id, SUM(p.payment_value) AS Payment
FROM customer c 
INNER JOIN orders o 
	ON o.customer_id = c.customer_id 
INNER JOIN payments p 
	ON o.order_id = p.order_id 
GROUP BY c.customer_unique_id
ORDER BY Payment DESC
LIMIT 10;

-- Q3. Top 10 States by Revenue
SELECT c.customer_state, SUM(p.payment_value) AS Revenue
FROM customer c 
INNER JOIN orders o 
	ON o.customer_id = c.customer_id
INNER JOIN payments p 
	ON o.order_id = p.order_id 
GROUP BY c.customer_state
ORDER BY Revenue DESC
LIMIT 10;

-- Q4. What percentage of customers are repeat customers?
SELECT
(
	SELECT COUNT(*)
	FROM 
	(
		SELECT c.customer_unique_id
		FROM customer c 
		INNER JOIN orders o 
			ON o.customer_id = c.customer_id
		GROUP BY c.customer_unique_id
		HAVING COUNT(o.order_id) > 1
	) AS Repeat_Customers
) * 100.0 
/
(
	SELECT COUNT(DISTINCT customer_unique_id)
    FROM customer
) AS Repeat_Customer_Percentage;

-- Q5. Which sellers generated the highest total revenue?
SELECT seller_id, SUM(price)
FROM items
GROUP BY seller_id
ORDER BY SUM(price) DESC
LIMIT 10;
*/

/*
Section Summary

• Analyzed monthly revenue trends.
• Identified top spending customers.
• Ranked top-performing sellers.
• Compared revenue generated across states.
• Calculated repeat customer percentage.

Business Value:
These advanced business insights support strategic decision-making and long-term business planning.
*/

/*
--------------------------------------------------------------------------------------------------------------------------------------------------------------

=========================================================
                FINAL PROJECT SUMMARY
=========================================================

Key Business Insights

• Customer activity is concentrated in a limited number of states.

• Credit Card is the most commonly used payment method, indicating customer preference for digital payments.

• Certain product categories consistently generate higher revenue than others.

• Delivery delays negatively influence customer review scores, highlighting the importance of efficient logistics.

• A small number of sellers contribute a significant portion of total sales revenue.

• Monthly sales analysis reveals changes in revenue across different time periods.

• Repeat customers represent an important source of long-term business growth.

Conclusion

This project demonstrates the use of SQL to perform real-world business analysis using an E-Commerce dataset. Various SQL concepts including JOINs, aggregate functions, date functions, CASE statements,
and subqueries, were applied to extract meaningful insights that can support data-driven decision making.

--------------------------------------------------------------------------------------------------------------------------------------------------------------
*/
