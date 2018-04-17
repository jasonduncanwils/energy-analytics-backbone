prepare stage_addresses (integer,integer) as 
    
insert into data_sim.attribute_staging
select      'FULL_ADDRESS',
            nextval('data_sim.seq_attribute_staging'), 
            tmp3.street_number||' '||a4.attr_part_value||' '||a5.attr_part_value 
from        (
            select      distinct
                        a3.uid_attr_part as uid_street_qualifier,
                        tmp2.uid_street_name,
                        tmp2.street_number
            from        data_sim.attribute_part                 a3,
                       (
                        select      distinct
                                    a2.uid_attr_part as uid_street_name,
                                    tmp1.street_number
                        from        data_sim.attribute_part                 a2,
                                    (
                                    select      distinct
                                                floor(random()*$2) as street_number,
                                                attr_stg_type
                                    from        data_sim.attribute_staging
                                    where       attr_stg_type = 'FULL_CUSTOMER_NAME'
                                    order by    random()
                                    limit       $1
                                    ) tmp1
                        where       a2.attr_part_type = 'STREET_NAME'
                        order by    random()
                        limit       $1
                        ) tmp2
            where       a3.attr_part_type = 'STREET_QUALIFIER'
            order by    random()
            limit       $1
            ) tmp3
inner join  data_sim.attribute_part             a4
 on a4.uid_attr_part = tmp3.uid_street_name
inner join  data_sim.attribute_part             a5
 on a5.uid_attr_part = tmp3.uid_street_qualifier
limit       $1;

execute stage_addresses(data_sim.getSimParameterInt('NUMBER_OF_SPS'),data_sim.getSimParameterInt('MAX_STREET_NUMBER'));

deallocate stage_addresses;