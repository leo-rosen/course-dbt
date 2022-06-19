{{
  config(
    materialized='table'
  )
}}

SELECT
  U.user_id,
  U.first_name,
  U.last_name,
  U.email,
  U.phone_number,
  U.address_id,
  A.address,
  A.state,
  A.country,
  Z.zip_code
FROM {{ ref('stg_greenery_users') }} as U
LEFT JOIN {{ ref('stg_greenery_addresses') }} as A 
  ON U.address_id = A.address_id
LEFT JOIN {{ ref('int_zipcode') }} as Z 
  ON U.address_id = Z.address_id

