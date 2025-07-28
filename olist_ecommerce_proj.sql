-- Are there regional preferences for specific product categories we can leverage in localized marketing? 

WITH state_category_orders AS (
  SELECT 
    c.customer_state,
    pt.product_category_name_english,
    COUNT(DISTINCT o.order_id) AS order_count,
    COUNT(DISTINCT c.customer_unique_id) AS customer_count,
    ROUND(COUNT(DISTINCT o.order_id) * 100.0 / 
        NULLIF(SUM(COUNT(DISTINCT o.order_id)) OVER (PARTITION BY c.customer_state), 0), 1) AS category_share_pct,
    RANK() OVER (PARTITION BY c.customer_state ORDER BY COUNT(DISTINCT o.order_id) DESC) AS category_rank
  FROM [olist_ecommerce_project].[dbo].[olist_orders_dataset] o
  JOIN [olist_ecommerce_project].[dbo].[olist_customers_dataset] c ON o.customer_id = c.customer_id
  JOIN [olist_ecommerce_project].[dbo].[olist_order_items_dataset] oi ON o.order_id = oi.order_id
  JOIN [olist_ecommerce_project].[dbo].[olist_products_dataset] p ON oi.product_id = p.product_id
  JOIN [olist_ecommerce_project].[dbo].[product_category_name_translation] pt ON p.product_category_name = pt.product_category_name
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_state, pt.product_category_name_english
  HAVING COUNT(DISTINCT o.order_id) > 100  -- Filter for significant categories
)

SELECT 
  customer_state,
  product_category_name_english,
  order_count,
  customer_count,
  category_share_pct
FROM state_category_orders
WHERE category_rank <= 6 -- Get top 6 categories per state
ORDER BY customer_state, category_rank;   


-- Analyze order cancellation patterns by payment method
WITH payment_status_stats AS (
  SELECT 
    op.payment_type,
    o.order_status,
    COUNT(DISTINCT o.order_id) AS order_count,
    ROUND(AVG(op.payment_value), 2) AS avg_order_value,
    COUNT(DISTINCT c.customer_unique_id) AS customer_count
  FROM [olist_ecommerce_project].[dbo].[olist_orders_dataset] o
  JOIN [olist_ecommerce_project].[dbo].[olist_order_payments_dataset] op ON o.order_id = op.order_id
  JOIN [olist_ecommerce_project].[dbo].[olist_customers_dataset] c ON o.customer_id = c.customer_id
  WHERE o.order_status IN ('canceled', 'invoiced', 'processing')
  GROUP BY op.payment_type, o.order_status
)

SELECT 
  payment_type,
  order_status,
  order_count,
  ROUND(order_count * 100.0 / SUM(order_count) OVER (PARTITION BY payment_type), 1) AS status_pct,
  avg_order_value,
  customer_count,
  ROUND(customer_count * 100.0 / SUM(customer_count) OVER (PARTITION BY payment_type), 1) AS customer_pct
FROM payment_status_stats
ORDER BY 
  payment_type,
  CASE order_status 
    WHEN 'canceled' THEN 1
    WHEN 'processing' THEN 2
    WHEN 'invoiced' THEN 3
    ELSE 4
  END;  

-- Only definitive failures
SELECT 
  op.payment_type,
  COUNT(DISTINCT o.order_id) AS canceled_orders,
  ROUND(COUNT(DISTINCT o.order_id) * 100.0 / 
    (SELECT COUNT(*) FROM [olist_ecommerce_project].[dbo].[olist_orders_dataset] WHERE order_status = 'canceled'), 1) AS pct_of_all_cancellations
FROM [olist_ecommerce_project].[dbo].[olist_orders_dataset] o
JOIN [olist_ecommerce_project].[dbo].[olist_order_payments_dataset] op ON o.order_id = op.order_id
WHERE o.order_status = 'canceled'
GROUP BY op.payment_type; 


-- Sales trends for the most profitable products
WITH quarterly_aov AS (
  SELECT 
    DATEFROMPARTS(YEAR(o.order_purchase_timestamp), 
                 (MONTH(o.order_purchase_timestamp)-1)/3*3 + 1, 1) AS quarter_start,
    p.product_category_name_english,
    SUM(pay.payment_value) / COUNT(DISTINCT o.order_id) AS aov,
    COUNT(DISTINCT o.order_id) AS order_count
  FROM [olist_ecommerce_project].[dbo].[olist_orders_dataset] o
  JOIN [olist_ecommerce_project].[dbo].[olist_order_items_dataset] oi ON o.order_id = oi.order_id
  JOIN [olist_ecommerce_project].[dbo].[olist_products_dataset] p ON oi.product_id = p.product_id
  JOIN [olist_ecommerce_project].[dbo].[olist_order_payments_dataset] pay ON o.order_id = pay.order_id
  WHERE p.product_category_name_english IN (
  /*Filtering by categories which appeared in the geographic targeting query*/
    'health_beauty', 
    'watches_gifts', 
    'bed_bath_table',
	'sports_leisure',
	'computers_accessories'

  ) 
  GROUP BY 
    DATEFROMPARTS(YEAR(o.order_purchase_timestamp), 
                 (MONTH(o.order_purchase_timestamp)-1)/3*3 + 1, 1),
    p.product_category_name_english
)
SELECT 
  FORMAT(quarter_start, 'yyyy-Q') AS quarter,
  product_category_name_english AS category,
  ROUND(aov, 2) AS avg_order_value,
  order_count,
  ROUND(LAG(aov, 1) OVER (PARTITION BY product_category_name_english ORDER BY quarter_start), 2) AS prev_quarter_aov,
  CASE 
    WHEN LAG(aov, 1) OVER (PARTITION BY product_category_name_english ORDER BY quarter_start) = 0 THEN NULL
    ELSE ROUND((aov - LAG(aov, 1) OVER (PARTITION BY product_category_name_english ORDER BY quarter_start)) / 
         LAG(aov, 1) OVER (PARTITION BY product_category_name_english ORDER BY quarter_start) * 100, 1)
  END AS qoq_growth_pct,
  ROUND(aov * order_count, 2) AS total_category_revenue
FROM quarterly_aov
ORDER BY product_category_name_english, quarter_start; 
