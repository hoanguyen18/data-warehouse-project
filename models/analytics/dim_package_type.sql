with dim_package_type__source as(
  SELECT 
  *
FROM `vit-lam-data.wide_world_importers.warehouse__package_types`
),

dim_package_type__rename_column as (
  select package_type_id as package_type_key,
  package_type_name
  from dim_package_type__source
),

dim_package_type__cast_type as(
  select cast(package_type_key as integer) as package_type_key,
  cast(package_type_name as string) as package_type_name
  from dim_package_type__rename_column
),

dim_package_type__add_undefined_record as(
  select package_type_key, --select cai bang cast_type de union thoi
  package_type_name
  from dim_package_type__cast_type

  UNION ALL
  select
  0 as package_type_key,
  'Undefined' as package_type_name
)


select package_type_key, package_type_name
from dim_package_type__add_undefined_record