-- Query to Calculate the Percentage of Sales in the Health & Wellness Category by Generation
--------------------------------------------------------------------------------------------------
-- This query identifies how much of the total sales in the Health & Wellness category 
-- is contributed by each generation. It calculates total sales per generation, determines 
-- the overall category sales, and then computes each generation's percentage of the total.
--------------------------------------------------------------------------------------------------

-- STEP 1: Remove duplicate transactions and convert FINAL_SALE to numeric

WITH deduplicated_transactions AS (
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

-- STEP 2: Categorize users into generations based on their birth year

user_generations AS (

SELECT 
ID AS USER_ID,
CASE 
WHEN DATE_DIFF(CURRENT_DATE(), DATE(BIRTH_DATE), YEAR) >= 78 THEN 'Silent Gen'      
WHEN DATE_DIFF(CURRENT_DATE(), DATE(BIRTH_DATE), YEAR) BETWEEN 60 AND 77 THEN 'Boomers' 
WHEN DATE_DIFF(CURRENT_DATE(), DATE(BIRTH_DATE), YEAR) BETWEEN 44 AND 59 THEN 'Gen X'   
WHEN DATE_DIFF(CURRENT_DATE(), DATE(BIRTH_DATE), YEAR) BETWEEN 28 AND 43 THEN 'Millennials'
ELSE 'Gen Z' -- Younger than 28 years old
END AS generation
FROM `senior-marketing-analyst.PRODUCTS.USER`
),

-- STEP 3: Filter Health & Wellness category and calculate total sales per generation

category_sales AS (

SELECT 
user_generations.generation,
ROUND(SUM(deduplicated_transactions.FINAL_QUANTITY_NUMERIC * deduplicated_transactions.final_sale_numeric), 2) AS health_wellness_sales 
FROM deduplicated_transactions
JOIN user_generations 
ON deduplicated_transactions.USER_ID = user_generations.USER_ID
JOIN `senior-marketing-analyst.PRODUCTS.PRODUCTS` AS products
ON deduplicated_transactions.BARCODE = products.BARCODE
WHERE products.CATEGORY_1 = 'Health & Wellness' 
GROUP BY user_generations.generation
),

total_health_wellness_sales AS (

-- STEP 4: Calculate total sales for Health & Wellness category across all generations

SELECT 
SUM(health_wellness_sales) AS total_health_wellness_sales
FROM category_sales
)

-- STEP 5: Calculate each generation's percentage of total Health & Wellness sales

SELECT 
category_sales.generation, 
category_sales.health_wellness_sales, 
ROUND((category_sales.health_wellness_sales / total_health_wellness_sales.total_health_wellness_sales), 2) AS health_wellness_sales_pct
FROM category_sales
CROSS JOIN total_health_wellness_sales
ORDER BY health_wellness_sales_pct DESC; 
