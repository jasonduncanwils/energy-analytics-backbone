prepare stage_customers (integer) as 

insert into data_sim.attribute_staging
select      'FULL_CUSTOMER_NAME',
            nextval('data_sim.seq_attribute_staging'), 
            a4.attr_part_value||' '||a5.attr_part_value||' '||a6.attr_part_value 
from        (
            select      distinct
                        a3.uid_attr_part as uid_first_name,
                        tmp2.uid_middle_name,
                        tmp2.uid_last_name
            from        data_sim.attribute_part                 a3,
                        (
                        select      distinct
                                    a2.uid_attr_part as uid_middle_name,
                                    tmp1.uid_last_name
                        from        data_sim.attribute_part                 a2,
                                    (
                                    select      distinct
                                                a1.uid_attr_part as uid_last_name
                                    from        data_sim.attribute_part                 a1
                                    where       a1.attr_part_type = 'CUSTOMER_LAST_NAME'
                                    order by    random()
                                    limit       $1
                                    ) tmp1
                        where       a2.attr_part_type = 'CUSTOMER_MIDDLE_NAME'
                        order by    random()
                        limit       $1
                        ) tmp2
            where       a3.attr_part_type = 'CUSTOMER_FIRST_NAME'
            order by    random()
            limit       $1
            ) tmp3

inner join  data_sim.attribute_part                 a4
 on a4.uid_attr_part = tmp3.uid_first_name
inner join  data_sim.attribute_part                 a5
 on a5.uid_attr_part = tmp3.uid_middle_name
inner join  data_sim.attribute_part                 a6
 on a6.uid_attr_part = tmp3.uid_last_name
limit       $1;

EXECUTE stage_customers(data_sim.getSimParameterInt('NUMBER_OF_SPS'));

DEALLOCATE stage_customers;