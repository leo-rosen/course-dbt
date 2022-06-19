{{
  config(
    materialized='table'
  )
}}


SELECT
  product_id,
  sum(quantity) as quantity_sold
FROM {{ ref('stg_greenery_order_items') }}
GROUP BY product_id