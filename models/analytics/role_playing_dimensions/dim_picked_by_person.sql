select
person_key as picked_by_person_key,
full_name as picked_by_full_name
from {{ ref('dim_person') }}
