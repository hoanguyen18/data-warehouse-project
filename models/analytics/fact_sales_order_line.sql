SELECT 
order_line_id as sales_order_line_key,
stock_item_id as product_key,
quantity,
unit_price,
quantity*unit_price as gross_amount
FROM `vit-lam-data.wide_world_importers.sales__order_lines`
