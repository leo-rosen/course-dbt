{{
  config(
    materialized='table'
  )
}}


SELECT
  session_id,
  1 as session_flag,
  MAX(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) as viewed_page,
  MAX(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) as added_to_cart,
  MAX(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) as checked_out
FROM {{ ref('stg_greenery_events') }}
GROUP BY session_id
