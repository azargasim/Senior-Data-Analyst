-- Query to List All Columns and Their Data Types
-----------------------------------------------------------------
-- This query helps identify column names and their data types 
-- from the USER, TRANSACTION, and PRODUCTS tables.
-----------------------------------------------------------------

SELECT 
table_name,
column_name,
data_type
FROM `senior-marketing-analyst.PRODUCTS.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name IN ('USER', 'TRANSACTION', 'PRODUCTS')
ORDER BY table_name, column_name;
