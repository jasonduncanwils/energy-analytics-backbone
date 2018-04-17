create or replace function data_sim.getcountattrstg (text) 
returns bigint
as $$
    SELECT  COUNT(sequence)
	FROM    data_sim.attribute_staging 
	WHERE   attr_stg_type = $1; 
$$ 
language sql;