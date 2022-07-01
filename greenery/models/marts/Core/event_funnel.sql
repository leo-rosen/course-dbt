{{
  config(
    materialized='table'
  )
}}


SELECT
  sum(added_to_cart)::FLOAT/sum(viewed_page)::FLOAT as view_to_add,
  sum(checked_out)::FLOAT/sum(added_to_cart)::FLOAT as added_to_cart_to_checkout
FROM {{ ref('int_event_flags') }}
