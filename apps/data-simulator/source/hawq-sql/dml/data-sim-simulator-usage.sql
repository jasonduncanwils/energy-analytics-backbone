truncate data_sim.usage;

-- ************************************************************** 

PREPARE usage_sim (timestamp,integer) AS

INSERT INTO data_sim.usage
SELECT 
 TMP2.component_id,
 TMP2.component_source_system,
 TMP2.component_type,
 TMP2.measurement_type,
 TMP2.end_date-CAST(TMP2.seconds||' second' AS INTERVAL) AS start_date, 
 TMP2.end_date, 
 round(CAST((random()*cast(TMP2.random_value_multiple as decimal)*TMP2.meter_multiplier) AS decimal),3) AS usage_value, 
 TMP2.seconds,
 TMP2.meter_multiplier,
 TMP2.data_origin,
 TMP2.default_quality_code
FROM       (
            SELECT
             TMP1.*, 
             CAST(UNNEST(data_sim.getusagedates(TMP1.sim_end_date, 
                                                $2, -- had to pass total seconds because the EXTRACT function is not in HAWQ yet
                                                TMP1.seconds
                                               )) AS TIMESTAMP) AS end_date 
            FROM       (
                        SELECT      DISTINCT
                                    sct.component_id,
                                    sct.component_source_system,
                                    sct.component_type,
                                    up.measurement_type,
                                    up.data_origin,
                                    up.seconds,
                                    up.meter_multiplier,
                                    up.default_quality_code,
                                    up.likelihood_percent,
                                    up.random_value_ind,
                                    up.random_value_multiple,
                                    $1 AS sim_end_date 
                        FROM        data_sim.simulator_comp_temp        SCT
                        INNER JOIN  data_sim.usage_profile              UP
                         ON         sct.temp_value = up.usg_prf_type
                        WHERE       
                             sct.temp_type = 'USAGE_PROFILE'
                         AND up.data_origin IN ('INTERVAL','DAILY_SCALAR')
                         AND up.random_value_ind = true 
                       ) TMP1 
           ) TMP2 
; 

execute usage_sim(data_sim.getSimParameterTimestamp('USAGE_END_DATE'), data_sim.getSimParameterInt('USAGE_TOTAL_SECONDS'));

deallocate usage_sim;

-- ************************************************************** 

-- TO DO... 
-- still need to code for monthly usage as a data origin
