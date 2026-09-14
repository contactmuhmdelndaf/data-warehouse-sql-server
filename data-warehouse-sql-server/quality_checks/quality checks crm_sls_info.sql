--check unwaneted spaces in sls_ord_num
select sls_ord_num,
	   sls_prd_key
	   from bronze.crm_sales_details
	   where sls_ord_num  != trim(sls_ord_num)


--check join between bronze.crm_sales_details and silver.crm_prd_info |prd_key|
select
	sls_ord_num,
	sls_prd_key
	from bronze.crm_sales_details
	where sls_prd_key not in (select prd_key from silver.crm_prd_info)


--check join between bronze.crm_sales_details and silver.crm_cust_info |cst_id|
select
	sls_ord_num,
	sls_prd_key,
	sls_cust_id
	from bronze.crm_sales_details
	where sls_cust_id not in (select cst_id from silver.crm_cust_info)


--check for invaild dates in bronze.crm_sales_details
  select
		*
	from silver.crm_sales_details
	where sls_order_dt <= 0   
	or len(sls_order_dt)!= 8 
	or sls_order_dt > 20260101 
	or sls_order_dt < 19000101

select sls_order_dt
  from silver.crm_sales_details
  where sls_order_dt > sls_ship_dt  or sls_order_dt > sls_due_dt


  -- check business rules for sales details
  select  
  sls_sales,
	  sls_price,
	  sls_quantity
  from silver.crm_sales_details
 where sls_sales!= sls_quantity * abs(sls_price)


--



