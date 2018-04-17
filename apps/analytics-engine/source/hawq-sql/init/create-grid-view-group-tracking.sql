CREATE OR REPLACE VIEW grid.vw_group_tracking AS 
	SELECT * 
	FROM grid.group_tracking gt 
	WHERE created_date = (SELECT MAX(created_date) FROM grid.group_tracking t WHERE t.uid_group = gt.uid_group);
