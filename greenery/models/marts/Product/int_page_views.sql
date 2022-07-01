{{
  config(
    materialized='table'
  )
}}


SELECT
  product_id,
 {{ sumifequal('event_type','page_view',1,0) }} as number_of_page_views,
  count(distinct session_id) as number_of_sessions,
   {{ sumifequal('event_type','add_to_cart',1,0) }} as number_of_add_to_carts
   FROM {{ ref('stg_greenery_events') }}
WHERE product_id IS NOT NULL
GROUP BY 1