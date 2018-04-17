INSERT INTO grid.group_tracking 
SELECT 
 GT.uid_group, 
 'DETECTION_COMPLETE', 
 GT.related_data, 
 GT.max_data_date 
FROM   grid.group_tracking                      GT 
WHERE  
     gt.group_status = 'DETECTION_PENDING' 
 AND NOT EXISTS (SELECT * 
                 FROM   grid.group_tracking 
                 WHERE  
                      uid_group = GT.uid_group 
                  AND group_status = 'DETECTION_COMPLETE' 
                ) 
; 