CREATE OR REPLACE VIEW grid.vw_usage AS
    SELECT 
     US.* 
    FROM    grid.usage            US 
    WHERE
     US.update_date = 
                      (SELECT
                        MAX(US2.update_date) 
                       FROM    grid.usage            US2 
                       WHERE 
                            US2.UID_Component = US.UID_Component 
                        AND US2.End_Date = US.End_Date 
                        AND US2.Measurement_Type = US.Measurement_Type 
                        AND US2.Data_Origin = US.Data_Origin
                      )
    ;