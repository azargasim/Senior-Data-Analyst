-- Query to Identify Fetch's Top 10 Power Users Based on Lifetime Value 
-------------------------------------------------------------------------------------
-- Purpose: This query determines the most valuable users by calculating 
-- their Lifetime Value. The formula considers their average spend, purchase frequency, 
-- and account lifespan to rank them.
-------------------------------------------------------------------------------------

-- STEP 1: Remove duplicate transactions and convert FINAL_SALE to numeric

WITH deduplicated_transactions AS (
SELECT DISTINCT 
USER_ID, 
RECEIPT_ID, 
PURCHASE_DATE, 
FINAL_QUANTITY_NUMERIC, 
SAFE_CAST(NULLIF(FINAL_SALE, '') AS FLOAT64) AS final_sale_numeric
FROM `senior-marketing-analyst.PRODUCTS.TRANSACTION`
),

-- STEP 2: Calculate LTV for each user

user_ltv AS (
SELECT 
users.ID AS USER_ID,
COUNT(deduplicated_transactions.RECEIPT_ID) AS total_receipts_scanned, 
SUM(deduplicated_transactions.FINAL_QUANTITY_NUMERIC * deduplicated_transactions.final_sale_numeric) AS total_spent,
ROUND(AVG(deduplicated_transactions.FINAL_QUANTITY_NUMERIC * deduplicated_transactions.final_sale_numeric), 2) AS avg_spent_per_txn,
ROUND(COUNT(deduplicated_transactions.RECEIPT_ID) / NULLIF(DATE_DIFF(CURRENT_DATE(), DATE(users.CREATED_DATE), MONTH), 0), 2) AS purchase_frequency,
DATE_DIFF(CURRENT_DATE(), DATE(users.CREATED_DATE), MONTH) AS months_active,
-- LTV Formula: Average Spend * Purchase Frequency * Lifespan
ROUND(AVG(deduplicated_transactions.FINAL_QUANTITY_NUMERIC * deduplicated_transactions.final_sale_numeric) * 
      (COUNT(deduplicated_transactions.RECEIPT_ID) / NULLIF(DATE_DIFF(CURRENT_DATE(), DATE(users.CREATED_DATE), MONTH), 0)) * 
      DATE_DIFF(CURRENT_DATE(), DATE(users.CREATED_DATE), MONTH), 2) AS LTV
FROM `senior-marketing-analyst.PRODUCTS.USER` AS users
LEFT JOIN deduplicated_transactions 
ON users.ID = deduplicated_transactions.USER_ID
GROUP BY users.ID, users.CREATED_DATE
),

-- STEP 3: Rank users based on LTV

ranked_users AS (
SELECT 
USER_ID, 
total_receipts_scanned, 
total_spent, 
avg_spent_per_txn, 
purchase_frequency, 
months_active,
LTV,
RANK() OVER (ORDER BY LTV DESC) AS user_rank
FROM user_ltv
)

-- STEP 4: Fetch top 10 power users based on highest LTV

SELECT USER_ID, total_receipts_scanned, ROUND(total_spent,2), avg_spent_per_txn, purchase_frequency, months_active, LTV
FROM ranked_users
WHERE user_rank <= 10;
