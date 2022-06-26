{{
  config(
    materialized='table'
  )
}}

SELECT
  Products.product_id,
  Products.name,
  Products.price,
  Products.inventory,
  Products.quantity_sold,
  PageViews.number_of_page_views,
  PageViews.number_of_add_to_carts
FROM {{ ref('dim_products') }} AS Products
LEFT JOIN {{ ref('int_page_views') }} AS PageViews
    ON Products.product_id = PageViews.product_id