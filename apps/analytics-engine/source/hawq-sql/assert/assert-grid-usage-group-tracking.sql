SELECT COUNT(*)
FROM
	( 
		SELECT TMP.End_Date
		FROM (
			SELECT
		 		MAX(ST.End_Date) as End_Date
			FROM stage.usage_pxf	ST
			EXCEPT
			SELECT
				MAX(GT_VW.Max_Data_Date)
			FROM grid.vw_group_tracking GT_VW
			WHERE
				GT_VW.group_status = 'LOAD_PENDING' AND GT_VW.related_data = 'GRID.USAGE'
			) TMP	
		WHERE TMP.End_Date IS NOT NULL
	) TMP