-- Best Selling Item by Amazon, Ebay, Best Buy
-- Reference: https://platform.stratascratch.com/coding/10172-best-selling-item?code_type=3

-- Find the best selling item for each month (no need to separate months by year) where the biggest total invoice was paid.
-- The best selling item is calculated using the formula (unitprice * quantity). 
-- Output the month, the description of the item along with the amount paid.

## My solution

-- Step 1: Group it by month, and then description
-- Step 2: Get their total invoice
-- Step 3: Get their dense rank through total invoice by month, this will make getting top in each month more easier
-- Step 4: Display all needed columns by month, with the condition of just showing the top of the ranks

with CTE1 as
(select month(invoicedate) as month_only, description, SUM(quantity * unitprice) as total_invoice, dense_rank() OVER(partition by month(invoicedate) order by SUM(quantity * unitprice) desc)as month_rank
from online_retail
group by month_only, description
)
select month_only, description, total_invoice
from CTE1
where month_rank = 1
group by month_only
order by month_only
;
