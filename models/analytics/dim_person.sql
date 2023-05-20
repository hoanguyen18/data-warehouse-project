with dim_person__source as(
  SELECT 
  *
FROM `vit-lam-data.wide_world_importers.application__people`
),

dim_person__rename_column as (
  select person_id as person_key,
  full_name
  from dim_person__source
),

dim_person__cast_type as(
  select cast(person_key as integer) as person_key,
  cast(full_name as string) as full_name
  from dim_person__rename_column
)

select person_key, full_name
from dim_person__cast_type