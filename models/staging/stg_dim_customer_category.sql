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
)

select customer_category_key,
customer_category_name
from dim_customer_category__cast_type

