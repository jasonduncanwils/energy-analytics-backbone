INSERT INTO grid.attribute_meter_hist 
SELECT 
 CP.UID_Component, 
 ST.* 
FROM        stage.attribute_meter_hist_pxf       ST 
INNER JOIN  grid.component                        CP 
 ON  ST.Component_ID = CP.Component_ID 
 AND ST.Comp_Source_System = CP.Comp_Source_System 
 AND ST.Comp_Type = CP.Comp_Type
EXCEPT
SELECT
 DISTINCT
 ATTR_MTR_HIST.*
 FROM grid.attribute_meter_hist ATTR_MTR_HIST
;