SELECT 
    zip_code
FROM {{ ref('int_zipcode') }}
WHERE LENGTH(zip_code) != 5