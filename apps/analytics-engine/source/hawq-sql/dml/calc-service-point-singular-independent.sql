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
 CASE 
 WHEN TMP3.Calc_Function    IN ('AVG_DAILY','AVG_DAILY_30_DAY_ROLLING') 
 THEN TMP3.Calc_Value / TMP3.Seconds  
 ELSE TMP3.Calc_Value 
 END AS Calc_Value, 
 TMP3.Seconds, 
 CAST(NULL AS TIMESTAMP) AS Occurance_Date 
FROM 
        ( 
        SELECT 
         TMP2.UID_Component, 
         TMP2.Calc_Function, 
         TMP2.Measurement_Type, 
         TMP2.Data_Origin, 
         TMP2.End_Date_Top AS End_Date, 
         AVG(100) AS Reliability_Percent,                             -- hardcoded for now 
         MIN(US.Start_Date) AS Start_Date, 
         SUM(US.Seconds) AS Seconds, 
         TRUNC(
         CASE 
         -- ********************************** 
         -- All UOM calculations 
         -- ********************************** 
         WHEN TMP2.Calc_Function    IN ('SUM','SUM_30_DAY_ROLLING') 
         THEN SUM(US.Usage_Value) 
         WHEN TMP2.Calc_Function    IN ('STDDEV','STDDEV_30_DAY_ROLLING') 
         THEN STDDEV(US.Usage_Value) 
         WHEN TMP2.Calc_Function    IN ('AVG_DAILY','AVG_DAILY_30_DAY_ROLLING') 
         THEN SUM(US.Usage_Value)
         -- ********************************** 
         -- KWH and kVARH specific calculations 
         -- ********************************** 
         WHEN TMP2.Measurement_Type IN ('KWH-DEL','KVARH-DEL') 
          AND TMP2.Calc_Function    IN ('AVG_KW','AVG_KW_30_DAY_ROLLING','AVG_KVAR','AVG_KVAR_30_DAY_ROLLING') 
         THEN AVG(US.Usage_Value)*(3600/MAX(US.Seconds)) 
         WHEN TMP2.Measurement_Type IN ('KWH-DEL','KVARH-DEL') 
          AND TMP2.Calc_Function    IN ('MAX_KW','MAX_KW_30_DAY_ROLLING','MAX_KVAR','MAX_KVAR_30_DAY_ROLLING') 
         THEN MAX(US.Usage_Value)*(3600/MAX(US.Seconds)) 
         WHEN TMP2.Measurement_Type IN ('KWH-DEL','KVARH-DEL') 
          AND TMP2.Calc_Function    IN ('MIN_KW','MIN_KW_30_DAY_ROLLING','MIN_KVAR','MIN_KVAR_30_DAY_ROLLING') 
         THEN MIN(US.Usage_Value)*(3600/MAX(US.Seconds)) 
         -- ********************************** 
         -- KW and KVAR specific calculations 
         -- ********************************** 
         WHEN TMP2.Measurement_Type IN ('KW-DEL','KVAR-DEL') 
          AND TMP2.Calc_Function    IN ('MAX_KW','MAX_KW_30_DAY_ROLLING','MAX_KVAR','MAX_KVAR_30_DAY_ROLLING') 
         THEN MAX(US.Usage_Value) 
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
                 AND SC.Dependency = false 
                 AND SC.Specific_Date_Needed = false 
                ORDER BY 
                 SC.UID_Group, 
                 SC.End_Date_Top, 
                 SC.Calc_Sequence 
                ) TMP2 
        INNER JOIN  grid.vw_usage                    US 
         ON  US.UID_Component = TMP2.UID_Component 
         AND US.Measurement_Type = TMP2.Measurement_Type 
         AND US.Data_Origin = TMP2.Data_Origin 
         AND US.End_Date <= 
                            CASE 
                            WHEN TMP2.Data_Origin IN ('DAILY_SCALAR','MONTHLY_SCALAR')
                            THEN TMP2.End_Date_Top + CAST('1 day' AS INTERVAL) - CAST('1 second' AS INTERVAL) 
                            ELSE TMP2.End_Date_Top 
                            END 
         AND US.End_Date > 
                            CASE 
                            WHEN TMP2.Data_Origin IN ('DAILY_SCALAR','MONTHLY_SCALAR')
                            THEN TMP2.End_Date_Bottom + CAST('1 day' AS INTERVAL) - CAST('1 second' AS INTERVAL) 
                            ELSE TMP2.End_Date_Bottom 
                            END 
         AND US.quality_code <> 'ESTIMATED' 
        GROUP BY 
         TMP2.UID_Component, 
         TMP2.Calc_Function, 
         TMP2.Measurement_Type, 
         TMP2.Data_Origin, 
         TMP2.End_Date_Top 
         ) TMP3 
INNER JOIN grid.component                 CP3 
 ON TMP3.UID_Component = CP3.UID_Component 
;