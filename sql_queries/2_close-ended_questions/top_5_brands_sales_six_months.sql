-- Query to Find the Top 5 Brands by Sales Among Users Who Have Had Their Account for At Least Six Months
--------------------------------------------------------------------------------------------------------------
-- This query identifies the top 5 brands based on total sales among users 
-- who have been active for at least six months. It removes duplicate transactions, 
-- calculates total sales for each brand, and ranks them accordingly.
--------------------------------------------------------------------------------------------------------------

-- STEP 1: Filter Users Who Have Had an Account for At Least 6 Months

WITH filtered_users AS (
SELECT ID
FROM `senior-marketing-analyst.PRODUCTS.USER`
WHERE DATE_DIFF(CURRENT_DATE(), DATE(CREATED_DATE), MONTH) >= 6
),
-- STEP 2: Remove Duplicate Transactions and Convert Data Types

deduplicated_transactions AS (
SELECT DISTINCT 
RECEIPT_ID, 
PURCHASE_DATE, 
SCAN_DATE, 
STORE_NAME, 
USER_ID, 
BARCODE, 
FINAL_QUANTITY_NUMERIC, 
SAFE_CAST(NULLIF(FINAL_SALE, '') AS FLOAT64) AS final_sale_numeric
FROM `senior-marketing-analyst.PRODUCTS.TRANSACTION`
),

-- STEP 3: Calculate Total Sales per Brand

brand_sales AS (
SELECT 
products.BRAND,
SUM(deduplicated_transactions.FINAL_QUANTITY_NUMERIC * deduplicated_transactions.final_sale_numeric) AS total_sales
FROM filtered_users AS users
JOIN deduplicated_transactions
ON deduplicated_transactions.USER_ID = users.ID
JOIN `senior-marketing-analyst.PRODUCTS.PRODUCTS` AS products
ON deduplicated_transactions.BARCODE = products.BARCODE
WHERE products.BRAND IS NOT NULL
GROUP BY products.BRAND
),

-- Step 4: Rank Brands by Total Sales

ranked_brands AS (
SELECT 
BRAND, 
total_sales,
RANK() OVER (ORDER BY total_sales DESC) AS rnk
FROM brand_sales
)

-- Step 5: Retrieve the Top 5 Brands

SELECT BRAND, total_sales
FROM ranked_brands
WHERE rnk <= 5;