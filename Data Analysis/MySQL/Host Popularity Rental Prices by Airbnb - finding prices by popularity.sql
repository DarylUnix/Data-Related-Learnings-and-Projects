## Host Popularity Rental Prices by AirBNB
## Reference: https://platform.stratascratch.com/coding/9632-host-popularity-rental-prices?code_type=3

##You’re given a table of rental property searches by users. 
## The table consists of search results and outputs host information for searchers. 
## Find the minimum, average, maximum rental prices for each host’s popularity rating. The host’s popularity rating is defined as below:
## 0 reviews: New
## 1 to 5 reviews: Rising
## 6 to 15 reviews: Trending Up
## 16 to 40 reviews: Popular
## more than 40 reviews: Hot
## Tip: The id column in the table refers to the search ID. 
## You'll need to create your own host_id by concating price, room_type, host_since, zipcode, and number_of_reviews.
## Output host popularity rating and their minimum, average and maximum rental prices.

-- My solution
-- Step 1: Get distinct records, display needed columns, add use case for poplarity rating
-- Step 2: Get their min, avg, and maximum by popularity rating

WITH CTE1 as 
(
select distinct price, room_type, host_since, zipcode, number_of_reviews,
CASE
    WHEN number_of_reviews = 0 THEN "New"
    WHEN number_of_reviews BETWEEN 1 AND 5 THEN "Rising"
    WHEN number_of_reviews BETWEEN 6 AND 15 THEN "Trending Up"
    WHEN number_of_reviews BETWEEN 16 AND 40 THEN "Popular"
    WHEN number_of_reviews > 40 THEN "Hot"
END as popularity_rating
from airbnb_host_searches
)
select popularity_rating, min(price) as minimum_price, avg(price) as average_price, max(price) as maximum_price
from CTE1
group by popularity_rating
order by number_of_reviews ASC
;
