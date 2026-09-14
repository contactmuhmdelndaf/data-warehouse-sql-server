/*
===============================================================================
Gold View: dim_customers
===============================================================================
Grain:
    One row per cleansed CRM customer.
===============================================================================
*/

CREATE OR ALTER VIEW gold.dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY ci.cst_id) AS customer_key,
    ci.cst_id AS customer_id,
    ci.cst_key AS customer_number,
    ci.cst_firstname AS first_name,
    ci.cst_lastname AS last_name,
    cl.cntry AS country,
    CASE
        WHEN ci.cst_gndr <> 'n/a' THEN ci.cst_gndr  -- CRM is the master for gender.
        ELSE COALESCE(ca.gen, 'n/a')
    END AS gender,
    ca.bdate AS birth_date,
    ci.cst_marital_status AS marital_status,
    ci.cst_create_date AS create_date
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca
    ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 AS cl
    ON ci.cst_key = cl.cid;
