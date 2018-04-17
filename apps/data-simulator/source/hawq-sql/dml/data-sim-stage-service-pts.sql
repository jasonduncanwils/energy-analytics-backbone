-- **************************************** 
-- STAGE ELECTRIC SERVICE POINTS 
-- **************************************** 
prepare stage_elec_sps (integer,integer,integer) as 

insert into data_sim.attribute_staging
select      distinct
            'FULL_SERV_PT_ID_ELEC',
            nextval('data_sim.seq_attribute_staging'), 
            tmp1.serv_pt_id
from        (
            select      distinct
                        attr_stg_value,
                        floor((random()*$2))+$3 as serv_pt_id
            from        data_sim.attribute_staging
            where       attr_stg_type = 'FULL_CUSTOMER_NAME'
            limit       $1
            ) tmp1
limit       $1;

EXECUTE stage_elec_sps(data_sim.getSimParameterInt('NUMBER_OF_SPS'),data_sim.getSimParameterInt('SERV_PT_ID_ELEC_RANGE'),data_sim.getSimParameterInt('SERV_PT_ID_ELEC_MIN'));

DEALLOCATE stage_elec_sps;

-- **************************************** 
-- STAGE GAS SERVICE POINTS 
-- **************************************** 
prepare stage_gas_sps (integer,integer,integer,integer) as 
    
insert into data_sim.attribute_staging
select      distinct
            'FULL_SERV_PT_ID_GAS',
            nextval('data_sim.seq_attribute_staging'), 
            tmp1.serv_pt_id
from        (
            select      distinct
                        attr_stg_value,
                        floor((random()*$2))+$3 as serv_pt_id
            from        data_sim.attribute_staging
            where       attr_stg_type = 'FULL_CUSTOMER_NAME'
            limit       ($1*($4/100))
            ) tmp1
limit       ($1*($4/100));

EXECUTE stage_gas_sps(data_sim.getSimParameterInt('NUMBER_OF_SPS'),data_sim.getSimParameterInt('SERV_PT_ID_GAS_RANGE'),data_sim.getSimParameterInt('SERV_PT_ID_GAS_MIN'),data_sim.getSimParameterInt('PERCENT_WITH_GAS'));

DEALLOCATE stage_gas_sps;
