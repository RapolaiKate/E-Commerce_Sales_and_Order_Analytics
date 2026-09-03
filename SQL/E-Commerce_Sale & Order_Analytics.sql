-- DATABASE SETUP

CREATE DATABASE
ecommerce_sales_analysis;

-- Select the database
USE ecommerce_sales_analysis;

-- Display the tables in the ecommerce_sales_analysis database
SHOW TABLES;

-- DATA INSPECTION

-- Preview the first 10 records
SELECT *
FROM ecommerce_sales
LIMIT 10;

-- Check the Total Number of Records 
SELECT
COUNT(*) AS Total_Records
FROM ecommerce_sales;

-- OVERALL SALES METRICS

-- Total Revenue
SELECT 
SUM(TotalPrice) AS Total_Revenue
FROM ecommerce_sales;

-- Total Quantity Sold
SELECT
SUM(Quantity) AS Total_Quantity_Sold
FROM ecommerce_sales;

-- Mimimum order values
SELECT
MIN(TotalPrice) AS Minimum_Order_Value
FROM ecommerce_sales;

-- Maximum order values
SELECT
MAX(TotalPrice) AS Maximum_Order_Value
FROM ecommerce_sales;

-- Average order values
SELECT
AVG(TotalPrice) AS Average_Order_Value
FROM ecommerce_sales;

-- Revenue Validation
-- Verify Total, Minimum, Maximum and Average Order Values
SELECT
SUM(TotalPrice) AS Total_Revenue,
MIN(TotalPrice) AS Minimum_Order_Value,
MAX(TotalPrice) AS Maximum_Order_Value,
AVG(TotalPrice)AS Average_Order_Value
FROM ecommerce_sales;

-- PRODUCT ANALYSI

-- Revenue by Product
SELECT
Product,
SUM(TotalPrice) AS Total_Revenue
FROM ecommerce_sales
GROUP BY Product
ORDER BY Total_Revenue DESC;

-- Quantity Sold by Product
SELECT
Product,
SUM(Quantity) AS Total_Quantity_Sold
FROM ecommerce_sales
GROUP BY Product
ORDER BY Total_Quantity_Sold DESC;

-- PAYMENT METHOD ANALYSIS

-- Orders by Payment Method
SELECT
PaymentMethod,
COUNT(*) AS Total_Orders
FROM ecommerce_sales
GROUP BY PaymentMethod
ORDER BY Total_Orders DESC;

-- ORDER STATUS ANALYSIS

-- Orders by Order Status
SELECT
OrderStatus,
COUNT(*) AS Total_Orders
FROM ecommerce_sales
GROUP BY OrderStatus
ORDER BY Total_Orders DESC;

-- Revenue by Order Status
SELECT
OrderStatus,
SUM(TotalPrice) AS Total_Revenue
FROM ecommerce_sales
GROUP BY OrderStatus
ORDER BY Total_Revenue DESC;

-- REFERRAL SOURCE ANALYSIS

-- Revenue by Referral Source
SELECT
ReferralSource,
SUM(TotalPrice) AS Total_Revenue
FROM ecommerce_sales
GROUP BY ReferralSource
ORDER BY Total_Revenue DESC;

-- CUSTOMER ANALYSIS

-- Order Per Customer
SELECT
CustomerID,
COUNT(*) AS Total_Orders
FROM ecommerce_sales
GROUP BY CustomerID
ORDER BY Total_Orders DESC;

-- Top Customers by Revenue
SELECT
CustomerID,
SUM(TotalPrice) AS Total_Revenue
FROM ecommerce_sales
GROUP BY CustomerID
ORDER BY Total_Revenue DESC;

-- DATA VALIDATION

-- Check for duplicate rows
SELECT
COUNT(*) ASDuplicate_Rows
FROM (
SELECT
Date,
CustomerID,
Product,
Quantity,
UnitPrice,
ShippingAddress,
PaymentMethod,
OrderStatus,
TrackingNumber,
ItemsInCart,
CouponCode,
ReferralSource,
TotalPrice
FROM ecommerce_sales
GROUP BY 
Date,
CustomerID,
Product,
Quantity,
UnitPrice,
ShippingAddress,
PaymentMethod,
OrderStatus,
TrackingNumber,
ItemsInCart,
CouponCode,
ReferralSource,
TotalPrice
HAVING COUNT(*) > 1
) AS duplicates;

-- Check Missing Values
SELECT 
SUM(CustomerID IS NULL OR CustomerID = '') AS Missing_CustomerID,
SUM(Product IS NULL OR Product = '') AS Missing_Product,
SUM(Quantity IS NULL OR Quantity = '') AS Missing_Quantity,
SUM(UnitPrice IS NULL OR UnitPrice = '') AS Missing_UnitPrice,
SUM(PaymentMethod IS NULL OR PaymentMethod = '') AS Missing_PaymentMethod,
SUM(OrderStatus IS NULL OR OrderStatus = '') AS Missing_OrderStatus,
SUM(TotalPrice IS NULL OR TotalPrice = '') AS Missing_TotalPrice
FROM ecommerce_sales;

-- Count unique customers
SELECT
COUNT(DISTINCT CustomerID) AS Unique_Customers
FROM ecommerce_sales;