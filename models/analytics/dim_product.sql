with dim_product__source as (
  select * FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
),

dim_product__rename_column as (
  select stock_item_id as product_key,
  stock_item_name	as product_name,
  brand as brand_name 
  from dim_product__source
),

dim_product__cast_type as (
  select 
  cast(stock_item_id as integer) as product_key,
  cast(stock_item_name as string) as product_name,
  cast(brand as string) as brand_name
  from dim_product__source
)
-- nen ghi ro cac cot, thay vi dung * de nguoi doc hieu ro
select product_key,
product_name,
brand_name
from dim_product__cast_type