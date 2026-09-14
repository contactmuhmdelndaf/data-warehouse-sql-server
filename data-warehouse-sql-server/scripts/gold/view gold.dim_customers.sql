
create view gold.dim_customers as 
select 
ROW_NUMBER ()over ( order by cst_id) as customr_key,
ci.cst_id as customer_id,
 ci.cst_key as customer_number,
ci.cst_firstname as first_name ,
ci.cst_lastname as last_name,
cl.cntry as country,

case when ci.cst_gndr != 'n/a' then ci.cst_gndr  -- crm is the master for the gender info
else coalesce (ca.gen,'n/a')
end as gender,

ca.bdate as birth_date,
ci.cst_marital_status as marital_status,
ci.cst_create_date as create_date


from silver.crm_cust_info ci
left join silver.erp_cust_az12  ca
on ci.cst_key= ca.cid
left join silver.erp_loc_a101 cl
on ci.cst_key = cl.cid
