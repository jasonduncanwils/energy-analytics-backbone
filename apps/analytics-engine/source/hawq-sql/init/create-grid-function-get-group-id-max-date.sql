CREATE OR REPLACE FUNCTION grid.getgroupidmaxdate(text,text) RETURNS timestamp
AS $$
SELECT 
 MAX(GT.max_data_date) 
FROM   grid.group_tracking                   GT 
WHERE 
	 GT.related_data = $1 
 AND GT.group_status = $2;  
$$ 
LANGUAGE SQL;