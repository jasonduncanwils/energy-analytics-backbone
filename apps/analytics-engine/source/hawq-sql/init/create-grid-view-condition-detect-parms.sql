CREATE OR REPLACE VIEW grid.vw_condition_detect_parms AS 
SELECT 
 CDMF.detection_name, 
 ARRAY(SELECT 
        CDMFP.parm_value 
       FROM      grid.condition_detect_method_func_p  CDMFP 
       WHERE 
            CDMFP.detection_name = CDMF.detection_name 
        AND CDMFP.update_date = 
                      (SELECT
                        MAX(CDMFP2.update_date) 
                       FROM    grid.condition_detect_method_func_p             CDMFP2 
                       WHERE 
						    CDMFP2.detection_name = CDMFP.detection_name 
					    AND CDMFP2.parm_number = CDMFP.parm_number 
                      )
       ORDER BY 
        CDMFP.parm_number 
      ) AS parm_array 
FROM     grid.condition_detect_method_func      CDMF 
 ; 