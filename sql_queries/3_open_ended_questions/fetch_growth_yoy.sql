
--  Query to Calculate Fetch's Year-over-Year (YoY) User Growth
-------------------------------------------------------------------------------------
-- This query calculates how Fetch's user base has grown year over year.
-- It first counts users created each year, then calculates the percentage growth 
-- compared to the previous year.
-------------------------------------------------------------------------------------

-- STEP 1: Count number of users created in each year


WITH yearly_user_counts AS (
SELECT 
EXTRACT(YEAR FROM CREATED_DATE) AS year,
COUNT(ID) AS user_count
FROM `senior-marketing-analyst.PRODUCTS.USER`
GROUP BY year
),

-- STEP 2: Calculate Year-over-Year (YoY) Growth

yoy_growth AS (
SELECT 
year,
user_count,
LAG(user_count) OVER (ORDER BY year) AS previous_year_count,
ROUND(
((user_count - LAG(user_count) OVER (ORDER BY year)) / 
NULLIF(LAG(user_count) OVER (ORDER BY year), 0)), 2
) AS yoy_growth_percent
FROM yearly_user_counts
)

-- STEP 3: Retrieve year-wise user growth


SELECT * FROM yoy_growth ORDER BY year;
