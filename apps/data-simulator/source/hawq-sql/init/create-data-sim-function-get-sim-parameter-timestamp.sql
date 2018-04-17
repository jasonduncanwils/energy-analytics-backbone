create or replace function data_sim.getsimparametertimestamp (text) 
returns timestamp
as $$
    select      CAST(parameter_value AS TIMESTAMP)
    from        data_sim.simulator_parameters
    where       parameter_name = $1;
$$ 
language sql;