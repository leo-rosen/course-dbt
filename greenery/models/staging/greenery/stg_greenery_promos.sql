{{
  config(
    materialized='table'
  )
}}


SELECT 
    promo_id,
    discount as price_discount,
    status as promo_status
FROM  {{ source('src_greenery', 'promos') }}