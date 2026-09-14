/*
===============================================================================
Gold Quality Checks: dim_customers
===============================================================================
Expected result for every query: no rows returned, except the final row-count
summary which is informational.
===============================================================================
*/

-- 1. Surrogate key must be unique and non-null.
SELECT customer_key, COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING customer_key IS NULL OR COUNT(*) > 1;

-- 2. Source customer identifier should be unique in the dimension.
SELECT customer_id, COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_id
HAVING customer_id IS NULL OR COUNT(*) > 1;

-- 3. Customer business number should not contain leading/trailing spaces.
SELECT *
FROM gold.dim_customers
WHERE customer_number <> TRIM(customer_number);

-- 4. Standardized categorical values should remain inside the expected domain.
SELECT DISTINCT gender
FROM gold.dim_customers
WHERE gender NOT IN ('Male', 'Female', 'N/A', 'n/a')
   OR gender IS NULL;

SELECT DISTINCT marital_status
FROM gold.dim_customers
WHERE marital_status NOT IN ('Single', 'Married', 'N/A', 'n/a')
   OR marital_status IS NULL;

-- Informational row count.
SELECT COUNT(*) AS dim_customers_row_count
FROM gold.dim_customers;
