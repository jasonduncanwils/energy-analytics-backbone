PREPARE populate_sp_alert(bigint) AS

INSERT INTO grid.alert 
SELECT 
 CP.UID_Component, 
 $1, 
 ST.update_date, 
 ST.component_ID, 
 ST.comp_source_system, 
 ST.comp_type, 
 ST.data_origin, 
 COALESCE(AM.measurement_type,'GENERAL-DATA'), 
 ST.alert_date, 
 ST.alert_message,
 ST.alert_system
FROM        stage.alert_pxf                      ST 
INNER JOIN  grid.component                        CP 
 ON  ST.Component_ID = CP.Component_ID 
 AND ST.Comp_Source_System = CP.Comp_Source_System 
 AND ST.Comp_Type = CP.Comp_Type 
 LEFT
OUTER JOIN  grid.alert_mapping                    AM 
 ON  ST.data_origin = AM.data_origin 
 AND ST.alert_message = AM.alert_message 
 AND ST.alert_system = AM.alert_system 
WHERE 
     ST.Comp_Type NOT IN ('METER_ELEC','METER_GAS') 
 AND AM.valid_alert = true
EXCEPT
SELECT
 DISTINCT
 A.*
 FROM grid.alert A
WHERE 
 A.Comp_Type NOT IN ('METER_ELEC','METER_GAS')
 AND
 A.UID_GROUP = $1
;

EXECUTE populate_sp_alert(grid.getPendingAlertGroupId());

DEALLOCATE populate_sp_alert;