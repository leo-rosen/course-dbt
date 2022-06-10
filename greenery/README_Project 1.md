### 3.1 How many users do we have?

```
SELECT
count(distinct user_id) as number_of_users
FROM dbt_leo_r.stg_greenery_users
```
=> 130

### 3.2 On average, how many orders do we receive per hour?

```
SELECT
count(order_id) / (DATE_PART('day', max(created_at) - min(created_at)) * 24 +
DATE_PART('hour', max(created_at)) - DATE_PART('hour',min(created_at))) as orders_per_hour
FROM dbt_leo_r.stg_greenery_orders
```

=> 7.680851063829787

### 3.3 On average, how long does an order take from being placed to being delivered?

```
SELECT
avg(delivered_at - created_at) as time_to_delivery
FROM dbt_leo_r.stg_greenery_orders
```
=> 3 days 21:24:11.803279


### 3.4.1 How many users have only made one purchase?
```
SELECT 
count(order_id) as number_of_orders
FROM dbt_leo_r.stg_greenery_orders
GROUP BY user_id
HAVING count(order_id) = 1
```

=> 25

### 3.4.2 How many users have only made two purchase?
```
SELECT 
count(order_id) as number_of_orders
FROM dbt_leo_r.stg_greenery_orders
GROUP BY user_id
HAVING count(order_id) = 2
```
=> 28

### 3.4.3 How many users have made 3+ purchases?
```
SELECT 
count(order_id) as number_of_orders
FROM dbt_leo_r.stg_greenery_orders
GROUP BY user_id
HAVING count(order_id) >= 3
```
=> 71

### 3.5 On average, how many unique sessions do we have per hour?

```
SELECT 
count(distinct session_id) /(DATE_PART('day', max(created_at) - min(created_at)) * 24 +
DATE_PART('hour', max(created_at)) - DATE_PART('hour',min(created_at)))
FROM dbt_leo_r.stg_greenery_events
```

=> 17.515151515151516