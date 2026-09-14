/*
===============================================================================
Analytics: Sales Analysis
===============================================================================
*/

-- Monthly sales trend.
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT order_number) AS total_orders,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

-- Yearly sales performance.
SELECT
    YEAR(order_date) AS order_year,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT order_number) AS total_orders,
    COUNT(DISTINCT customer_key) AS purchasing_customers
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY order_year;
