truncate data_sim.alert;

-- ************************************************************** 

prepare alert_sim_with_no_dependency (timestamp,integer) as

INSERT INTO data_sim.alert 
SELECT 
 TMP1.component_id, 
 TMP1.component_source_system, 
 TMP1.component_type, 
 TMP1.data_origin, 
 TMP1.end_date - CAST(FLOOR(RANDOM()*$2)||' second' AS INTERVAL) , 
 TMP1.alert_message, 
 TMP1.alert_system 
FROM 
		(
		select		distinct
					cp.component_id,
					cp.component_source_system,
					cp.component_type,
					ap.data_origin,
					ap.alert_message,
					ap.alert_system,
					ap.likelihood_percent,
					RANDOM()*100 AS random_factor,
					$1 AS end_date
		from		data_sim.component					cp
		inner join	data_sim.alert_profile				ap
		 on			cp.component_type = ap.component_type
		where 		ap.restrict_to_usg_prf_type is null 
		) TMP1
WHERE 
 TMP1.random_factor <= TMP1.likelihood_percent 
; 

execute alert_sim_with_no_dependency(data_sim.getSimParameterTimestamp('ALERT_END_DATE'), data_sim.getSimParameterInt('ALERT_TOTAL_SECONDS'));

deallocate alert_sim_with_no_dependency;

-- ************************************************************** 

prepare alert_sim_with_dependency (timestamp,integer) as

INSERT INTO data_sim.alert 
SELECT 
 TMP1.component_id, 
 TMP1.component_source_system, 
 TMP1.component_type, 
 TMP1.data_origin, 
 TMP1.end_date - CAST(FLOOR(RANDOM()*$2)||' second' AS INTERVAL) , 
 TMP1.alert_message, 
 TMP1.alert_system 
FROM 
		(
		select		distinct
					cp.component_id,
					cp.component_source_system,
					cp.component_type,
					ap.data_origin,
					ap.alert_message,
					ap.alert_system,
					ap.likelihood_percent,
					RANDOM()*100 AS random_factor,
					$1 AS end_date
		from		data_sim.component					cp
		inner join	data_sim.simulator_comp_temp		sct
		 on 		sct.temp_type = 'USAGE_PROFILE'
		 and		cp.component_id = sct.component_id
		 and		cp.component_source_system =sct.component_source_system
		 and		cp.component_type = sct.component_type
		inner join	data_sim.alert_profile				ap
		 on			cp.component_type = ap.component_type
		 and		ap.restrict_to_usg_prf_type = sct.temp_value
		where		ap.restrict_to_usg_prf_type is not null
		) TMP1
WHERE 
 TMP1.random_factor <= TMP1.likelihood_percent 
;

execute alert_sim_with_dependency(data_sim.getSimParameterTimestamp('ALERT_END_DATE'), data_sim.getSimParameterInt('ALERT_TOTAL_SECONDS'));

deallocate alert_sim_with_dependency;