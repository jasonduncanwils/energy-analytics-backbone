INSERT INTO grid.group_tracking 
SELECT 
 NEXTVAL('grid.SEQ_UID_Group'), 
 'LOAD_PENDING', 
 'GRID.ALERT', 
 MAX(TMP.End_Date) 
FROM (
	SELECT 
		MAX(ST.Alert_Date) as End_Date
	FROM stage.alert_pxf ST
	EXCEPT
	SELECT
		MAX(GT_VW.Max_Data_Date)
	FROM grid.vw_group_tracking GT_VW
	WHERE
		GT_VW.group_status = 'LOAD_PENDING' and GT_VW.related_data = 'GRID.ALERT'
	) TMP
HAVING MAX(TMP.End_Date) IS NOT NULL
;