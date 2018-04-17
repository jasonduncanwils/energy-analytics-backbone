create or replace function data_sim.getrandombillday (integer) 
returns text
as $$
    select      cast(floor(random()*$1) as text);
$$ 
language sql;