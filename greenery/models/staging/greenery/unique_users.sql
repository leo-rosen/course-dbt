SELECT
count(distinct user_id) as number_of_users
FROM {{ref('stg_greenery_users')}}