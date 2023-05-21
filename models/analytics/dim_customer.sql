with dim_customer__source as (
SELECT 
  *
FROM `vit-lam-data.wide_world_importers.sales__customers`),

dim_customer__rename_column as(
select 
customer_id as customer_key,
is_on_credit_hold as is_on_credit_hold_boolean, --li do doi ten la cho cast type boolean chi co 2 loai thoi
customer_name,
customer_category_id as customer_category_key,
buying_group_id as buying_group_key
from dim_customer__source
),

dim_customer__cast_type as(
  select
  cast(customer_key as integer) as customer_key,
  cast(customer_name as string) as customer_name,
  cast(customer_category_key as integer) as customer_category_key,
  cast(buying_group_key as integer) as buying_group_key,
  cast(is_on_credit_hold_boolean as boolean) as is_on_credit_hold_boolean -- sau khi cast type xong thi doi ve credit hold nhu bt
  from dim_customer__rename_column
  
),

dim_customer__convert_boolean as(
  select
  *, case
  when is_on_credit_hold_boolean is true then 'On Credit Hold'
  when is_on_credit_hold_boolean is false then 'Not On Credit Hold' 
  when is_on_credit_hold_boolean is null then 'Undefined' 
  else 'Invalid' end as is_on_credit_hold --day ok chua
  from dim_customer__cast_type
),

dim_customer__add_undefined_record as(
  select
  customer_key, 
  customer_name,
  customer_category_key, 
  buying_group_key,
  is_on_credit_hold
  from dim_customer__convert_boolean

  UNION ALL
  select 
  0 as customer_key, 
  'Undefined' as customer_name,
  0 as customer_category_key, 
  0 as buying_group_key,
  'Undefined' as is_on_credit_hold

  UNION ALL
  select 
  -1 as customer_key, 
  'Invalid' as customer_name,
  -1 as customer_category_key, 
  -1 as buying_group_key,
  'Invalid' as is_on_credit_hold
)

select 
dim_customer.customer_key,
dim_customer.customer_name,
dim_customer.is_on_credit_hold,
dim_customer.customer_category_key,
coalesce(dim_customer_category.customer_category_name, 'Invalid') as customer_category_name,
dim_customer.buying_group_key,
coalesce(dim_buying_group.buying_group_name, 'Invalid') as buying_group_name,
from dim_customer__add_undefined_record as dim_customer
left join {{ref('stg_dim_customer_category')}} as dim_customer_category 
on dim_customer.customer_category_key = dim_customer_category.customer_category_key
left join {{ref('stg_dim_buying_group')}} as dim_buying_group
on dim_customer.buying_group_key = dim_buying_group.buying_group_key
