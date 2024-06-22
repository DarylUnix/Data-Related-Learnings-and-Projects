WITH CTE1 as
(
select *
from penetration_analysis
where year(last_active_date) = 2024 AND
month(last_active_date) = 1 AND
sessions >= 5 AND
listening_hours >= 10
),
CTE2 as
(
select country as country_A, count(*) as active_users 
from CTE1
group by country
),
CTE3 as
(
select country as country_B, count(*) as total_users 
from penetration_analysis
group by country
),
CTE4 as
(
select country_A as country, round((active_users/total_users),2) as active_user_pentration_rate
from CTE2
inner join CTE3
 on CTE2.country_A = CTE3.country_B
)
select * from CTE4
;
