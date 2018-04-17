create or replace function data_sim.getrandomusgprf (text) 
returns text
as $$
    select      prf_type
    from        data_sim.simulator_profile_temp
    where       table_name = 'USAGE_PROFILE'
     and        component_type = $1
    order by    random()
    limit       1;
$$ 
language sql;