# 📊 Walmart Sales Data Analysis (SQL & Power BI)
**Project Overview**

This project focuses on analyzing Walmart Sales Data to uncover insights into sales performance, customer behavior, and the impact of holidays on revenue. The analysis is performed using SQL for data extraction and transformation and Power BI for creating interactive visualizations. The goal is to derive meaningful trends that can help businesses make data-driven decisions.

## Dataset
- **File**: `WalmartSalesData.csv`
- **Source**: Walmart Sales Data
- **Size**: Large dataset with multiple sales records
- **Format**: CSV / SQL Database
- **Key Fields**:
  - `Date` (Transaction Date)
  - `Store` (Store ID)
  - `Department` (Product Category)
  - `Weekly_Sales` (Revenue per store per week)
  - `Holiday_Flag` (Indicates whether the week includes a holiday)

## Tools & Technologies
- **SQL**: MySQL for data extraction, transformation, and cleaning
- **Power BI**: Dashboard creation & visual analytics
- **Database**: MySQL

## SQL Queries Used
### 1️⃣ Data Cleaning & Preprocessing
```sql
SELECT * FROM walmart_sales 
WHERE weekly_sales IS NOT NULL;
```
### 2️⃣ Sales Performance Analysis
```sql
SELECT store, SUM(weekly_sales) AS total_sales
FROM walmart_sales
GROUP BY store;
```
### 3️⃣ Holiday Sales Impact
```sql
SELECT holiday_flag, AVG(weekly_sales) AS avg_sales
FROM walmart_sales
GROUP BY holiday_flag;
```

## Power BI Dashboard
- **KPIs Included**:
  - Total Weekly Sales
  - Top Performing Stores
  - Holiday vs Non-Holiday Sales
  - Department-Wise Sales Analysis
- **Visualizations Used**:
  - Line Chart (Sales Trends Over Time)
  - Bar Chart (Top Performing Stores)
  - Pie Chart (Sales Distribution by Department)
  - Map (Geographical Store Sales Analysis)

## Insights & Findings
- **Sales tend to peak during holiday weeks**.
- **Certain stores significantly outperform others in terms of revenue**.
- **Departments like Electronics and Groceries contribute the most to overall sales**.

