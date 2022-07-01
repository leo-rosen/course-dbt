### Part 1

New snapshot from orders table.

```
{% snapshot status_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='order_id',
      check_cols=['status'],
      strategy='check',
          )
  }}

  SELECT * FROM {{ source('src_greenery', 'orders') }}

{% endsnapshot %}
```

### Part 2
I created an intermediate model and an event funnel model to answer these questions. The first intermediate model creates binary flags for event types in each session.
```
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
```
The second event funnel model uses this model to calculate the rates.

```
{{
  config(
    materialized='table'
  )
}}


SELECT
  sum(added_to_cart)::FLOAT/sum(viewed_page)::FLOAT as view_to_add,
  sum(checked_out)::FLOAT/sum(added_to_cart)::FLOAT as added_to_cart_to_checkout
FROM {{ ref('int_event_flags') }}
```
I find that 80% of users that view at least one page add at least one item to their cart. Of these 80% of users, 77% actually make a purchase.

### Part 3A

Our organization is most likely going to be starting to use dbt in the next year. I would say that the main value of dbt is that it lets analysts create repeatable code that can be shared throughout the organization. It also allows for greater data validation and quality. The tests that can run daily will greatly improve our data quality and result in fewer errors.






