INSERT INTO grid.component 
SELECT 
 NEXTVAL('grid.SEQ_UID_Component'), 
 TMP.Component_ID, 
 TMP.Comp_Source_System, 
 TMP.Comp_Type 
FROM   ( 
        SELECT 
         DISTINCT 
         CP_VW.Component_ID, 
         CP_VW.Comp_Source_System, 
         CP_VW.Comp_Type 
        FROM stage.vw_component_pxf               CP_VW
        EXCEPT  
        SELECT 
         DISTINCT 
         CP.Component_ID, 
         CP.Comp_Source_System, 
         CP.Comp_Type 
        FROM  grid.component                      CP 
       ) TMP 
;