PREPARE populate_meter_alert(bigint) AS

INSERT INTO grid.alert 
SELECT 
 CASE 
 WHEN AMH.UID_Component IS NOT NULL 
 THEN AMH.UID_Component 
 ELSE CP.UID_Component 
 END, 
 $1, 
 ST.update_date, 
 CASE 
 WHEN AMH.UID_Component IS NOT NULL 
 THEN AMH.component_id 
 ELSE CP.component_id 
 END, 
 CASE 
 WHEN AMH.UID_Component IS NOT NULL 
 THEN AMH.comp_source_system 
 ELSE CP.comp_source_system 
 END, 
 CASE 
 WHEN AMH.UID_Component IS NOT NULL 
 THEN AMH.comp_type 
 ELSE CP.comp_type 
 END, 
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
INNER JOIN  grid.vw_attribute_meter_hist          AMH 
 ON  AMH.meter_id = ST.component_id 
 AND AMH.meter_source_system = ST.comp_source_system 
 AND AMH.comp_type = ST.comp_type 
 AND ST.alert_date > amh.install_date 
 AND (    ST.alert_date <= amh.remove_date 
	  or  amh.remove_date is null) 
 LEFT
OUTER JOIN  grid.alert_mapping                    AM 
 ON  ST.data_origin = AM.data_origin 
 AND ST.alert_message = AM.alert_message 
 AND ST.alert_system = AM.alert_system 
WHERE 
     ST.Comp_Type IN ('METER_ELEC','METER_GAS') 
 AND AM.valid_alert = true 
EXCEPT
SELECT
 DISTINCT
 A.*
 FROM grid.alert A
WHERE 
 A.Comp_Type IN ('METER_ELEC','METER_GAS')
 AND
 A.UID_GROUP = $1
;

EXECUTE populate_meter_alert(grid.getPendingAlertGroupId());

DEALLOCATE populate_meter_alert;