/*
=======================================================================================================
Customer report :
=======================================================================================================
Purpose :
       - This Report consolidates key customers metrics and behaviours.

Highlights -
       1. Gathers essential fields such as names, ages and transactions details.
	   2. segments customers into categories (VIP, Regular ,New) and age groups.
	   3. Aggregates customer-level metrics :
	     - total orders
		 - total sales 
		 - total quantity purchased
		 - total products
		 - lifespan (in months)
	   4. Calculates valuable KPIs :
	     - recency (months since last order)
		 - average order value
		 - average monthly spend
========================================================================================================*/

/*----------------------------------------------------------------------------------------------
1) Base Query : Retrieves core columns from tables.
----------------------------------------------------------------------------------------------*/
CREATE VIEW report_customers AS(
WITH base_query AS
(
SELECT 
    s.order_number,
    s.product_key,
    s.order_date,
    s.sales_amount,
    s.quantity,
    c.customer_key,
	c.customer_number,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) AS age
FROM sales s
LEFT JOIN customers c
ON s.customer_key = c.customer_key
WHERE s.order_date IS NOT NULL),
/*--------------------------------------------------------------------------------------------------
2) Customer Aggregations : Summarizes key metrics at the customer level.
---------------------------------------------------------------------------------------------------*/
Customer_aggregation AS
(
SELECT 
customer_key,
customer_number,
customer_name,
age,
COUNT(DISTINCT order_number) total_orders,
SUM(sales_amount) as Total_sales,
SUM(quantity) AS total_quantity,
COUNT(DISTINCT product_key) AS Total_products,
MAX(order_date) as Last_order_date,
    (
        EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) * 12
        +
        EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date)))
    ) AS life_span
FROM base_query
GROUP BY customer_key,
         customer_key,
         customer_number,
         customer_name,
         age
)
SELECT 
 customer_key,
 customer_number,
 customer_name,
 age,
 CASE WHEN age < 20 THEN 'Under 20'
      WHEN age BETWEEN 20 and 29 THEN '20-29'
	  WHEN age BETWEEN 30 and 39 THEN '30-39'
	  WHEN age BETWEEN 40 and 49 THEN '40-49'
ELSE  '50 and Above'
      END age_group,
 CASE WHEN life_span >= 12 AND total_sales > 5000 THEN 'VIP'
      WHEN life_span >= 12 AND total_sales <= 5000 THEN 'Regular'
	  ELSE 'New'
	  END as customer_segment,
 last_order_date,

    (
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, last_order_date)) * 12
        +
        EXTRACT(MONTH FROM AGE(CURRENT_DATE, last_order_date))
    ) AS recency_months,
 total_orders,
 total_sales,
 total_quantity,
 total_products,
 life_span,
 /*----------------------------------------------------------------------
  Compute average order value (AOV)
 ----------------------------------------------------------------------*/
 CASE WHEN total_sales = 0 THEN 0
      ELSE ROUND((total_sales / total_orders),2)
	  END AS avg_order_value,
/*------------------------------------------------------------------   
Compute Average monthly spends
 ------------------------------------------------------------------*/  
  CASE WHEN life_span = 0 THEN total_sales
       ELSE ROUND((Total_sales/life_span),2)
	   END AS avg_monthly_spend
FROM customer_aggregation
)

  