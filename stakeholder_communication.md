# **Stakeholder Communication: Fetch Data Analysis Findings**  

## **Subject:** Data Quality Insights and Business Findings  

**Hi Team,**  

I have completed an initial analysis of Fetch’s **transaction, product, and user data**. Below is a summary of **key findings** related to data quality, business insights, and outstanding questions that require further discussion.  

---

## **Key Data Quality Issues**  

### **1. Data Type Inconsistencies**  
- The `FINAL_QUANTITY` and `FINAL_SALE` columns in the transaction data are stored as **strings** instead of **numeric values**, which are necessary for accurate calculations.  
- While I converted them in each query where required, I recommend **permanently updating these fields to numeric formats** to improve future analysis efficiency and accuracy.  

### **2. Missing Data Impact**  
- A **null value analysis** was conducted, and the results are available in the **visualization files**, highlighting **null quantity and percentage of missing values per column**.  
- High null rates in critical fields affect the accuracy of business insights. **Your guidance on handling missing values would be beneficial.**  

### **3. Duplicate Transactions**  
- **Multiple duplicate transactions** were identified, potentially skewing sales and user engagement metrics.  
- The **`duplicate_transactions` visualization file** presents a pivot table breakdown, showing, for example, that **133 transactions had two duplicates, and 12 transactions had three duplicates**.  
- The **`find_duplicate_transactions.sql` file** provides SQL query results identifying duplicate records based on key transaction fields.  
- **All insights were generated without including duplicates** to ensure data accuracy. I recommend **removing duplicates from the transaction file**.  

### **4. Inconsistent Column Naming**  
- Some column names in the **CSV files** do not match the **Entity Relationship Model**.  
- For example, **sales and quantity-related fields are labeled as `total_sales` and `total_quantity`** in the CSV but are not consistently named in the schema.  
- **Please confirm the correct naming conventions to ensure accurate data alignment.**  

---

## **Business Insights & Trends**  

### **Closed-Ended Questions**  
- **Top 5 Brands by Receipts Scanned (Users 21+)** → **Dove, Nerds Candy, Coca-Cola, Great Value, Hershey's**  
- **Top 5 Brands by Sales (Users Active for 6+ Months)** → **CVS, Dove, TRESemmé, Trident, Coors Light**  
- **Health & Wellness Sales by Generation** → **More than half of sales come from Boomers, approximately one-third from Gen X, with Millennials making up the rest.**  

### **Open-Ended Questions**  
- **Who Are Fetch’s Power Users?**  
  - Identified based on **high LTV (Lifetime Value)**, which factors in **purchase frequency, average spend, and user lifespan**.  
  - Additional metrics such as **total revenue, repeat purchase behavior, or average order value** could also be considered.  
  - **Let me know if further analysis is needed based on different criteria.**  

- **Which Is the Leading Brand in the Dips & Salsa Category?**  
  - **TOSTITOS** has the highest sales in this category, based on total revenue calculated from **quantity sold (`FINAL_QUANTITY`) × sale price (`FINAL_SALE`)**.  
  - **This highlights TOSTITOS' strong market presence and consumer preference in this category.**  

- **Fetch’s Year-Over-Year Growth**  
  - Growth was analyzed based on **user count** to assess Fetch’s ability to **expand its customer base**.  
  - This aligns with evaluating **platform adoption trends**.  
  - However, if needed, I can also provide an analysis based on **revenue growth** to assess **financial performance**.  
  - **Please let me know if this is required.**  

---

## **New Insight: Generational Sales Discrepancy**  

Although **Gen X** represents **more than half of Fetch’s overall user base**, the **majority of Health & Wellness sales come from Boomers**.  
This suggests that despite their larger presence, **Gen X users are less engaged in this category**, while Boomers exhibit a higher tendency to purchase Health & Wellness products.  

Understanding these behavioral differences could help develop **targeted marketing strategies** to **increase Gen X engagement in this category**. 

---
During the **Year-Over-Year Growth analysis**, I identified an unusual trend:  
- In **2023**, user growth declined by **42%** compared to the previous year.  
- In **2024**, the decline continued at **25%**.  

This significant drop is unexpected and may indicate underlying issues such as **user retention challenges, market shifts, or external factors affecting adoption**. I would like to discuss this further to understand potential causes and explore possible areas for deeper investigation.  




---

## **Outstanding Questions & Requests for Action**  

- **Final_Quantity & Final_Sale Data Type Update:** Can we permanently change these fields from **string to numeric**?  
- **Handling Null Values:** Certain fields have **high null rates**, impacting data accuracy. **How should we address missing values?**  
- **Duplicate Transactions:** I recommend **removing duplicates from the transaction file**. **Would you like to proceed with this update?**  
- **Column Name Standardization:** Can we align column names with the **Entity Relationship Model** for consistency?  
- **Further Open-Ended Analysis:** Should I explore additional metrics for **power users, brand performance, or user growth**?  

Would love to discuss these insights further. **Let me know a good time to connect.**  

**Best,**  
**Azar Gasim**  
*Senior Data Analyst*  
