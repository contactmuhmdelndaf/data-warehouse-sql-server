/*
===============================================================================
Gold Quality Checks: fact_sales
===============================================================================
Expected result for every validation query: no rows returned, except the final
row-count summary which is informational.
===============================================================================
*/

-- 1. Every fact row should resolve to a customer dimension row.
SELECT *
FROM gold.fact_sales
WHERE customer_key IS NULL;

-- 2. Every fact row should resolve to a product dimension row.
SELECT *
FROM gold.fact_sales
WHERE product_key IS NULL;

-- 3. Quantity, price, and sales amount should be positive.
SELECT *
FROM gold.fact_sales
WHERE quantity <= 0
   OR price <= 0
   OR sales_amount <= 0;

-- 4. Sales amount should equal quantity multiplied by unit price.
SELECT *
FROM gold.fact_sales
WHERE sales_amount <> quantity * price;

-- 5. Shipping/due dates should not precede the order date when all dates exist.
SELECT *
FROM gold.fact_sales
WHERE (shipping_date IS NOT NULL AND order_date IS NOT NULL AND shipping_date < order_date)
   OR (due_date IS NOT NULL AND order_date IS NOT NULL AND due_date < order_date);

-- Informational row count.
SELECT COUNT(*) AS fact_sales_row_count
FROM gold.fact_sales;
