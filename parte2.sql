-- Parte 2 — Cuestionario de SQL
-- Víctor Ortiz
-- SQLite

/******************************************************************
  1) GMV mensual
******************************************************************/
SELECT
    strftime('%Y-%m', o.order_purchase_timestamp) AS year_month,
    SUM(op.payment_value) AS gmv
FROM orders AS o
JOIN order_payments AS op USING (order_id)
GROUP BY year_month
ORDER BY year_month;


/******************************************************************
  2) % de pedidos cancelados por mes
******************************************************************/
SELECT
    strftime('%Y-%m', order_purchase_timestamp) AS year_month,
    100.0 * SUM(CASE WHEN order_status = 'canceled' THEN 1 ELSE 0 END)
          / COUNT(*) AS pct_canceled
FROM orders
GROUP BY year_month
ORDER BY year_month;


/******************************************************************
  3) Tiempo promedio (en días) entre compra y entrega por mes.
******************************************************************/
SELECT
    strftime('%Y-%m', order_purchase_timestamp) AS year_month,
    AVG(
        julianday(order_delivered_customer_date)
        - julianday(order_purchase_timestamp)
    ) AS avg_days_to_deliver
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY year_month
ORDER BY year_month;


/******************************************************************
  4) Top 10 categorías por GMV.
******************************************************************/
SELECT
    p.product_category_name,
    SUM(op.payment_value) AS gmv
FROM orders AS o
JOIN order_items AS oi ON o.order_id = oi.order_id
JOIN products AS p ON oi.product_id = p.product_id
JOIN order_payments AS op ON o.order_id = op.order_id
GROUP BY p.product_category_name
ORDER BY gmv DESC
LIMIT 10;


/******************************************************************
  5) Clientes 'recurrentes'.
******************************************************************/
SELECT
    customer_id,
    COUNT(*) AS num_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY num_orders DESC
LIMIT 15;


/******************************************************************
  6) Vendedores con ticket promedio más alto
     ticket promedio.
******************************************************************/
SELECT
    seller_id,
    SUM(price) AS total_revenue,
    COUNT(DISTINCT order_id) AS num_orders,
    1.0 * SUM(price) / COUNT(DISTINCT order_id) AS avg_ticket
FROM order_items
GROUP BY seller_id
HAVING COUNT(*) >= 50
ORDER BY avg_ticket DESC;
LIMIT 20;


/******************************************************************
  7) Ranking de ciudades por GMV y top 3 por estado
     (ventana PARTITION BY customer_state).
******************************************************************/
WITH city_gmv AS (
    SELECT
        c.customer_state,
        c.customer_city,
        SUM(op.payment_value) AS gmv
    FROM orders AS o
    JOIN customers AS c USING (customer_id)
    JOIN order_payments AS op USING (order_id)
    GROUP BY c.customer_state, c.customer_city
),
ranked AS (
    SELECT
        customer_state,
        customer_city,
        gmv,
        RANK() OVER (
            PARTITION BY customer_state
            ORDER BY gmv DESC
        ) AS gmv_rank_state
    FROM city_gmv
)
SELECT
    customer_state,
    customer_city,
    gmv,
    gmv_rank_state
FROM ranked
WHERE gmv_rank_state <= 3
ORDER BY customer_state, gmv_rank_state, gmv DESC;
