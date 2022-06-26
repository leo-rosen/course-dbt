### 1.1 What is our overall conversion rate?

```
SELECT 
sum(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END)::FLOAT/count(distinct session_id)::FLOAT as conversion_rate

FROM dbt_leo_r.stg_greenery_events
```

Answer: 62.46%

### 1.2 What is our conversion rate by product?
```
with product_sessions AS (
SELECT
  count(distinct session_id) as product_sessions,
  product_id

FROM dbt_leo_r.stg_greenery_events
WHERE product_id IS NOT NULL
GROUP BY product_id
)

SELECT 
  sum(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END)::FLOAT/
    avg(p.product_sessions::FLOAT)*100 as conversion_rate,
  p.product_id,
  pname.name
FROM dbt_leo_r.stg_greenery_events AS e
LEFT JOIN dbt_leo_r.stg_greenery_order_items AS oi
ON e.order_id = oi.order_id
LEFT JOIN product_sessions AS p
ON oi.product_id = p.product_id
LEFT JOIN dbt_leo_r.stg_greenery_products as pname
ON oi.product_id = pname.product_id
WHERE p.product_id IS NOT NULL
GROUP BY p.product_id,pname.name
```

|product name|conversion rate|
|---|---|
|Bird of Paradise|45|
|Money Tree|46.42857142857143|
|Alocasia Polly|41.17647058823529|
|Dragon Tree|46.774193548387096|
|Bamboo|53.73134328358209|
|Angel Wings Begonia|39.34426229508197|
|Cactus|54.54545454545454|
|Fiddle Leaf Fig|50|
|Pink Anthurium|41.891891891891895|
|Orchid|45.33333333333333|
|Monstera|51.02040816326531|
|Birds Nest Fern|42.30769230769231|
|Aloe Vera|49.23076923076923|
|Majesty Palm|49.25373134328358|
|Devil's Ivy|48.888888888888886|
|Pilea Peperomioides|47.45762711864407|
|String of pearls|60.9375|
|Boston Fern|41.269841269841265|
|Peace Lily|40.909090909090914|
|Calathea Makoyana|50.943396226415096|
|Ficus|42.64705882352941|
|Snake Plant|39.726027397260275|
|Pothos|34.42622950819672|
|ZZ Plant|53.96825396825397|
|Jade Plant|47.82608695652174|
|Philodendron|48.38709677419355|
|Ponytail Palm|40|
|Spider Plant|47.45762711864407|
|Rubber Plant|51.85185185185185|
|Arrow Head|55.55555555555556|

One theory for why some products have a higher conversion rate is related to the time of year the products are being sold. All of the orders in our data set are in February. We might have a higher conversion rate on some products in the Summer instead of the Winter.