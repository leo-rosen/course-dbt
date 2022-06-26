{{
  config(
    materialized='table'
  )
}}

SELECT
  O.user_id,
  U.first_name as user_first_name,
  U.last_name as user_last_name,
  U.email,
  R.first_order,
  R.most_recent_order,
  ROUND(sum(O.order_cost)::numeric,2) as total_product_spending,
  ROUND(sum(O.shipping_cost)::numeric,2) as total_shipping_cost,
  ROUND(sum(O.order_cost)::numeric + sum(O.shipping_cost)::numeric,2) as total_amount_spent,
  count(distinct O.order_id) as total_number_of_orders,
  count(distinct O.promo_id) as number_of_promos_used
FROM {{ ref('stg_greenery_orders') }} AS O
LEFT JOIN {{ ref('dim_users') }} AS U 
  ON O.user_id = U.user_id
LEFT JOIN {{ ref('int_first_and_most_recent_user_order') }} AS R
  ON O.user_id = R.user_id
{{dbt_utils.group_by(n=6) }}