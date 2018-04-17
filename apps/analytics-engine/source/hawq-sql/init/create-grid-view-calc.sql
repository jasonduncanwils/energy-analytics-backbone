CREATE OR REPLACE VIEW grid.vw_calc AS 
    SELECT 
     CA.* 
    FROM    grid.calc             CA 
    WHERE
     CA.update_date = 
                      (SELECT
                        MAX(CA2.update_date) 
                       FROM    grid.calc             CA2 
                       WHERE 
                            CA2.UID_Component = CA.UID_Component 
                        AND CA2.End_Date = CA.End_Date 
                        AND CA2.Orig_Measurement_Type = CA.Orig_Measurement_Type 
                        AND CA2.calc_function = CA.calc_function 
                      )
    ;