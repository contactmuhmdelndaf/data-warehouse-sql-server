/*
===============================================================================
Gold Quality Checks: dim_products
===============================================================================
Expected result for every validation query: no rows returned, except the final
row-count summary which is informational.
===============================================================================
*/

-- 1. Surrogate key must be unique and non-null.
SELECT product_key, COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING product_key IS NULL OR COUNT(*) > 1;

-- 2. Current product business key should be unique in the Gold dimension.
SELECT product_number, COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_number
HAVING product_number IS NULL OR COUNT(*) > 1;

-- 3. Product cost must not be negative.
SELECT *
FROM gold.dim_products
WHERE cost < 0;

-- 4. Required descriptive fields should be present.
SELECT *
FROM gold.dim_products
WHERE product_name IS NULL
   OR TRIM(product_name) = '';

-- Informational row count.
SELECT COUNT(*) AS dim_products_row_count
FROM gold.dim_products;
