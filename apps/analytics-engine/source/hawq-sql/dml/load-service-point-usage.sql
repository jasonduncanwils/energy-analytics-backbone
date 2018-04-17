PREPARE populate_sp_usage(bigint) AS

INSERT INTO grid.usage 
SELECT 
 CP.UID_Component, 
 $1, 
 ST.* 
FROM        stage.usage_pxf                      ST 
INNER JOIN  grid.component                        CP 
 ON  ST.Component_ID = CP.Component_ID 
 AND ST.Comp_Source_System = CP.Comp_Source_System 
 AND ST.Comp_Type = CP.Comp_Type 
WHERE 
 ST.Comp_Type NOT IN ('METER_ELEC','METER_GAS')
EXCEPT
SELECT
 DISTINCT
 U.*
 FROM grid.usage U
WHERE 
 U.Comp_Type NOT IN ('METER_ELEC','METER_GAS')
 AND
 U.UID_GROUP = $1
;

EXECUTE populate_sp_usage(grid.getPendingUsageGroupId());

DEALLOCATE populate_sp_usage;