/*
===============================================================================
Analytics: Customer Analysis
===============================================================================
*/

-- Top customers by revenue.
SELECT TOP 20
    c.customer_key,
    c.customer_number,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.country,
    SUM(f.sales_amount) AS total_sales,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM gold.fact_sales f
JOIN gold.dim_customers c
    ON f.customer_key = c.customer_key
GROUP BY
    c.customer_key,
    c.customer_number,
    c.first_name,
    c.last_name,
    c.country
ORDER BY total_sales DESC;

-- Customer distribution by country.
SELECT
    country,
    COUNT(*) AS total_customers
FROM gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC;
