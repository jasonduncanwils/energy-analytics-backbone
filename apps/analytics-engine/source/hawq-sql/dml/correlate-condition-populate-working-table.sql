TRUNCATE grid.correlation_working; 

PREPARE correlation_work(timestamp) AS 

INSERT INTO grid.correlation_working 
SELECT 
 TMP2.uid_component, 
 TMP2.comp_type, 
 TMP2.end_date, 
 grid.CombineThreeArrays(
  ARRAY(
   SELECT 
    CC2.condition_code
   FROM       grid.condition                    CD2 
   INNER JOIN grid.condition_code               CC2 
    ON CC2.condition_code = CD2.condition_code
   WHERE 
        CD2.uid_component = TMP2.uid_component
    AND CD2.end_date <= TMP2.end_date 
    AND CD2.end_date >= TMP2.end_date-CAST(CC2.days_valid||' day' AS INTERVAL) 
   GROUP BY 
    CC2.condition_code, 
    CC2.condition_group 
   ORDER BY 
    CC2.condition_code, 
    CC2.condition_group 
  ),
  ARRAY(
   SELECT 
    CC2.condition_group 
   FROM       grid.condition                    CD2 
   INNER JOIN grid.condition_code               CC2 
    ON CC2.condition_code = CD2.condition_code
   WHERE 
        CD2.uid_component = TMP2.uid_component
    AND CD2.end_date <= TMP2.end_date 
    AND CD2.end_date >= TMP2.end_date-CAST(CC2.days_valid||' day' AS INTERVAL) 
   GROUP BY 
    CC2.condition_code, 
    CC2.condition_group 
   ORDER BY 
    CC2.condition_code, 
    CC2.condition_group 
  ),
  ARRAY(
   SELECT 
    CAST(COUNT(CD2.*) AS TEXT)
   FROM       grid.condition                    CD2 
   INNER JOIN grid.condition_code               CC2 
    ON CC2.condition_code = CD2.condition_code
   WHERE 
        CD2.uid_component = TMP2.uid_component
    AND CD2.end_date <= TMP2.end_date 
    AND CD2.end_date >= TMP2.end_date-CAST(CC2.days_valid||' day' AS INTERVAL) 
   GROUP BY 
    CC2.condition_code, 
    CC2.condition_group 
   ORDER BY 
    CC2.condition_code, 
    CC2.condition_group 
  )
  )AS condition_code_array 
FROM   (
        SELECT 
         CD.uid_component, 
         CD.comp_type, 
         TMP1.end_date 
        FROM 
                (
                 SELECT 
                  CC.condition_code, 
                  CC.days_valid, 
                  $1 AS end_Date 
                 FROM    grid.condition_code             CC 
                ) TMP1 
        INNER JOIN grid.condition                 CD 
         ON  CD.condition_code = TMP1.condition_code 
         AND CD.end_date <= TMP1.end_date 
         AND CD.end_date >= TMP1.end_date-CAST(TMP1.days_valid||' day' AS INTERVAL) 
        GROUP BY  
         CD.uid_component, 
         CD.comp_type, 
         TMP1.end_date 
       ) TMP2 
; 

EXECUTE correlation_work(grid.getgroupidmaxdate('GRID.USAGE','DETECTION_COMPLETE'));

DEALLOCATE correlation_work;