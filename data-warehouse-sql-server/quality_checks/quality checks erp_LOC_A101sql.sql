-- check connectiton to silver.crm_cust_info table wit 

select 
REPLACE(cid ,'-','')  cid
from bronze.erp_LOC_A101
where  REPLACE(cid ,'-','')  not in (select cst_key from silver.crm_cust_info)


-- data standardization & consistency
SELECT DISTINCT CNTRY
 ,CASE WHEN TRIM (CNTRY) = 'DE' then 'Germany'
       WHEN TRIM(CNTRY) IN ('US','USA') THEN 'United State'
       when trim (CNTRY) = '' or trim (CNTRY) is null then 'N/a'
       else CNTRY
end as cntry
FROM bronze.erp_LOC_A101