-- **************************************** 
-- USAGE PROFILES TEMP STORAGE 
-- **************************************** 
INSERT INTO data_sim.simulator_profile_temp 
SELECT 
 'USAGE_PROFILE',
 tmp2.usg_prf_type,
 tmp2.component_type 
FROM   (
        SELECT 
         DISTINCT 
         TMP1.counter, 
         up.usg_prf_type, 
         up.component_type 
		FROM       (
					SELECT
					 unnest(array[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100]) AS counter
                   ) TMP1 , 
                    data_sim.usage_profile                  up 
        WHERE 
         TMP1.counter < up.likelihood_percent 
        ORDER BY 
         TMP1.counter, 
         up.usg_prf_type, 
         up.component_type 
       ) TMP2 
; 

-- **************************************** 
-- ELECTRIC SERVICE POINTS COMPONENTS 
-- **************************************** 

-- INSERT INTO SP ATTRIBUTE TABLE 
prepare insert_elec_attribute_sp (integer) as
 
INSERT INTO data_sim.attribute_sp 
SELECT 
 tmp1.serv_pt_id, 
 (select attr_part_value from data_sim.vw_attribute_part where attr_part_type = 'CIS_NAME' limit 1), 
 'SERVICE_PT_ELEC', 
 AS1.attr_stg_value,
 (select attr_part_value from data_sim.vw_attribute_part where attr_part_type = 'CITY' limit 1), 
 (select attr_part_value from data_sim.vw_attribute_part where attr_part_type = 'STATE' limit 1), 
 (select attr_part_value from data_sim.vw_attribute_part where attr_part_type = 'POSTAL_CODE' limit 1), 
 AS2.attr_stg_value, 
 'Y', -- DEFAULT 
 'Y'  -- DEFAULT 
 FROM 
		(
		SELECT      DISTINCT 
					ast.attr_stg_value as serv_pt_id, 
					ast.sequence 
		FROM        data_sim.attribute_staging                ast 
		WHERE       ast.attr_stg_type = 'FULL_SERV_PT_ID_ELEC' 
		ORDER BY    ast.sequence 
		) TMP1 
INNER JOIN  data_sim.attribute_staging            AS1 
 ON  AS1.attr_stg_type = 'FULL_ADDRESS' 
 AND AS1.sequence = TMP1.sequence - ($1*2) 
INNER JOIN  data_sim.attribute_staging            AS2 
 ON  AS2.attr_stg_type = 'FULL_CUSTOMER_NAME' 
 AND AS2.sequence = TMP1.sequence - ($1*3) 
; 

execute insert_elec_attribute_sp(data_sim.getSimParameterInt('NUMBER_OF_SPS'));

deallocate insert_elec_attribute_sp;

    
-- INSERT INTO METER HISTORY TABLE 
prepare insert_elec_attribute_meter_hist (integer) as

INSERT INTO data_sim.attribute_meter_hist
SELECT 
 asp.component_id, 
 asp.component_source_system, 
 asp.component_type, 
 AS1.attr_stg_value,
 asp.component_source_system, 
 CAST('2014-01-01' AS TIMESTAMP), -- defaulted to jan 1 2014 for now 
 null 
FROM        data_sim.attribute_sp               ASP 
INNER JOIN  data_sim.attribute_staging          AST 
 ON  asp.component_id = ast.attr_stg_value 
 AND ast.attr_stg_type = 'FULL_SERV_PT_ID_ELEC' 
INNER JOIN  data_sim.attribute_staging          AS1 
 ON  AS1.attr_stg_type = 'FULL_METER_ID_ELEC' 
 AND AS1.sequence = ast.sequence - $1 
WHERE 
 asp.component_type = 'SERVICE_PT_ELEC' 
; 

execute insert_elec_attribute_meter_hist(data_sim.getSimParameterInt('NUMBER_OF_SPS'));

deallocate insert_elec_attribute_meter_hist;

-- INSERT ELECTRIC USAGE PROFILE 
INSERT INTO data_sim.simulator_comp_temp 
SELECT 
 asp.component_id, 
 asp.component_source_system, 
 asp.component_type, 
 'USAGE_PROFILE', 
 (SELECT prf_type FROM data_sim.vw_usage_profile WHERE component_type = asp.component_type limit 1) 
FROM        data_sim.attribute_sp               asp 
WHERE 
 asp.component_type = 'SERVICE_PT_ELEC' 
; 

-- **************************************** 
-- GAS SERVICE POINTS COMPONENTS 
-- **************************************** 

-- INSERT INTO SP ATTRIBUTE TABLE 
prepare insert_gas_attribute_sp (integer) as
 
