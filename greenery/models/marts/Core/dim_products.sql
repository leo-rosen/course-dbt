{{
  config(
    materialized='table'
  )
}}

SELECT
  P.product_id,
  P.name,
  P.price,
  P.inventory,
  S.quantity_sold
FROM {{ ref('stg_greenery_products') }} AS P
LEFT JOIN {{ ref('int_products_sold') }} AS S 
  ON P.product_id = S.product_id