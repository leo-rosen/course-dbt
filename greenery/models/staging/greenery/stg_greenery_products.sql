{{
  config(
    materialized='table'
  )
}}


SELECT 
    product_id,
    name,
    price,
    inventory
FROM  {{ source('src_greenery', 'products') }}