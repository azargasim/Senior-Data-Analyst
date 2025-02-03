-- Query to Identify the Leading Brand in the Dips & Salsa Category
-------------------------------------------------------------------------------------
-- This query determines the best-selling brand in the Dips & Salsa category
-- based on total sales. It removes duplicate transactions, calculates total sales 
-- for each brand, and ranks them to find the leader.
-------------------------------------------------------------------------------------

WITH deduplicated_transactions AS (
SELECT DISTINCT 
RECEIPT_ID, 
PURCHASE_DATE, 
USER_ID, 
BARCODE, 
SAFE_CAST(NULLIF(FINAL_QUANTITY, '') AS FLOAT64) AS final_quantity_numeric, -- Convert FINAL_QUANTITY from string to numeric
SAFE_CAST(NULLIF(FINAL_SALE, '') AS FLOAT64) AS final_sale_numeric
FROM `senior-marketing-analyst.PRODUCTS.TRANSACTION`
),

-- STEP 2: Calculate total sales per brand in the Dips & Salsa category

brand_sales AS (
SELECT 
products.BRAND,
SUM(deduplicated_transactions.final_quantity_numeric * COALESCE(deduplicated_transactions.final_sale_numeric, 0)) AS total_sales
FROM deduplicated_transactions
JOIN `senior-marketing-analyst.PRODUCTS.PRODUCTS` AS products
ON deduplicated_transactions.BARCODE = products.BARCODE
WHERE products.CATEGORY_2 = 'Dips & Salsa' -- Filter for Dips & Salsa category
GROUP BY products.BRAND
),

-- STEP 3: Rank brands based on total sales in the category

ranked_brands AS (
SELECT 
BRAND, 
total_sales,
RANK() OVER (ORDER BY total_sales DESC) AS brand_rank
FROM brand_sales
)

-- STEP 4: Select the leading brand 

SELECT BRAND, round (total_sales, 2) 
FROM ranked_brands
WHERE brand_rank = 1;
