-- Query to Find the Top 5 Brands by Receipts Scanned Among Users 21 and Over
-------------------------------------------------------------------------------------
-- This query identifies the top 5 brands based on the number of receipts scanned 
-- by users who are at least 21 years old. It removes duplicate transactions, ranks brands, 
-- and ensures ties are handled correctly.
-------------------------------------------------------------------------------------
-- STEP 1: Remove Duplicate Transactions
WITH deduplicated_transactions AS (
SELECT DISTINCT RECEIPT_ID, PURCHASE_DATE, SCAN_DATE, STORE_NAME, USER_ID, BARCODE, FINAL_QUANTITY, FINAL_SALE
FROM `senior-marketing-analyst.PRODUCTS.TRANSACTION`
),
--STEP 2: Count Receipts Scanned Per Brand
brand_counts AS (
SELECT 
products.BRAND,
COUNT(deduplicated_transactions.RECEIPT_ID) AS receipts_scanned
FROM `senior-marketing-analyst.PRODUCTS.USER` AS users
JOIN deduplicated_transactions
ON deduplicated_transactions.USER_ID = users.ID
JOIN `senior-marketing-analyst.PRODUCTS.PRODUCTS` AS products
ON deduplicated_transactions.BARCODE = products.BARCODE
WHERE 
DATE_DIFF(CURRENT_DATE(), DATE(users.BIRTH_DATE), YEAR) >= 21
AND products.BRAND IS NOT NULL
GROUP BY products.BRAND
),
--STEP 3: Rank Brands Based on Receipts Scanned
ranked_brands AS (
SELECT 
BRAND, 
receipts_scanned, 
ROW_NUMBER() OVER (ORDER BY receipts_scanned DESC, BRAND ASC) AS rn
FROM brand_counts
)
--STEP 4: Retrieve the Top 5 Brands
SELECT BRAND, receipts_scanned
FROM ranked_brands
WHERE rn <= 5;
