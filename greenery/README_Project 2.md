### 1.1 What is our user repeat rate?

```
SELECT 
SUM(CASE WHEN repeats > 1 THEN 1 ELSE 0 END)/sum(count_users) as repeat_rate
FROM (SELECT user_id, count(order_id) as repeats, count(distinct user_id) as count_users
FROM dbt_leo_r.stg_greenery_orders
GROUP BY user_id) as temp_table

```
Answer: 79.84%

### 1.2 What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
<br>
One potentially helpful indicator for users likely to purchase again is the number of pages viewed be a user. If a user viewed multiple pages, they might come back and order one of the items they viewed, even if they did not initally order the item. We do have data on this in the dataset. Another good indicator would be the time spent on each page. Another indicator could be the bounce rate of a page.
<br>
<br>
An indicator of someone who is likely to not purchase again would be whether or not a user used a promotion code when purchasing. Users that use promotion codes might have only ordered because of the promotion, and without another promotion they might not return.
<br>
<br>
One feature that I would want to look into this question is how a user found our site. Did they find it through a Google search, or did they enter our site by directly entering the URL? Also, almost any data from Google Analytics would be helpful for further investigating our users.
<br>
<br>


### 1.3 Create a marts folder, so we can organize our models, with the following subfolders for business units
See created subfolders.

### 1.4 Explain the marts models you added. Why did you organize the models in the way you did?
I organized the models to have our core tables (user information, high level order information) in the Core folder. Those are core items that will be used in many instances. I added detailed user order information in the Marketing folder. Marketing information includes promotions, and promotions are used by users, so I figured that someone would want promo information at the user level. Int he product folder, I added information on page views for products. I purposely did not add information at the user level to start with and kept this strictly at the product level.
<br>
<br>

### 2.1.1 Add dbt tests into your dbt project on your existing models from Week 1, and new models from the section above
See tests added in test folder and in the schema_greenery.yml
<br>
<br>

### 2.1.2 What assumptions are you making about each model? (i.e. why are you adding each test?)
I made many assumptions on the data. First, each user ID should be unique, so I added unique tests for the user ID columns. Second, the order cost must be a positive values. It would not make sense for the company to pay the user to buy items. Third, the created_at timestamps should not be null. Fourth, the quantity of items should never be null. For singular tests, I added a test to show that the most recent order should always be greater than or equal to the first order. A user can't go back in time to order something. I also added a test to show that the order cost plus the shipping cost should equal to total cost. Finally, ZIP codes should be 5 digit numbers. In our dataset, the leading zeros were trimmed off of the ZIP codes. I fixed that in a intermediate table and added a test to verify it worked correctly.
<br>
<br>

### 2.2 Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
I would have these tests run each morning, and if the tests fail, I would have an alert sent to to the relevant employees to tell them the data is bad.