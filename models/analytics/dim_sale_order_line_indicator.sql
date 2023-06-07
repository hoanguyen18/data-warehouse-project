with dim_is_undersupply_backordered as (
SELECT 
  true as is_undersupply_backordered_boolean,
  'Undersupply Backordered' as is_undersupply_backordered
  UNION ALL
SELECT 
  false as is_undersupply_backordered_boolean,
  'Not Undersupply Backordered' as is_undersupply_backordered
)

SELECT
 Concat(dim_is_undersupply_backordered.is_undersupply_backordered_boolean, ',' , 
 dim_package_type.package_type_key) as sale_order_line_indicator_key,
 dim_is_undersupply_backordered.is_undersupply_backordered_boolean,
 dim_is_undersupply_backordered.is_undersupply_backordered,
 dim_package_type.package_type_key,
 dim_package_type.package_type_name
 from dim_is_undersupply_backordered
 CROSS JOIN {{ref('dim_package_type')}} as dim_package_type
 order by 1,3