with dim_product__source as (
  select * FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
),

dim_product__rename_column as (
  select stock_item_id as product_key,
  stock_item_name	as product_name,
  brand as brand_name,
  supplier_id as supplier_key,
  is_chiller_stock as is_chiller_stock_boolean
  from dim_product__source
),

dim_product__cast_type as (
  select 
  cast(product_key as integer) as product_key,
  cast(product_name as string) as product_name,
  cast(brand_name as string) as brand_name,
  cast(supplier_key as integer) as supplier_key,
  cast(is_chiller_stock_boolean as boolean) as is_chiller_stock_boolean
  from dim_product__rename_column
),

dim_product__convert_boolean as (
  select *, --nhung o tren phai doi ten thanh boolean 
  case when is_chiller_stock_boolean is TRUE then 'Chiller Stock'
  when is_chiller_stock_boolean is FALSE then 'Not Chiller Stock'
  when is_chiller_stock_boolean is null then 'Undefined'
  else 'Invalid' end as is_chiller_stock
  from dim_product__cast_type
)
-- nen ghi ro cac cot, thay vi dung * de nguoi doc hieu ro
select dim_product.product_key,
dim_product.product_name,
coalesce(dim_product.brand_name, 'Undefined') as brand_name, 
dim_product.supplier_key,
dim_supplier.supplier_name,
dim_product.is_chiller_stock
from dim_product__convert_boolean as dim_product 
left join {{ref('dim_supplier')}} as dim_supplier
on dim_product.supplier_key = dim_supplier.supplier_key