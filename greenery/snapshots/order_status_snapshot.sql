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