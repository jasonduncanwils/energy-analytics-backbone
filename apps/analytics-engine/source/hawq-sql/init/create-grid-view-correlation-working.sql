CREATE OR REPLACE VIEW grid.vw_correlation_working AS 
SELECT 
 CW.uid_component, 
 CW.comp_type, 
 CW.end_date, 
 CW.condition_array 
FROM      grid.correlation_working            CW 
GROUP BY 
 CW.uid_component, 
 CW.comp_type, 
 CW.end_date, 
 CW.condition_array 
 ; 