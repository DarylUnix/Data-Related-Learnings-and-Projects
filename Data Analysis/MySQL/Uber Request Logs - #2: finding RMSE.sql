## Naive Forecasting by Stratascratch
## Reference: https://platform.stratascratch.com/coding/10313-naive-forecasting?code_type=3 

## Question:
## Some forecasting methods are extremely simple and surprisingly effective. 
## Naïve forecast is one of them; we simply set all forecasts to be the value of the last observation. 
## Our goal is to develop a naïve forecast for a new metric called "distance per dollar" defined as the (distance_to_travel/monetary_cost) in our dataset and measure its accuracy.
## To develop this forecast,  sum "distance to travel"  and "monetary cost" values at a monthly level before calculating "distance per dollar". 
## This value becomes your actual value for the current month. The next step is to populate the forecasted value for each month. 
## This can be achieved simply by getting the previous month's value in a separate column. Now, we have actual and forecasted values. This is your naïve forecast. 
## Let’s evaluate our model by calculating an error matrix called root mean squared error (RMSE). 
## RMSE is defined as sqrt(mean(square(actual - forecast)). Report out the RMSE rounded to the 2nd decimal spot.

-- I tried solving it with my own solution using the knowledge from what I studied at the university and learned online
-- It may not be the quickest solution because I only apply what I know, but I believe that I made the right solution and got the correct answer

## My Solution:

-- STEP 1: Sum "distance to travel" and "monetary cost" values at a monthly level 

WITH CTE1 as
(
select substring(request_date, 6, 2) as month_only, sum(distance_to_travel) as monthly_distance_to_travel, sum(monetary_cost) as monthly_monetary_cost
from uber_request_logs
group by month_only
), 

-- STEP 2:  Develop a naïve forecast for a new metric called "distance per dollar" defined as the (distance_to_travel/monetary_cost)

CTE2 as
(
select month_only, monthly_distance_to_travel / monthly_monetary_cost as distance_per_dollar
from CTE1
), 

-- STEP 3: To get the Naive forcast, assign each for the following:
-- 			Actual value = current distance per dollar
-- 			Forecasted value = month-before distance per dollar
-- STEP 4: Evaluate our model by calculating an error matrix called root mean squared error (RMSE)
-- 			RMSE is defined as sqrt(mean(square(actual - forecast)), rounded to the 2nd decimal spot.

CTE3 as
(
select CTE2_orig.month_only, CTE2_orig.distance_per_dollar as actual_value, CTE2_dup.distance_per_dollar as forecast_value
from CTE2 as CTE2_orig
left join CTE2 as CTE2_dup
    ON CTE2_orig.month_only - 1 = CTE2_dup.month_only
)
select round(sqrt(avg(power(actual_value - forecast_value,2))),2) as RMSE
from CTE3
;

## Improvements upon research after solving:
## to use Month() to get the month instead of substring
## to use Lag(column,1) and Over(month) as a shortcut for the self-join-to-use-value-from-month-before part
