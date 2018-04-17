INSERT INTO grid.condition 
SELECT 
 ASP.UID_Component, 
 ASP.component_id, 
 ASP.comp_source_system, 
 ASP.comp_type, 
 TMP1.condition_code, 
 TMP1.detection_end_date, 
 CURRENT_TIMESTAMP 
FROM  
         (
          SELECT 
           CDP.detection_method, 
           CDP.detection_name, 
           CDP.comp_type, 
           CDP.parm_array[2] AS condition_code, 
           CDP.parm_array, 
           CDP.detection_end_date 
          FROM       grid.vw_condition_detect_pending    CDP 
          WHERE 
               CDP.detection_logic = 'xxxxxxxxx.sql'
           AND CDP.parm_array[1] = 'Y' 
         ) TMP1 
INNER JOIN grid.vw_attribute_sp               ASP 
 ON  ASP.comp_type = TMP1.comp_type 
 -- AND ASP.net_metering_yn = 'N' 

GROUP BY 
 ASP.UID_Component, 
 CURRENT_TIMESTAMP, 
 ASP.component_id, 
 ASP.comp_source_system, 
 ASP.comp_type, 
 TMP1.condition_code, 
 TMP1.detection_end_date 
; 