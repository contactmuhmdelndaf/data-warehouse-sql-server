# Source Data Profile

Generated from the six source CSV files supplied with the project.

| Source file | Rows | Notable quality observations |
| --- | ---: | --- |
| `cust_info.csv` | 18,494 | Missing customer IDs, names and gender values; leading/trailing spaces in names. |
| `prd_info.csv` | 397 | Missing product costs/lines; many open-ended product end dates; source contains inconsistent historical date ranges. |
| `sales_details.csv` | 60,398 | Missing sales amounts/prices in a small number of rows; requires derived corrections in Silver. |
| `CUST_AZ12.csv` | 18,484 | Missing gender values; customer IDs require normalization before joining to CRM. |
| `LOC_A101.csv` | 18,484 | Missing country values; country codes/names require standardization. |
| `PX_CAT_G1V2.csv` | 37 | Complete category lookup in the supplied extract. |

## Why the Silver layer exists

The source extracts intentionally contain data-quality issues that are handled by the transformation layer, including whitespace cleanup, null handling, standardization of gender/marital status/country values, customer ID normalization, date validation, historical product handling, and correction of inconsistent sales measures.

> Raw CSV data is not committed to the repository. This profile documents the supplied extracts while keeping the repository lightweight and avoiding uncertainty around redistribution rights.
