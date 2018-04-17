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
 TMP3.occurance_date AS Occurance_Date 
FROM 
        ( 
        SELECT 
         TMP2.UID_Component, 
         TMP2.Calc_Function, 
         TMP2.Measurement_Type, 
         TMP2.Data_Origin, 
         CA.End_Date, 
         CA.reliability_percent, 
         CA.Start_Date, 
         CA.Seconds, 
         CA.occurance_date, 
         TMP2.dependent_calc, 
         TRUNC(
         CASE 
         -- ********************************** 
         -- PF calculations 
         -- ********************************** 
         WHEN TMP2.Calc_Function    IN ('MAX_PF','MIN_PF') 
          AND TMP2.dependent_calc   IN ('MAX_KW','MIN_KW')
          AND TMP2.measurement_type = 'KVARH-DEL' 
          AND TMP2.Data_Origin      NOT IN ('DAILY_SCALAR','MONTHLY_SCALAR') 
         THEN  
              MAX(CA.calc_value) -- MAX_KW or MIN_KW 
              / 
              SQRT 
              ( 
                  POWER(MAX(CA.calc_value) , 2 ) -- MAX_KW or MIN_KW 
                  + 
                  POWER(MAX(US.usage_value)*(3600/MAX(US.Seconds)), 2 ) -- RELATED KVAR VALUE 
              ) 
         -- ********************************** 
         WHEN TMP2.Calc_Function    IN ('MAX_PF','MIN_PF') 
          AND TMP2.dependent_calc   IN ('MAX_KVAR','MIN_KVAR')
          AND TMP2.measurement_type = 'KWH-DEL' 
          AND TMP2.Data_Origin      NOT IN ('DAILY_SCALAR','MONTHLY_SCALAR') 
         THEN  
              MAX(US.usage_value)*(3600/MAX(US.Seconds)) -- RELATED KW VALUE 
              / 
              SQRT 
              ( 
                  POWER(MAX(US.usage_value)*(3600/MAX(US.Seconds)), 2 ) -- RELATED KW VALUE  
                  + 
                  POWER(MAX(CA.calc_value) , 2 ) -- MAX_KVAR or MIN_KVAR 
              ) 
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
                 AND SC.Specific_Date_Needed = true 
                ORDER BY 
                 SC.UID_Group, 
                 SC.End_Date_Top, 
                 SC.Calc_Sequence 
                ) TMP2 
        INNER JOIN  grid.vw_calc                     CA 
         ON  CA.UID_Component = TMP2.UID_Component 
         AND CA.calc_function = TMP2.dependent_calc 
         AND CA.End_Date = TMP2.End_Date_Top 
        INNER JOIN  grid.vw_usage                    US 
         ON  US.UID_Component = TMP2.UID_Component 
         AND US.Data_Origin = TMP2.Data_Origin 
         AND US.measurement_type = TMP2.measurement_type 
         AND US.End_Date = CA.occurance_date 
        GROUP BY 
         TMP2.UID_Component, 
         TMP2.Calc_Function, 
         TMP2.Measurement_Type, 
         TMP2.Data_Origin, 
         CA.End_Date, 
         CA.reliability_percent, 
         CA.Start_Date, 
         CA.Seconds, 
         CA.occurance_date, 
         TMP2.dependent_calc 
         ) TMP3 
INNER JOIN grid.component                 CP3 
 ON TMP3.UID_Component = CP3.UID_Component 
; 