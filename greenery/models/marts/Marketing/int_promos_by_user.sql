{{
  config(
    materialized='table'
  )
}}

SELECT
  O.user_id,
  sum(P.price_discount) as savings_from_promos
FROM {{ ref('stg_greenery_orders') }} AS O
LEFT JOIN {{ ref('stg_greenery_promos') }} AS P
    ON O.promo_id = P.promo_id
GROUP BY 1