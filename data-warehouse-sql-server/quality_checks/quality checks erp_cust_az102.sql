-- check connection  between bronze.erp_CUST_AZ12 | cid | and  silver.crm_cust_info | cst_key |
select 
CID
from silver.erp_CUST_AZ12
WHERE case when cid like 'nas%'then SUBSTRING(CID, 4, LEN(CID)) else CID
end  NOT IN (SELECT cst_key FROM silver.crm_cust_info)

-- check data standardization & consistency
 select distinct gen
 from silver.erp_CUST_AZ12