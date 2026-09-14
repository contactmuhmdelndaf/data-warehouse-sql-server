/*
===============================================================================
Analytics: Product Analysis
===============================================================================
*/

-- Top products by revenue.
SELECT TOP 20
    p.product_key,
    p.product_number,
    p.product_name,
    p.category,
    p.subcategory,
    SUM(f.sales_amount) AS total_sales,
    SUM(f.quantity) AS total_quantity
FROM gold.fact_sales f
JOIN gold.dim_products p
    ON f.product_key = p.product_key
GROUP BY
    p.product_key,
    p.product_number,
    p.product_name,
    p.category,
    p.subcategory
ORDER BY total_sales DESC;

-- Category performance.
SELECT
    p.category,
    SUM(f.sales_amount) AS total_sales,
    SUM(f.quantity) AS total_quantity,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM gold.fact_sales f
JOIN gold.dim_products p
    ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY total_sales DESC;
