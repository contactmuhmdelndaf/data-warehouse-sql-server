

create or alter procedure silver.load_silver as
begin
 DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
begin try
    SET @batch_start_time = GETDATE();

	PRINT '================================================';
		PRINT 'Loading silver Layer';
		PRINT '================================================';

		PRINT '------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------------';

      SET @start_time = GETDATE();  

	print '>> truncating silver.crm_cust_info'
	truncate table silver.crm_cust_info
	print '>>insert into silver.crm_cust_info'
	insert into silver.crm_cust_info(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date)
	select 
	cst_id,
	cst_key,
	 trim (cst_firstname) as cst_firstname ,
	trim(cst_lastname) as cst_lastname,
	case when  trim (upper (cst_marital_status ))= 's' then 'Single'
		 when  trim (upper (cst_marital_status ))= 'm' then 'Married'
		  else 'N/A'
		 end as cst_marital_status,
	case when  trim (upper (cst_gndr)) = 'f' then 'Female'
		 when  trim (upper (cst_gndr)) = 'm' then 'Male'
		 else 'N/A'
		 end as cst_gndr,
	cst_create_date
	from(
	select *,
	row_number() over(partition by cst_id order by cst_create_date desc) as   flag_last
	from bronze.crm_cust_info
	where cst_id is not null)t
	where flag_last = 1
			SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';


      SET @start_time = GETDATE();  

	print '>>truncateing silver.crm_prd_info'
	truncate table  silver.crm_prd_info
	print '>>inserting silver.crm_prd_info'
	 insert into silver.crm_prd_info
	 (prd_id
	 ,cat_id
	 ,prd_key
	 ,prd_nm
	 ,prd_cost
	 ,prd_line
	 ,prd_start_dt
	 ,prd_end_dt)
	select 
	prd_id,
	replace (SUBSTRING (prd_key,1,5 ),'-' ,'_' ) AS cat_id,
	SUBSTRING (prd_key,7,LEN (prd_key)) AS prd_key
	, trim (prd_nm) as prd_nm
	, isnull (prd_cost,0) AS prd_cost
	, case upper (trim(prd_line))
		  when 'r' then 'Road'
		  when 'm' then 'Mountain'
		  when 't' then 'Touring'
		  when 's' then 'Other sales'
		  else 'N/a'
	end AS prd_line
	,  cast (prd_start_dt as date) as prd_start_dt
	, cast (lead (prd_start_dt )over (partition by prd_key order by prd_start_dt  )-1 as date) as prd_end_dt
	from bronze.crm_prd_info
	
     
	 	SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

  SET @start_time = GETDATE();
	print'>>trucating silver.crm_sales_details'
	truncate table silver.crm_sales_details;
	print' >>inserting silver.crm_sales_details'
	insert into silver.crm_sales_details (
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			sls_order_dt,
			sls_ship_dt,
			sls_due_dt,
			sls_sales,
			sls_quantity,
			sls_price)

	select sls_ord_num,
		   sls_prd_key,
		   sls_cust_id,
		   case when sls_order_dt = 0  or len (sls_order_dt) != 8 then null
				else cast( cast (sls_order_dt as varchar)as date)
				 end as sls_order_dt ,
		   case when sls_ship_dt = 0  or len (sls_ship_dt) != 8 then null
				else cast( cast (sls_ship_dt as varchar)as date)
				 end as sls_ship_dt
		   ,case when  sls_due_dt = 0  or len ( sls_due_dt) != 8 then null
				else cast( cast ( sls_due_dt as varchar)as date)
				 end as  sls_due_dt
		  ,
		   case when sls_sales is null or sls_sales <= 0  or sls_sales != sls_quantity * abs (sls_price)
			then  sls_quantity * abs (sls_price) 
		 else sls_sales 
			   end as sls_sales  ,
		   sls_quantity,
		   case when  sls_price is null or  sls_price <= 0  
			then  sls_sales / nullif (sls_quantity,0)
		 else sls_price
			   end as sls_price
	from bronze.crm_sales_details
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		  SET @start_time = GETDATE();

	print '>>truncateing silver.erp_cust_az12'
	truncate table silver.erp_cust_az12;
	print '>>inserting silver.erp_cust_az12'
	insert into silver.erp_cust_az12 
	(cid, bdate, gen)
	select 
	case when cid like 'nas%'then SUBSTRING(CID, 4, LEN(CID)) else CID
	end as cid,
	CASE WHEN BDATE > GETDATE()
	 then  null
	 ELSE BDATE
	 END AS BDATE ,
	  case when upper (trim(gen)) in ('M','MALE') then 'Male'
		 when upper(trim(gen)) in ('F','FEMALE') then 'Female'
		 else 'n/a'
		 end as gen
	from bronze.erp_CUST_AZ12
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
		  SET @start_time = GETDATE();
	print '>>truncating silver.erp_loc_a101'
	truncate table silver.erp_loc_a101
	print '>>inserting silver.erp_loc_a101'
	insert into silver.erp_loc_a101(cid, cntry)

	select REPLACE(cid ,'-','') as cid, 
	CASE WHEN TRIM (CNTRY) = 'DE' then 'Germany'
		   WHEN TRIM(CNTRY) IN ('US','USA') THEN 'United State'
		   when trim (CNTRY) = '' or trim (CNTRY) is null then 'N/a'
		   else CNTRY
	end as cntry
	from bronze.erp_LOC_A101 
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		  SET @start_time = GETDATE();
	print'>> truncating silver.erp_PX_CAT_G1V2'
	truncate table silver.erp_PX_CAT_G1V2;
	print '>>inserting silver.erp_PX_CAT_G1V2 '
	insert into  silver.erp_px_cat_g1v2 (id, cat, subcat, maintenance)

	SELECT id ,
		  cat ,
		   subcat ,
		  maintenance
	FROM bronze.erp_PX_CAT_G1V2	
	 SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
	 SET @batch_end_time =  GETDATE();
	 PRINT '=========================================='
		PRINT 'Loading silver Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
 END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING silver LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
end
