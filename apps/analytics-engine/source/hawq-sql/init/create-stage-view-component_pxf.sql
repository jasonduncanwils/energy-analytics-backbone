CREATE OR REPLACE VIEW stage.vw_component_pxf AS
SELECT
		DISTINCT
		TMP.Component_ID,
		TMP.Comp_Source_System,
		TMP.Comp_Type
		FROM (

			SELECT 
         		DISTINCT 
         		ST.Component_ID, 
        	 	ST.Comp_Source_System, 
         		ST.Comp_Type 
        	FROM   stage.usage_pxf                   ST 
			UNION ALL
			SELECT 
         		DISTINCT 
         		ST.Component_ID, 
         		ST.Comp_Source_System, 
         		ST.Comp_Type 
        		FROM   stage.alert_pxf                   ST 
			UNION ALL
        	SELECT 
         		DISTINCT 
         		ST.Component_ID, 
         		ST.Comp_Source_System, 
         		ST.Comp_Type 
        		FROM   stage.attribute_sp_pxf            ST 
			UNION ALL
        	SELECT 
         		DISTINCT 
         		ST.Component_ID, 
         		ST.Comp_Source_System, 
         		ST.Comp_Type 
        		FROM   stage.attribute_meter_hist_pxf    ST
			UNION ALL
        	SELECT 
         		DISTINCT 
         		ST.Component_ID, 
         		ST.Comp_Source_System, 
         		ST.Comp_Type 
        		FROM   stage.attribute_connection_hist_pxf   ST
        ) TMP
; 