-- check for nulls or duplicates in crm_prd_info
select 
  prd_id,count (*)
from silver.crm_prd_info
group by prd_id
having count(*) > 1 or prd_id is null

-- check of category id is matching with id in bronze.erp_px_cat_g1v2
SELECT prd_id
FROM bronze.crm_prd_info
WHERE REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_')  IN (
    SELECT DISTINCT id 
    FROM bronze.erp_px_cat_g1v2
)
-- check of prd_key is matching with sls_prd_key in bronze.crm_sales_details
SELECT prd_id
FROM bronze.crm_prd_info
WHERE SUBSTRING (prd_key,7,LEN (prd_key))   IN (
    SELECT DISTINCT sls_prd_key
    FROM bronze.crm_sales_details
)

-- check of spaces in prd_nm
select prd_nm 
from silver.crm_prd_info
where prd_nm !=trim(prd_nm)



--check of prd_cost is not negative or null
select prd_cost
from silver.crm_prd_info
where prd_cost < 0 or prd_cost is null

-- data standardization & cosistency checks for prd_line |  prd_info  |
select distinct prd_line
from silver.crm_prd_info

--check for invaild dates in prd_start_dt and prd_end_dt
select*
from bronze.crm_prd_info
where prd_start_dt > prd_end_dt or prd_start_dt is null or prd_end_dt is null