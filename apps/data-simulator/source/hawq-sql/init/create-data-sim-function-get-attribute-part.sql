create or replace function data_sim.getattributepart (text) 
returns text
as $$
    select      attr_part_value
    from        data_sim.attribute_part
    where       attr_part_type = $1
    order by    random()
    limit       1;
$$ 
language sql;