{{
  config(
    materialized='table'
  )
}}


SELECT
  user_id,
  max(created_at) as most_recent_order,
  min(created_at) as first_order
FROM {{ ref('stg_greenery_events') }}
WHERE event_type = 'checkout'
GROUP BY 1