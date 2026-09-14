/*
===============================================================================
Analytics: KPI Summary
===============================================================================
Purpose:
    Provides a compact business overview from the Gold layer.
===============================================================================
*/

SELECT
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity,
    AVG(CAST(price AS DECIMAL(18,2))) AS average_selling_price,
    COUNT(DISTINCT order_number) AS total_orders,
    COUNT(DISTINCT product_key) AS products_sold,
    COUNT(DISTINCT customer_key) AS purchasing_customers
FROM gold.fact_sales;

SELECT COUNT(*) AS total_customers
FROM gold.dim_customers;

SELECT COUNT(*) AS total_products
FROM gold.dim_products;
