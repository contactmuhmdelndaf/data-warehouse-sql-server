--check for duplicate and nulls values in the crm_cust_info table in the bronze schema  (cst_id)
--|no dublicate found|
select cst_id ,count(*)
from silver.crm_cust_info
group by cst_id
having count(*) > 1 or cst_id is null

--check for unwanted spaces (cst_firstname, cst_lastname, cst_marital_status, cst_gndr) 
--| no results found|
select cst_firstname from silver.crm_cust_info 
where cst_firstname !=trim (cst_firstname)

select cst_lastname from silver.crm_cust_info 
where cst_lastname != trim(cst_lastname)

select cst_marital_status from silver.crm_cust_info 
where cst_marital_status != trim (cst_marital_status)


select cst_gndr from silver.crm_cust_info 
where cst_gndr !=trim (cst_gndr)


-- data normalization  & data conisistency (cst_marital_status, cst_gndr)
select distinct cst_marital_status from silver.crm_cust_info -- ( M -> Married , S -> Single)

select distinct cst_gndr from silver.crm_cust_info -- ( F -> Female , M -> male)

