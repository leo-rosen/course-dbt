SELECT *
    FROM {{ ref('fact_user_orders') }}
    WHERE total_amount_spent -  total_product_spending - total_shipping_cost != 0