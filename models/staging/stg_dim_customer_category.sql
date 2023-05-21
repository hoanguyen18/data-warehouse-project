with dim_customer_category__source as (
SELECT *
FROM `vit-lam-data.wide_world_importers.sales__customer_categories`),

dim_customer_category__rename_column as
(
  select customer_category_id as customer_category_key,
  customer_category_name
  from dim_customer_category__source
),

dim_customer_category__cast_type as
(
  select cast(customer_category_key as integer) as customer_category_key,
  cast(customer_category_name as string) as customer_category_name,
  from dim_customer_category__rename_column
),

dim_customer_category__add_undefined_record as(
  select
  customer_category_key, customer_category_name
  from dim_customer_category__cast_type

  union ALL
  select 
  0 as customer_category_key, 
  'Undefined' as customer_category_name

  union all
  select 
  -1 as customer_category_key, 
  'Invalid' as customer_category_name
) 

select customer_category_key,
customer_category_name
from dim_customer_category__cast_type

