INSERT INTO grid.calc 
SELECT 
 TMP3.UID_Component, 
 CURRENT_TIMESTAMP, 
 CP3.Component_ID, 
 CP3.Comp_Source_System, 
 CP3.Comp_Type, 
 TMP3.Calc_Function, 
 TMP3.Measurement_Type AS Orig_Measurement_Type, 
 TMP3.Data_Origin, 
 TMP3.Reliability_Percent, 
 TMP3.Start_Date, 
 TMP3.End_Date, 
 TMP3.Calc_Value, 
 TMP3.Seconds, 
 CAST(NULL AS TIMESTAMP) AS Occurance_Date 
FROM 
        ( 
        SELECT 
         TMP2.UID_Component, 
         TMP2.Calc_Function, 
         TMP2.Measurement_Type, 
         TMP2.Data_Origin, 
         TMP2.End_Date_Top, 
         CA.End_Date, 
         CA.reliability_percent, 
         CA.Start_Date, 
         CA.Seconds, 
         TRUNC(
         CASE 
         -- ********************************** 
         WHEN TMP2.measurement_type IN ('KWH-DEL','KWH-REC') 
          AND CA3.calc_value <> 0 
         THEN  
              (
               MAX(CA.calc_value) -- current AVG_KW or whatever configured to 
               - 
               MAX(CA2.calc_value) -- AVG_KW_30_DAY_ROLLING from last year 
              ) 
              / 
              MAX(CA3.calc_value) -- STDDEV_30_DAY_ROLLING from last year 
         -- ********************************** 
         WHEN TMP2.measurement_type IN ('KWH-DEL','KWH-REC') 
          AND CA3.calc_value = 0 
         THEN 0 
         -- ********************************** 
         ELSE NULL 
         END,6) AS Calc_Value 
         -- ********************************** 
        FROM 
                ( 
                SELECT
                 SC.* 
                FROM   grid.vw_calc_pending            SC 
                WHERE 
                     SC.Calc_Group = 'USAGE_SINGULAR' 
                 AND SC.Input_Location = 'GRID.USAGE' 
                 AND SC.Output_Location = 'GRID.CALC' 
                 AND SC.Dependency = true 
                 AND SC.Specific_Date_Needed = false 
                 AND SC.Calc_Function = 'Z_SCORE_VS_LAST_YEAR' 
                ORDER BY 
                 SC.UID_Group, 
                 SC.End_Date_Top, 
                 SC.Calc_Sequence 
                ) TMP2 
        INNER JOIN  grid.vw_calc                    CA 
         ON  CA.UID_Component = TMP2.UID_Component 
         AND CA.orig_measurement_type = TMP2.Measurement_Type 
         AND CA.End_Date = TMP2.End_Date_Top 
         AND CA.calc_function = TMP2.dependent_calc 
        INNER JOIN  grid.vw_calc                    CA2 
         ON  CA2.UID_Component = TMP2.UID_Component 
         AND CA2.orig_measurement_type = TMP2.Measurement_Type 
         AND CA2.End_Date = TMP2.End_Date_Top-CAST('365 day' AS INTERVAL) 
         AND CA2.calc_function = 'AVG_KW_30_DAY_ROLLING' 
        INNER JOIN  grid.vw_calc                    CA3 
         ON  CA3.UID_Component = TMP2.UID_Component 
         AND CA3.orig_measurement_type = TMP2.Measurement_Type 
         AND CA3.End_Date = TMP2.End_Date_Top-CAST('365 day' AS INTERVAL) 
         AND CA3.calc_function = 'STDDEV_30_DAY_ROLLING' 
        GROUP BY 
         TMP2.UID_Component, 
         TMP2.Calc_Function, 
         TMP2.Measurement_Type, 
         TMP2.Data_Origin, 
         TMP2.End_Date_Top, 
         CA.End_Date, 
         CA.reliability_percent, 
         CA.Start_Date,
         CA3.Calc_Value,
         CA.Seconds 
         ) TMP3 
INNER JOIN grid.component                 CP3 
 ON TMP3.UID_Component = CP3.UID_Component 
; 