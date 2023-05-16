with dim_product__source as (
  select * FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
),

dim_product__rename_column as (
  select stock_item_id as product_key,
  stock_item_name	as product_name,
  brand as brand_name,
  supplier_id as supplier_key 
  from dim_product__source
),

dim_product__cast_type as (
  select 
  cast(product_key as integer) as product_key,
  cast(product_name as string) as product_name,
  cast(brand_name as string) as brand_name,
  cast(supplier_key as integer) as supplier_key
  from dim_product__rename_column
)
-- nen ghi ro cac cot, thay vi dung * de nguoi doc hieu ro
select dim_product.product_key,
dim_product.product_name,
dim_product.brand_name, 
dim_product.supplier_key,
dim_supplier.supplier_name
from dim_product__cast_type as dim_product 
left join {{ref('dim_supplier')}} as dim_supplier
on dim_product.supplier_key = dim_supplier.supplier_key