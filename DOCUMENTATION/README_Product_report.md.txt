# Product Report SQL Project

## Overview

This project contains a SQL-based Product Performance Report designed to analyze product sales behaviour, customer engagement, and business KPIs.

The report combines sales and product datasets to generate meaningful insights that can help businesses identify:

* High-performing products
* Mid-range products
* Low-performing products
* Revenue trends
* Customer engagement metrics

---

# Project Objectives

The main goal of this project is to build an end-to-end analytical SQL report that:

* Retrieves core product and sales information
* Aggregates product-level performance metrics
* Calculates important KPIs for business analysis
* Segments products based on revenue performance
* Supports data-driven decision making

---

# Key Metrics Included

The report calculates the following metrics:

## Product Metrics

* Product Name
* Category
* Subcategory
* Product Cost

## Sales Metrics

* Total Orders
* Total Sales
* Total Quantity Sold
* Total Customers (Unique)

## KPI Metrics

* Product Lifespan (Months)
* Recency (Months Since Last Sale)
* Average Order Revenue (AOR)
* Average Monthly Revenue

---

# SQL Concepts Used

This project demonstrates practical SQL skills commonly used in Data Analytics roles.

### Concepts Covered

* Common Table Expressions (CTEs)
* Aggregations
* GROUP BY
* JOIN Operations
* Date Functions
* Business KPI Calculations
* Revenue Segmentation
* Data Transformation

---

# Query Structure

The SQL file is divided into multiple logical sections:

## 1. Base Query

Retrieves and joins:

* Sales data
* Product data

This section creates the foundational dataset for analysis.

## 2. Product Aggregation

Calculates:

* Total sales
* Total orders
* Customer counts
* Product lifespan
* Quantity sold

## 3. Final Report

Builds the final business report by:

* Calculating KPIs
* Measuring recency
* Calculating AOR
* Segmenting products by revenue

---

# Business Use Cases

This report can help businesses:

* Identify top-selling products
* Track product lifecycle performance
* Analyze customer purchasing behaviour
* Measure sales efficiency
* Improve inventory planning
* Support strategic decision-making

---

# Tools & Technologies

* SQL
* PostgreSQL (or PostgreSQL-compatible syntax)
* GitHub

---

# File Included

```bash
Product_report.sql
```

---

# Sample Business Insights

Using this report, analysts can answer questions like:

* Which products generate the highest revenue?
* Which products are inactive or declining?
* Which category performs best?
* What is the average monthly revenue per product?
* Which products have the highest customer reach?

---

# Author

Created as part of a Data Analytics portfolio project.

---

# Future Improvements

Possible future enhancements:

* Add profitability analysis
* Add dynamic date filtering
* Create dashboard integration with Power BI
* Introduce ranking and window functions
* Add customer segmentation

---

# How to Use

1. Open the SQL file.
2. Run the query in PostgreSQL or compatible SQL environment.
3. Review the generated product performance report.
4. Use the output for dashboards or business analysis.

---

# Conclusion

This project demonstrates strong foundational SQL and analytical skills by transforming raw sales data into actionable business insights.
