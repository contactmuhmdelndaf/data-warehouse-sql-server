# Source Datasets

The warehouse expects six CSV extracts, grouped by source system:

```text
datasets/
├── source_crm/
│   ├── cust_info.csv
│   ├── prd_info.csv
│   └── sales_details.csv
└── source_erp/
    ├── CUST_AZ12.csv
    ├── LOC_A101.csv
    └── PX_CAT_G1V2.csv
```

The raw CSV files are intentionally not committed. Place your local copies in the structure above (or another local directory) and update the `BULK INSERT` paths in `scripts/bronze/02_load_bronze.sql` before running the Bronze load.

See [`docs/data_profile.md`](../docs/data_profile.md) for a documented profile of the supplied source extracts.
