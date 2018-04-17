-- **************************************** 
-- STAGE ELECTRIC METERS 
-- **************************************** 
prepare stage_elec_sps (integer,integer,integer) as 

insert into data_sim.attribute_staging
select		distinct
			'FULL_METER_ID_ELEC',
            nextval('data_sim.seq_attribute_staging'), 
			tmp3.meter_id||'-'||tmp3.meter_type||'-'||tmp3.state_code 
from	   (
			select		distinct
						a3.attr_part_value as state_code,
						tmp2.meter_type,
						tmp2.meter_id
			from		data_sim.attribute_part					a3,
					   (
						select		distinct
									a2.attr_part_value as meter_type,
									tmp1.meter_id
						from		data_sim.attribute_part					a2,
									(
									select		distinct
												attr_stg_value,
												floor((random()*$2))+$3 as meter_id
									from		data_sim.attribute_staging
									where		attr_stg_type = 'FULL_CUSTOMER_NAME'
									limit		$1
									) tmp1
						where 		a2.attr_part_type = 'METER_TYPE_ELEC'
						order by	random()
						limit		$1
						) tmp2
			where 		a3.attr_part_type = 'STATE'
			order by	random()
			limit		$1
			) tmp3
limit		$1;

EXECUTE stage_elec_sps(data_sim.getSimParameterInt('NUMBER_OF_SPS'),data_sim.getSimParameterInt('METER_ID_ELEC_RANGE'),data_sim.getSimParameterInt('METER_ID_ELEC_MIN'));

DEALLOCATE stage_elec_sps;

-- **************************************** 
-- STAGE GAS METERS 
-- **************************************** 
prepare stage_gas_sps (integer,integer,integer,integer) as 

insert into data_sim.attribute_staging
select		distinct
			'FULL_METER_ID_GAS',
            nextval('data_sim.seq_attribute_staging'), 
			tmp3.meter_id||'-'||tmp3.meter_type||'-'||tmp3.state_code 
from	   (
			select		distinct
						a3.attr_part_value as state_code,
						tmp2.meter_type,
						tmp2.meter_id
			from		data_sim.attribute_part					a3,
					   (
						select		distinct
									a2.attr_part_value as meter_type,
									tmp1.meter_id
						from		data_sim.attribute_part					a2,
									(
									select		distinct
												attr_stg_value,
												floor((random()*$2))+$3 as meter_id
									from		data_sim.attribute_staging
									where		attr_stg_type = 'FULL_CUSTOMER_NAME'
									limit		($1*($4/100))
									) tmp1
						where 		a2.attr_part_type = 'METER_TYPE_GAS'
						order by	random()
						limit		($1*($4/100))
						) tmp2
			where 		a3.attr_part_type = 'STATE'
			order by	random()
			limit		($1*($4/100))
			) tmp3
limit		($1*($4/100));

EXECUTE stage_gas_sps(data_sim.getSimParameterInt('NUMBER_OF_SPS'),data_sim.getSimParameterInt('METER_ID_GAS_RANGE'),data_sim.getSimParameterInt('METER_ID_GAS_MIN'),data_sim.getSimParameterInt('PERCENT_WITH_GAS'));

DEALLOCATE stage_gas_sps;