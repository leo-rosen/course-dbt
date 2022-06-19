SELECT *
FROM {{ ref('int_first_and_most_recent_user_order') }}
WHERE most_recent_order < first_order