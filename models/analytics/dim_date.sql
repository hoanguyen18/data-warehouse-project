-- function to generate a date collection from 2010 to 2020 (10 years)
with dim_generate_date as (
  SELECT
    *
  FROM
    UNNEST(GENERATE_DATE_ARRAY('2010-01-01', '2020-01-01', INTERVAL 1 DAY)) AS date
)
-- function to extract date as format we need
select 
*,
FORMAT_DATE('%A', date ) AS day_of_week,
FORMAT_DATE('%a', date ) AS day_of_week_short,
CASE WHEN FORMAT_DATE('%a', date) IN ('Sun', 'Sat') THEN 'Weekend' 
WHEN FORMAT_DATE('%a', date) IN ('Mon', 'Tue', 'Wed', 'Thu', 'Fri') THEN 'Weekday' 
ELSE 'Invalid' END AS is_weekday_or_weekend,
DATE_TRUNC(date, MONTH) as year_month, --dua ve dau thang dung date trunc, date trunc giu ca date cho minh, se tien cho BI tools
FORMAT_DATE('%B', date) AS month,
DATE_TRUNC(date, year) as year,
EXTRACT(YEAR FROM date) AS year_number
from dim_generate_date



