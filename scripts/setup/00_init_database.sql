/*
===============================================================================
Database Initialization: DataWarehouse
===============================================================================
Purpose:
    Creates the DataWarehouse database (when it does not already exist) and the
    Bronze, Silver, and Gold schemas required by the project.
===============================================================================
*/

USE master;
GO

IF DB_ID('DataWarehouse') IS NULL
BEGIN
    CREATE DATABASE DataWarehouse;
END;
GO

USE DataWarehouse;
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'bronze')
    EXEC('CREATE SCHEMA bronze');
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'silver')
    EXEC('CREATE SCHEMA silver');
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'gold')
    EXEC('CREATE SCHEMA gold');
GO

PRINT 'DataWarehouse database and schemas are ready.';
GO
