-- Query to Identify Duplicate Transactions
-----------------------------------------------------
-- This query detects duplicate transaction records
-- in the TRANSACTION table by grouping based on key transaction fields.
-- It helps identify data quality issues such as multiple entries for the same purchase.
-----------------------------------------------------

SELECT 
RECEIPT_ID,PURCHASE_DATE,SCAN_DATE,STORE_NAME,USER_ID, BARCODE, FINAL_QUANTITY, FINAL_SALE,
COUNT(*) AS duplicate_count
FROM `senior-marketing-analyst.PRODUCTS.TRANSACTION`
GROUP BY RECEIPT_ID,PURCHASE_DATE,SCAN_DATE,STORE_NAME,USER_ID, BARCODE, FINAL_QUANTITY, FINAL_SALE
HAVING COUNT(*) > 1;