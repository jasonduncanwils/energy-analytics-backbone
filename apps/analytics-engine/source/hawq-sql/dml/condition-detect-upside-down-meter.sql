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
               CDP.detection_logic = 'condition-detect-upside-down-meter.sql'
           AND CDP.parm_array[1] = 'Y' 
         ) TMP1 
INNER JOIN grid.vw_attribute_sp               ASP 
 ON  ASP.comp_type = TMP1.comp_type 
 AND ASP.net_metering_yn = 'N' 
INNER JOIN grid.vw_calc                       CA1 
 ON  CA1.UID_Component = ASP.UID_Component 
 AND CA1.End_Date = TMP1.detection_end_date 
 AND CA1.calc_function = 'SUM_30_DAY_ROLLING' 
 AND CA1.orig_measurement_type = 'KWH-REC' 
 AND CA1.calc_value > CAST(TMP1.parm_array[3] AS INTEGER) 
INNER JOIN grid.vw_calc                       CA2 
 ON  CA2.UID_Component = ASP.UID_Component 
 AND CA2.End_Date = TMP1.detection_end_date 
 AND CA2.calc_function = 'SUM_30_DAY_ROLLING' 
 AND CA2.orig_measurement_type = 'KWH-DEL' 
 AND CA2.calc_value = 0 
GROUP BY 
 ASP.UID_Component, 
 CURRENT_TIMESTAMP, 
 ASP.component_id, 
 ASP.comp_source_system, 
 ASP.comp_type, 
 TMP1.condition_code, 
 TMP1.detection_end_date 
; 