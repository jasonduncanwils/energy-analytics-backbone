INSERT INTO grid.group_tracking 
SELECT 
 GT.uid_group, 
 'CALC_PENDING', 
 GT.related_data, 
 GT.max_data_date 
FROM   grid.group_tracking                      GT 
WHERE  
     gt.group_status = 'LOAD_COMPLETE' 
 AND NOT EXISTS (SELECT * 
                 FROM   grid.group_tracking 
                 WHERE  
                      uid_group = GT.uid_group 
                  AND group_status = 'CALC_PENDING' 
                ) 
;