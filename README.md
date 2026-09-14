# data-warehouse-sql-server
A complete SQL Server Data Warehouse (Bronze → Silver → Gold)
# SQL Server Data Warehouse Project

A complete Data Warehouse built on SQL Server following the Medallion Architecture (Bronze, Silver, Gold).

## Project Overview

This project consolidates data from CRM and ERP systems into a clean, analytics-ready Data Warehouse, modeled as a Star Schema for BI tools.

## Architecture

- **Bronze**: Raw data from CSV sources
- **Silver**: Cleaned and standardized data
- **Gold**: Star Schema (Fact + Dimensions)

## Data Sources

**CRM System:**
- Customer information
- Product information
- Sales transactions

**ERP System:**
- Customer demographics
- Customer location
- Product categories

## Tools

- SQL Server
- T-SQL
- Git & GitHub

## Project Structure

- scripts/bronze - Bronze layer scripts
- scripts/silver - Silver layer scripts
- scripts/gold - Gold layer views
- quality_checks - Data quality scripts
- docs - Diagrams and documentation

## How to Run

1. Create database: DataWarehouse
2. Create schemas: bronze, silver, gold
3. Run bronze.load_bronze
4. Run silver.load_silver
5. Run scripts in scripts/gold
6. Run scripts in quality_checks

## Key Features

- Medallion Architecture
- Stored Procedures for ETL
- Deduplication using ROW_NUMBER
- SCD Type 2 using LEAD
- Star Schema design
- Data quality checks
- Error handling with TRY CATCH

## Author

Your Name
- GitHub: muhmd_elndaf
