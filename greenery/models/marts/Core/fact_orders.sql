{{
  config(
    materialized='table'
  )
}}


SELECT
  O.order_id,
  O.user_id,
  O.promo_id,
  CASE
    WHEN O.promo_id is null THEN 'No Promo Used'
    ELSE 'Promo Used'
    END as used_promo,
  O.order_cost,
  CASE
    WHEN P.price_discount is null THEN 0
    ELSE P.price_discount
    END as price_discount,
  ROUND(CASE
    WHEN P.price_discount::numeric is null THEN order_cost::numeric
    ELSE O.order_cost::numeric + P.price_discount::numeric
    END,2) as raw_order_cost,
  O.shipping_cost,
  O.order_total,
  O.shipping_cost/O.order_total as shipping_cost_percent_of_order_total,
  O.delivery_status,
  O.estimated_delivery_at - O.delivered_at as delivery_estimation_error,
  OI.quantity as number_of_items_ordered
FROM {{ ref('stg_greenery_orders') }} AS O
LEFT JOIN {{ ref('stg_greenery_promos') }} AS P 
  ON O.promo_id = P.promo_id
LEFT JOIN {{ ref('stg_greenery_order_items') }} AS OI 
  ON O.order_id = OI.order_id