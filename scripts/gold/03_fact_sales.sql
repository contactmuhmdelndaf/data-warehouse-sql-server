/*
===============================================================================
Gold View: fact_sales
===============================================================================
Grain:
    One row per cleansed source sales-detail row.
===============================================================================
*/

CREATE OR ALTER VIEW gold.fact_sales AS
SELECT
    sd.sls_ord_num AS order_number,
    pr.product_key,
    cu.customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt AS shipping_date,
    sd.sls_due_dt AS due_date,
    sd.sls_sales AS sales_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price AS price
FROM silver.crm_sales_details AS sd
LEFT JOIN gold.dim_customers AS cu
    ON cu.customer_id = sd.sls_cust_id
LEFT JOIN gold.dim_products AS pr
    ON sd.sls_prd_key = pr.product_number;
