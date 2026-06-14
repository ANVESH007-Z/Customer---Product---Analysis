SELECT customerid,
       MIN(invoicedate) AS first_purchase_date,
       MAKE_DATE(
           EXTRACT(YEAR FROM MIN(invoicedate))::int,
           EXTRACT(MONTH FROM MIN(invoicedate))::int,
           1
       ) AS cohort_date
FROM "Clean Data".online_retail_main
GROUP BY customerid
order by cohort_date;
