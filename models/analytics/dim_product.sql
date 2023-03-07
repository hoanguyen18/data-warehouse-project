SELECT 
cast(stock_item_id as integer)	as product_key,
cast(stock_item_name	as string) as product_name,
cast(brand	as string) as brand_name
FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
