create or replace function data_sim.getsimparameterint (text) 
returns integer
as $$
    select      CAST(parameter_value AS INTEGER)
    from        data_sim.simulator_parameters
    where       parameter_name = $1;
$$ 
language sql;