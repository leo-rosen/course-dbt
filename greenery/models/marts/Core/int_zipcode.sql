{{
  config(
    materialized='table'
  )
}}


SELECT
  address_id,
  CASE
    WHEN char_length(zip_code::text) = 3 THEN concat('00',zip_code::text)
    WHEN char_length(zip_code::text) = 4 THEN concat('0',zip_code::text)
    ELSE zip_code::text
    END as zip_code
FROM {{ ref('stg_greenery_addresses') }}
