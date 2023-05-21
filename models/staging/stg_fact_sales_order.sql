with fact_sales_order__source as (
SELECT *
FROM `vit-lam-data.wide_world_importers.sales__orders`),

fact_sales_order__rename_column as (
  select
  order_id as sales_order_key,
  customer_id as customer_key,
  picked_by_person_id as picked_by_person_key,
  order_date
from fact_sales_order__source
),

fact_sales_order__cast_type as(
  select
  cast(sales_order_key as integer) as sales_order_key,
  cast(customer_key as integer) as customer_key,
  cast(picked_by_person_key as integer) as picked_by_person_key,
  cast(order_date as date) as order_date
  from fact_sales_order__rename_column
)

select 
sales_order_key,
customer_key, 
coalesce(picked_by_person_key,0) as picked_by_person_key,
order_date
from fact_sales_order__cast_type