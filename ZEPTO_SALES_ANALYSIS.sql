﻿-- 📊 Sales & Revenue Insights
--1. Which city has the highest total revenue?
SELECT CUSTOMER_CITY, SUM(TOTAL_PRICE) as TOTAL_REVENUE
FROM ZEPTO_ORDERS
GROUP BY CUSTOMER_CITY
ORDER BY TOTAL_REVENUE DESC;

-- 2.What is the average order value (AOV) by city and by category?

SELECT CUSTOMER_CITY,CATEGORY,
SUM(TOTAL_PRICE) / COUNT(DISTINCT ORDER_ID) AS AOV
FROM ZEPTO_ORDERS
GROUP BY CUSTOMER_CITY, CATEGORY;


-- 3.Which category contributes the most to overall revenue in each city?
WITH RevnueByCityCategory AS (
SELECT
CUSTOMER_CITY,
CATEGORY,
SUM(TOTAL_PRICE) AS REVENUE,
RANK() OVER(PARTITION BY CUSTOMER_CITY ORDER BY SUM(TOTAL_PRICE) DESC) AS RANK_NUM
FROM ZEPTO_ORDERS
GROUP BY CATEGORY,CUSTOMER_CITY
)

SELECT
CUSTOMER_CITY,
CATEGORY,
REVENUE
FROM RevnueByCityCategory
WHERE RANK_NUM=1;

--Find the top 5 orders with the highest discount in percentage and amount

-- Option 1:Top 5 Orders by Highest Discount Percentage
SELECT TOP 5 
Order_ID,
    Customer_City,
    Category,
    Quantity,
    Price_per_Unit,
	Discount,
    Total_Price
	FROM ZEPTO_ORDERS
ORDER BY DISCOUNT DESC;

--  Option 2: Top 5 Orders by Highest Discount Amount

SELECT TOP 5 *,
       ROUND(Quantity * Price_per_Unit * (Discount / 100.0), 2) AS Discount_Amount
FROM zepto_orders
ORDER BY Discount_Amount DESC;

-- Calculate monthly revenue trends – is revenue increasing or decreasing?
SELECT 
    FORMAT(CAST(Date AS DATE), 'yyyy-MM') AS Month,
    SUM(Total_Price) AS Total_Sales
FROM ZEPTO_ORDERS
GROUP BY FORMAT(CAST(Date AS DATE), 'yyyy-MM')
ORDER BY FORMAT(CAST(Date AS DATE), 'yyyy-MM');


-- 🛍️ Product & Category Analysis

-- Which product categories have the highest average rating?
SELECT CATEGORY,
AVG(CUSTOMER_RATING) AS AverageRating
FROM ZEPTO_ORDERS
GROUP BY CATEGORY
ORDER BY AverageRating DESC;

-- Which categories have the longest and shortest average delivery times?
WITH CategoryAvgDelivery AS (
    SELECT
        Category,
        AVG(Delivery_Time_Minutes) AS AvgDeliveryTime
    FROM
        ZEPTO_ORDERS
    GROUP BY
        Category
)
SELECT
    (SELECT TOP 1 Category FROM CategoryAvgDelivery ORDER BY AvgDeliveryTime DESC) AS LongestDeliveryCategory,
    (SELECT TOP 1 AvgDeliveryTime FROM CategoryAvgDelivery ORDER BY AvgDeliveryTime DESC) AS LongestAvgTime,
    (SELECT TOP 1 Category FROM CategoryAvgDelivery ORDER BY AvgDeliveryTime ASC) AS ShortestDeliveryCategory,
    (SELECT TOP 1 AvgDeliveryTime FROM CategoryAvgDelivery ORDER BY AvgDeliveryTime ASC) AS ShortestAvgTime;

-- What is the return rate or complaint rate (based on low ratings)?
SELECT
    CAST(SUM(CASE WHEN Customer_Rating < 3 THEN 1
	ELSE 0 END) AS DECIMAL) * 100 / COUNT(*) AS LowRatingRatePercentage
FROM
    ZEPTO_ORDERS;

-- Find the most frequently purchased category for each city.
SELECT Customer_City, Category, Order_Count
FROM (
    SELECT 
        Customer_City, 
        Category, 
        COUNT(*) AS Order_Count,
        RANK() OVER (
            PARTITION BY Customer_City 
            ORDER BY COUNT(*) DESC
        ) AS rank
    FROM zepto_orders
    GROUP BY Customer_City, Category
) AS ranked
WHERE rank = 1;



-- Do customers using Wallets give higher ratings than those paying with Cash?
SELECT PAYMENT_METHOD,
AVG(CUSTOMER_RATING) AS Average_Rating
FROM ZEPTO_ORDERS
WHERE PAYMENT_METHOD IN ('WALLET','CASH ON DELIVERY')
GROUP BY PAYMENT_METHOD;


-- What is the average delivery time per city and category?

SELECT CUSTOMER_CITY,CATEGORY,
AVG(DELIVERY_TIME_MINUTES) AS AVG_DEL_MINS
FROM ZEPTO_ORDERS
GROUP BY CUSTOMER_CITY,CATEGORY;

-- Which delivery zone (by pincode) has the most late deliveries (e.g., >60 mins)?

SELECT TOP 1
    PINCODE,
    COUNT(*) AS Late_Delivery_Count
FROM
    ZEPTO_ORDERS
WHERE
    DELIVERY_TIME_MINUTES > 60
GROUP BY
    PINCODE
ORDER BY
    Late_Delivery_Count DESC;






SELECT * FROM ZEPTO_ORDERS;