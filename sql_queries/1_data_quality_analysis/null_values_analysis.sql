-- Query to Analyze Null Values
-- ---------------------------------------------------
-- This query detects missing values (NULLs) 
-- in the USER, TRANSACTION, and PRODUCTS tables. 
-- It also calculates the percentage of missing values for each column.
-- ---------------------------------------------------

-- STEP 1: Get the total number of rows in each table

WITH total_counts AS (
    SELECT 'USER' AS Table_Name, COUNT(*) AS Total_Rows FROM `senior-marketing-analyst.PRODUCTS.USER`
    UNION ALL
    SELECT 'TRANSACTION', COUNT(*) FROM `senior-marketing-analyst.PRODUCTS.TRANSACTION`
    UNION ALL
    SELECT 'PRODUCT', COUNT(*) FROM `senior-marketing-analyst.PRODUCTS.PRODUCTS`
),

-- STEP 2: Count NULL values in each column across all tables

null_counts AS (
    SELECT 'USER_ID' AS Column_Name, COUNT(*) AS Total_Rows,
    SUM(CASE WHEN ID IS NULL THEN 1 ELSE 0 END) AS Null_Quantity
    FROM `senior-marketing-analyst.PRODUCTS.USER`
    UNION ALL
    SELECT 'CREATED_DATE', COUNT(*),
    SUM(CASE WHEN CREATED_DATE IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.USER`
    UNION ALL
    SELECT 'BIRTH_DATE', COUNT(*),
    SUM(CASE WHEN BIRTH_DATE IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.USER`
    UNION ALL
    SELECT 'STATE', COUNT(*),
    SUM(CASE WHEN STATE IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.USER`
    UNION ALL
    SELECT 'LANGUAGE', COUNT(*),
    SUM(CASE WHEN LANGUAGE IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.USER`
    UNION ALL
    SELECT 'GENDER', COUNT(*),
    SUM(CASE WHEN GENDER IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.USER`
    
    UNION ALL
    SELECT 'RECEIPT_ID', COUNT(*),
    SUM(CASE WHEN RECEIPT_ID IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.TRANSACTION`
    UNION ALL
    SELECT 'PURCHASE_DATE', COUNT(*),
    SUM(CASE WHEN PURCHASE_DATE IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.TRANSACTION`
    UNION ALL
    SELECT 'SCAN_DATE', COUNT(*),
    SUM(CASE WHEN SCAN_DATE IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.TRANSACTION`
    UNION ALL
    SELECT 'STORE_NAME', COUNT(*),
    SUM(CASE WHEN STORE_NAME IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.TRANSACTION`
    UNION ALL
    SELECT 'TRANSACTION_USER_ID', COUNT(*),
    SUM(CASE WHEN USER_ID IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.TRANSACTION`
    UNION ALL
    SELECT 'BARCODE', COUNT(*),
    SUM(CASE WHEN BARCODE IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.TRANSACTION`
    UNION ALL
    SELECT 'FINAL_SALE', COUNT(*),
    SUM(CASE WHEN FINAL_SALE IS NULL OR TRIM(FINAL_SALE) = '' THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.TRANSACTION`
    UNION ALL
    SELECT 'FINAL_QUANTITY', COUNT(*),
    SUM(CASE WHEN SAFE_CAST(NULLIF(FINAL_QUANTITY, '') AS FLOAT64) IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.TRANSACTION`
    
    UNION ALL
    SELECT 'CATEGORY_1', COUNT(*),
    SUM(CASE WHEN CATEGORY_1 IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.PRODUCTS`
    UNION ALL
    SELECT 'CATEGORY_2', COUNT(*),
    SUM(CASE WHEN CATEGORY_2 IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.PRODUCTS`
    UNION ALL
    SELECT 'CATEGORY_3', COUNT(*),
    SUM(CASE WHEN CATEGORY_3 IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.PRODUCTS`
    UNION ALL
    SELECT 'CATEGORY_4', COUNT(*),
    SUM(CASE WHEN CATEGORY_4 IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.PRODUCTS`
    UNION ALL
    SELECT 'BRAND', COUNT(*),
    SUM(CASE WHEN BRAND IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.PRODUCTS`
    UNION ALL
    SELECT 'MANUFACTURER', COUNT(*),
    SUM(CASE WHEN MANUFACTURER IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.PRODUCTS`
    UNION ALL
    SELECT 'PRODUCT_BARCODE', COUNT(*),
    SUM(CASE WHEN BARCODE IS NULL THEN 1 ELSE 0 END)
    FROM `senior-marketing-analyst.PRODUCTS.PRODUCTS`
)

-- STEP 3: Calculate NULL percentage for each column and display results

SELECT 
Column_Name,
Total_Rows, 
Null_Quantity,
ROUND((Null_Quantity / NULLIF(Total_Rows, 0)) * 100, 2) AS Percentage
FROM null_counts
ORDER BY Null_Quantity DESC;



