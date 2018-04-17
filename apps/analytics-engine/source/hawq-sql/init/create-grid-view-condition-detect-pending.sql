CREATE OR REPLACE VIEW grid.vw_condition_detect_pending AS 
SELECT 
 CDM.detection_method, 
 CDM.comp_type, 
 CDMF.detection_name, 
 CDMF.detection_logic,  
   (
	SELECT 
	 CDP.parm_array 
	FROM    grid.vw_condition_detect_parms   CDP 
	WHERE 
	     CDP.detection_name = CDMF.detection_name 
   ) AS parm_array, 
   (
    SELECT 
	 MAX(GT.max_data_date) 
	FROM   grid.group_tracking                   GT 
	WHERE 
		 GT.related_data = 'GRID.USAGE' 
	 AND GT.group_status = 'DETECTION_COMPLETE' 
   ) AS detection_end_date 
FROM       grid.condition_detect_method           CDM 
INNER JOIN grid.condition_detect_method_func      CDMF 
 ON  CDMF.detection_method = CDM.detection_method 
 ;