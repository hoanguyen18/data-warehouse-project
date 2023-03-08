with dim_customer__source as (
SELECT 
  *
FROM `vit-lam-data.wide_world_importers.sales__customers`),

dim_customer__rename_column as(
select 
customer_id as	customer_key,
customer_name 
from dim_customer__source
),

dim_customer__cast_type as(
  select
  cast(customer_key as integer) as customer_key,
  cast(customer_name as string) as customer_name
  from dim_customer__rename_column
)

select 
customer_key,
customer_name from dim_customer__cast_type
