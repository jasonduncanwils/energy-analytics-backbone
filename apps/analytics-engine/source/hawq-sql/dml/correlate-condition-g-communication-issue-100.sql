PREPARE correlation_instance(text,integer) AS 

INSERT INTO grid.correlation 
SELECT 
 TMP1.uid_component, 
 CP.component_id, 
 CP.comp_source_system, 
 CP.comp_type, 
 TMP2.correlation_code, 
 TMP1.end_date, 
 (TMP2.criticality_factor*TMP2.confidence_factor) AS priority_score, 
 TMP1.condition_array, 
 CURRENT_TIMESTAMP 
FROM   ( 
        SELECT     * 
        FROM       grid.vw_correlation_working         CW 
       ) TMP1, 
       (
        SELECT     * 
        FROM       grid.vw_correlation_method          CM 
        WHERE 
         CM.correlation_code = 'G_COMMUNICATION_ISSUE_100'
       ) TMP2, 
       grid.component               CP 
WHERE 
    TMP1.uid_component = CP.uid_component 
AND grid.contains_condition_code(TMP1.condition_array, $1, $2) 
 ; 

EXECUTE correlation_instance('MISSING_USAGE_EXTENDED',
                             grid.getCorrelationThreshold('G_COMMUNICATION_ISSUE_100',
                                                          'CONDITION_CODE',
                                                          'MISSING_USAGE_EXTENDED')
                            );

DEALLOCATE correlation_instance;