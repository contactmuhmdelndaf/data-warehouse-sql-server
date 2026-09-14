-- check unwanted sapces 
select * from bronze.erp_PX_CAT_G1V2
where cat != trim (CAT ) or subcat != trim (SUBCAT) or maintenance != trim (MAINTENANCE)

--check data standardization & consistency
select distinct cat
 from bronze.erp_PX_CAT_G1V2


select distinct SUBCAT
 from bronze.erp_PX_CAT_G1V2

 select distinct MAINTENANCE
 from bronze.erp_PX_CAT_G1V2
