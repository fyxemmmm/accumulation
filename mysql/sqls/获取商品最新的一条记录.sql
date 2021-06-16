SELECT * FROM prod_sales


select * from (
SELECT prod_class, max(sales_date) max_date from prod_sales GROUP BY prod_class
) a inner join prod_sales b on a.max_date = b.sales_date