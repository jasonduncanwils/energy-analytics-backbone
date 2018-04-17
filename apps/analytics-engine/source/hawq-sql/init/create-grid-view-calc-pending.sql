CREATE OR REPLACE VIEW grid.vw_calc_pending AS 
SELECT 
 TMP1.UID_Group, 
 CM.Calc_Sequence, 
 CP.UID_Component, 
 CMF.Calc_Function, 
 CMF.Measurement_Type, 
 TMP1.End_Date             AS End_Date_Top, 
 TMP1.End_Date-CAST(CMF.Calc_Trailing_Days||' day' AS INTERVAL) AS End_Date_Bottom, 
 CM.Data_Origin, 
 CM.Calc_Group, 
 CM.Input_Location, 
 CM.Output_Location, 
 CMF.Specific_Date_Needed, 
 CMF.Dependency, 
 CMF.dependent_calc 
FROM       ( 
            SELECT 
             GT.UID_Group, 
             US.UID_Component, 
             -- this section is grouping usage from a day into the end of the day 
             -- for interval and into the beginning of a day for scalar  
             CASE 
             WHEN US.data_origin NOT IN ('DAILY_SCALAR','MONTHLY_SCALAR') 
              OR  date_trunc('day',US.Start_Date) = date_trunc('day',US.End_Date)
             THEN date_trunc('day',US.End_Date-CAST('1 second' AS INTERVAL)) 
                  +CAST('1 day' AS INTERVAL) 
             ELSE date_trunc('day',US.End_Date) 
             END                AS End_Date, 
             MAX(UP.priority) AS Priority 
            FROM        grid.group_tracking            GT 
            INNER JOIN  grid.usage                     US 
             ON  GT.UID_Group = US.UID_Group 
            INNER JOIN  grid.usage_priority            UP 
             ON  US.data_origin = UP.data_origin
            WHERE 
                 GT.Group_Status = 'LOAD_PENDING' 
             AND US.quality_code <> 'ESTIMATED' 
             AND NOT EXISTS (SELECT * 
                             FROM   grid.group_tracking 
                             WHERE  
                                  uid_group = GT.uid_group 
                              AND group_status = 'CALC_COMPLETE' 
                            ) 
            GROUP BY 
             GT.UID_Group, 
             US.UID_Component, 
             CASE 
             WHEN US.data_origin NOT IN ('DAILY_SCALAR','MONTHLY_SCALAR') 
              OR  date_trunc('day',US.Start_Date) = date_trunc('day',US.End_Date)
             THEN date_trunc('day',US.End_Date-CAST('1 second' AS INTERVAL)) 
                  +CAST('1 day' AS INTERVAL) 
             ELSE date_trunc('day',US.End_Date) 
             END 
           ) TMP1 
INNER JOIN  grid.component                 CP 
 ON  TMP1.UID_Component = CP.UID_Component 
INNER JOIN  grid.usage_priority            UP 
 ON  TMP1.Priority = UP.Priority 
INNER JOIN  grid.calc_method               CM 
 ON  CP.Comp_Type = CM.Comp_Type 
 AND UP.Data_Origin = CM.Data_Origin 
INNER JOIN  grid.calc_method_func          CMF 
 ON  CM.Calc_Method = CMF.Calc_Method   
GROUP BY  
 TMP1.UID_Group, 
 CM.Calc_Sequence,  
 CP.UID_Component, 
 CMF.Calc_Function, 
 CMF.Measurement_Type, 
 TMP1.End_Date, 
 TMP1.End_Date-CAST(CMF.Calc_Trailing_Days||' day' AS INTERVAL), 
 CM.Data_Origin, 
 CM.Calc_Group, 
 CM.Input_Location, 
 CM.Output_Location, 
 CMF.Specific_Date_Needed, 
 CMF.Dependency, 
 CMF.dependent_calc 
 ; 