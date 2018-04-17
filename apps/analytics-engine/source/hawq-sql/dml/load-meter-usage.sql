PREPARE populate_meter_usage(bigint) AS

INSERT INTO grid.usage 
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
 ST.measurement_type, 
 ST.start_date, 
 ST.end_date, 
 ST.usage_value, 
 ST.seconds, 
 ST.multiplier, 
 ST.data_origin, 
 ST.quality_code 
FROM        stage.usage_pxf                      ST 
INNER JOIN  grid.component                        CP 
 ON  ST.Component_ID = CP.Component_ID 
 AND ST.Comp_Source_System = CP.Comp_Source_System 
 AND ST.Comp_Type = CP.Comp_Type 
INNER JOIN  grid.vw_attribute_meter_hist          AMH 
 ON  AMH.meter_id = ST.component_id 
 AND AMH.meter_source_system = ST.comp_source_system 
 AND AMH.comp_type = ST.comp_type 
 AND ST.end_date > amh.install_date 
 AND (    ST.end_date <= amh.remove_date 
	  or  amh.remove_date is null) 
WHERE 
 ST.Comp_Type IN ('METER_ELEC','METER_GAS')
EXCEPT
SELECT
 DISTINCT
 U.*
 FROM grid.usage U
WHERE U.Comp_Type IN ('METER_ELEC', 'METER_GAS')
 AND
U.UID_GROUP = $1
;

EXECUTE populate_meter_usage(grid.getPendingUsageGroupId());

DEALLOCATE populate_meter_usage;