INSERT INTO data_sim.attribute_sp 
SELECT 
 TMP3.gas_serv_pt_id, 
 asp.component_source_system, 
 'SERVICE_PT_GAS', 
 asp.address,
 asp.city, 
 asp.state, 
 asp.postal_code, 
 asp.customer_name, 
 asp.account_active_yn, 
 asp.service_connected_yn 
 FROM		
 		   (
 		   	SELECT 
 		   	 TMP1.gas_serv_pt_id, 
 		   	 TMP2.elec_serv_pt_id 
 		   	FROM 
					(
					SELECT      DISTINCT 
								ast.attr_stg_value as gas_serv_pt_id
					FROM        data_sim.attribute_staging                ast 
					WHERE       ast.attr_stg_type = 'FULL_SERV_PT_ID_GAS' 
					LIMIT       $1 
					) TMP1, 
					(
					SELECT      DISTINCT 
								ast2.attr_stg_value as elec_serv_pt_id, 
								ast2.sequence 
					FROM        data_sim.attribute_staging                ast2 
					WHERE       ast2.attr_stg_type = 'FULL_SERV_PT_ID_ELEC' 
					ORDER BY    ast2.sequence 
					LIMIT       $1 
					) TMP2 
		   ) TMP3 
INNER JOIN data_sim.attribute_sp           asp 
 ON  asp.component_id = TMP3.elec_serv_pt_id 
 AND asp.component_type = 'SERVICE_PT_ELEC' 
; 

execute insert_gas_attribute_sp(data_sim.getCountAttrStg('FULL_SERV_PT_ID_GAS'));

deallocate insert_gas_attribute_sp;

    
-- INSERT INTO METER HISTORY TABLE 
prepare insert_gas_attribute_meter_hist (integer) as

INSERT INTO data_sim.attribute_meter_hist
SELECT 
 asp.component_id, 
 asp.component_source_system, 
 asp.component_type, 
 asp.component_source_system, 
 CAST('2014-01-01' AS TIMESTAMP), -- defaulted to jan 1 2014 for now 
 null 
FROM        data_sim.attribute_sp               asp 
INNER JOIN  data_sim.attribute_staging          ast 
 ON  asp.component_id = ast.attr_stg_value 
 AND ast.attr_stg_type = 'FULL_SERV_PT_ID_GAS' 
INNER JOIN  data_sim.attribute_staging          AS1 
 ON  AS1.attr_stg_type = 'FULL_METER_ID_GAS' 
 AND AS1.sequence = ast.sequence - $1 
WHERE 
 asp.component_type = 'SERVICE_PT_GAS' 
; 

execute insert_gas_attribute_meter_hist(data_sim.getSimParameterInt('NUMBER_OF_SPS'));

deallocate insert_gas_attribute_meter_hist;

-- INSERT GAS USAGE PROFILE 
INSERT INTO data_sim.simulator_comp_temp 
SELECT 
 asp.component_id, 
 asp.component_source_system, 
 asp.component_type, 
 'USAGE_PROFILE', 
 (SELECT prf_type FROM data_sim.vw_usage_profile WHERE component_type = asp.component_type limit 1) 
FROM        data_sim.attribute_sp               asp 
WHERE 
 asp.component_type = 'SERVICE_PT_GAS' 
; 

-- **************************************** 
-- STATEMENTS FOR ALL COMPONENTS  
-- **************************************** 

-- INSERT INTO CONNECTION HISTORY TABLE 
INSERT INTO data_sim.attribute_connection_hist 
SELECT 
 asp.component_id, 
 asp.component_source_system, 
 asp.component_type, 
 'CONNECTED', -- default value for now 
 CAST('2014-01-01' AS TIMESTAMP), -- defaulted to jan 1 2014 for now 
 null 
FROM        data_sim.attribute_sp               asp 
; 

-- INSERT INTO COMPONENT TABLE 
INSERT INTO data_sim.component
SELECT 
 sct.component_id, 
 sct.component_source_system, 
 sct.component_type, 
 up.data_origin 
FROM       data_sim.simulator_comp_temp         sct 
INNER JOIN data_sim.usage_profile               up 
 ON  sct.temp_value = up.usg_prf_type 
WHERE 
 sct.temp_type = 'USAGE_PROFILE' 
;

-- INSERT BILL DAY
prepare insert_bill_day (integer) as

INSERT INTO data_sim.simulator_comp_temp
SELECT
 asp.component_id, 
 asp.component_source_system, 
 asp.component_type, 
 'BILL_DAY', 
 FLOOR((RANDOM()*$1)+1)
FROM        data_sim.attribute_sp               asp 
; 

execute insert_bill_day(data_sim.getSimParameterInt('NUM_OF_BILL_DAYS')); 

deallocate insert_bill_day;
        