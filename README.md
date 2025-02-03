# Fetch Data Analysis  

## **Overview**  

This project includes **SQL queries, data visualizations, and analytical insights** aimed at analyzing Fetch's **transaction, product, and user data**. The analysis focuses on:  

- **Data Quality Assessment** – Identifying missing values, duplicates, and ambiguous fields.  
- **Business Insights** – Extracting key metrics related to brand performance, user behavior, and category-based sales.  
- **Data Visualization** – Presenting findings through Google Sheets and Google Slides for better interpretation.  

---

## **SQL Queries & Folder Structure**  

### **Data Quality Analysis** (1_data_quality_analysis/)

- **null_values_analysis.sql** → Identifies NULL values and calculates missing data percentages.  
- **find_duplicate_transactions.sql** → Detects duplicate transactions in the dataset.  
- **challenging_fields.sql** → Lists ambiguous fields requiring further clarification.  

### **Business Insights Queries**  

#### **Close-Ended Questions (2_close-ended_questions/)**  
- **top_5_brands_receipts_21_plus.sql** → Identifies the **top 5 brands based on receipts scanned** by users aged 21+.  
- **top_5_brands_sales_six_months.sql** → Determines the **best-selling brands** among users who have been active for at least **six months**.  
- **health_wellness_sales_by_generation.sql** → Computes the **percentage of Health & Wellness category sales by generation**.  

#### **Open-Ended Questions (3_open_ended_questions/)**  
- **leading_brand_dips_salsa.sql** → Identifies the **best-selling brand** in the **Dips & Salsa category**.  
- **fetch_power_users.sql** → Analyzes Fetch’s **power users** based on **Lifetime Value (LTV)**.  
- **fetch_growth_yoy.sql** → Calculates Fetch’s **year-over-year user growth**.  

---

## **Visualizations**  

### **How Insights Are Visualized**  
Results from SQL queries are visualized using **Google Sheets and Google Slides**. Saved **visualization screenshots** are available in the **`visualizations/`** folder.  

### **How to Access Visualizations**
1. Open the **visualizations/** folder.  
2. View screenshots (`.png`files) for key insights.  
3. If needed, regenerate charts in **Google Sheets**.  

---

## **Stakeholder Communication**  
For a detailed summary of findings, outstanding questions, and actionable insights, please refer to the **[stakeholder_communication.md](documentation/stakeholder_communication.md)** file.  

---

## **Tools & Technologies Used**  
- **Google BigQuery** → SQL-based Data Analysis  
- **Google Sheets / Google Slides** → Data Visualization  
- **GitHub** → Version Control & Collaboration  
- **Markdown (.md)** → Documentation  














