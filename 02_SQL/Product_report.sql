/*
==============
PRODUCT REPORT -
==============
Purpose 
- This report consolidates key product metrics and behaviours.

Highlights -
  1.Gather essential fields such as product name,category,subcategory and cost.
  2.Segment products by revenue to identify High-performance,Mid-range or Low- performance.
  3.Aggregates product-level netrics :
     - total orders
	 - total sales
	 - total quantity sold
	 - total customers
	    (unique)
     - lifespan (in months)
  4.Calculate valuable KPIs :
   - recency (months since last sale)
   - average order revenue (AOR)
   - average monthly revenue
=================================================================================================================*/
/*
=====================================================================================================
Base Query : REtrieves core columns from sales and products.
=====================================================================================================*/
CREATE VIEW product_report AS(
WITH base_query AS
(
SELECT 
    s.order_number,
    p.product_key,
    p.product_id,
    p.product_name,
    s.customer_key,
    s.order_date,
    s.sales_amount,
    s.quantity,
    p.category,
    p.subcategory,
    p.cost

FROM sales s

LEFT JOIN products p
ON s.product_key = p.product_key
WHERE order_date IS NOT NULL
),

product_aggregation AS
/*------------------------------------------------------------------------------------------
 2) Product Aggregation - Summarizes key metrics at the product level 
-----------------------------------------------------------------------------------------*/
(
SELECT
    product_name,
    category,
    subcategory,

    MAX(order_date) AS last_order_date,

    (
        EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) * 12
        +
        EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date)))
    ) AS product_life_span_months,

    COUNT(DISTINCT order_number) AS total_orders,

    SUM(sales_amount) AS total_sales,

    SUM(quantity) AS total_quantity_sold,

    COUNT(DISTINCT customer_key) AS total_customers

FROM base_query

GROUP BY
    product_name,
    category,
    subcategory
),
/*---------------------------------------------------------------------------------------------------
FINAL REPORT - Average values and Segmentation.
----------------------------------------------------------------------------------------------------*/

final_report AS
(
SELECT 

    product_name,
    category,
    subcategory,

    total_customers,
    total_orders,
    total_quantity_sold,
    total_sales,

    (
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, last_order_date)) * 12
        +
        EXTRACT(MONTH FROM AGE(CURRENT_DATE, last_order_date))
    ) AS recency,

    product_life_span_months,

    ROUND((total_sales / total_orders), 2)
    AS avg_order_revenue,

    CASE 
        WHEN product_life_span_months = 0 THEN total_sales
        ELSE ROUND((total_sales / product_life_span_months), 2)
    END AS avg_monthly_revenue,

    NTILE(3) OVER(ORDER BY total_sales DESC)
    AS sales_rank

FROM product_aggregation
)

SELECT *,

CASE
    WHEN sales_rank = 1 THEN 'High Performance'
    WHEN sales_rank = 2 THEN 'Mid Range'
    ELSE 'Low Performance'
END AS performance_segment

FROM final_report
)
