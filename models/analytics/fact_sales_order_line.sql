with fact_sales_order_line__source as (
SELECT *
FROM `vit-lam-data.wide_world_importers.sales__order_lines`),

fact_sales_order_line__rename_column as (
  select
  order_line_id as sales_order_line_key,
  order_id as sales_order_key,
  stock_item_id as product_key,
quantity,
unit_price
from fact_sales_order_line__source
),

fact_sales_order_line__cast_type as (
select cast(sales_order_line_key as integer) as sales_order_line_key,
cast(sales_order_key as integer) as sales_order_key,
cast(product_key as integer) as product_key,
cast(quantity as integer) as quantity,
cast(unit_price as numeric) as unit_price
from fact_sales_order_line__rename_column),

fact_sales_order_line__calculate_measure as (
select sales_order_line_key,
sales_order_key,
product_key,
quantity,
unit_price, 
quantity * unit_price as gross_amount
from fact_sales_order_line__cast_type)

select
fact_line.sales_order_line_key,
fact_line.sales_order_key,
fact_line.product_key,
fact_header.customer_key,
fact_line.quantity,
fact_line.unit_price,
fact_line.gross_amount
from fact_sales_order_line__calculate_measure as fact_line
left join {{ ref('stg_fact_sales_order')}} as fact_header
on fact_line.sales_order_key = fact_header.sales_order_key

