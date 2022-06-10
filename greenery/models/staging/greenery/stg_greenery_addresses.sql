{{
  config(
    materialized='table'
  )
}}

SELECT 
    address_id,
    address,
    zipcode as zip_code,
    state,
    country
FROM {{ source('src_greenery', 'addresses') }}