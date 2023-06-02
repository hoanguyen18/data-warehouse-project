select
person_key as salesperson_person_key,
full_name as salesperson_full_name
from {{ ref('dim_person') }}
