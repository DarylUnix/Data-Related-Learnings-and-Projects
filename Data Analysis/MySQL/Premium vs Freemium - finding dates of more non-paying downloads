## Premium vs Freemium
## Reference: https://platform.stratascratch.com/coding/10300-premium-vs-freemium?code_type=3

## Find the total number of downloads for paying and non-paying users by date
## Include only records where non-paying customers have more downloads than paying customers.
## The output should be sorted by earliest date first and contain 3 columns: date, non-paying downloads, paying downloads.

-- Step 1: I denormalized the tables to see the big picture

WITH CTE1 as
(
select paying_customer, date, downloads
from ms_user_dimension as user
join ms_acc_dimension as acc
    on user.acc_id = acc.acc_id
join ms_download_facts as download
    on user.user_id = download.user_id
order by date
), 

-- Step 2: Grouped them by their categories which are date and customer type, and then attached their downloads for each

CTE2 as
(
select distinct date as distinct_date, paying_customer, SUM(downloads) OVER(partition by date, paying_customer) as total_downloads
from CTE1
),

-- Step 3: In order to compare one another, I seperated the data of non-paying customers and paying customers by splitting it into 2 tables

CTE3 as
(
select distinct_date, paying_customer, total_downloads as non_paying_downloads 
from CTE2
where paying_customer = "no"
),
CTE4 as
(select distinct_date, paying_customer, total_downloads as paying_downloads 
from CTE2
where paying_customer = "yes"
),

-- Step 4: To get the result, I combined the 2 tables using the date, and then got only the needed columns and then applied the condition

CTE5 as
(select no.distinct_date as date, non_paying_downloads, paying_downloads
from CTE3 as no
join CTE4 as yes
    on no.distinct_date = yes.distinct_date)
select * from CTE5
where non_paying_downloads > paying_downloads;

-- Improvements:
-- usage of SUM(Case when paying_customer = "yes" THEN total_downloads END) + 'group by date' in order to aggregating data instead of splitting it into 2 tables
