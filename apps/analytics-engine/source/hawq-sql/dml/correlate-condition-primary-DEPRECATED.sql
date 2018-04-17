INSERT INTO grid.correlation 
SELECT 
 TMP3.uid_component, 
 CP.component_id, 
 CP.comp_source_system, 
 CP.comp_type, 
 TMP3.correlation_code, 
 TMP3.end_date, 
 (TMP3.criticality_factor*TMP3.confidence_factor) AS priority_score, 
 TMP3.condition_code_array, 
 CURRENT_TIMESTAMP 
FROM   (
        SELECT 
         TMP1.uid_component, 
         TMP2.correlation_code, 
         TMP1.end_date, 
         TMP2.criticality_factor, 
         TMP2.confidence_factor, 
         TMP1.condition_code_array, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_1 = 'CONDITION_CODE' AND TMP1.condition_code_instance = TMP2.rule_1 
         THEN TMP1.condition_code_instance END                         AS condition_code_1, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_1 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_1 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS condition_count_1, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_1 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_1 
         THEN TMP2.occurance_threshold_1 END, 0)                       AS condition_threshold_1, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_2 = 'CONDITION_CODE' AND TMP1.condition_code_instance = TMP2.rule_2 
         THEN TMP1.condition_code_instance END                         AS condition_code_2, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_2 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_2 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS condition_count_2, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_2 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_2 
         THEN TMP2.occurance_threshold_2 END, 0)                       AS condition_threshold_2, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_3 = 'CONDITION_CODE' AND TMP1.condition_code_instance = TMP2.rule_3 
         THEN TMP1.condition_code_instance END                         AS condition_code_3, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_3 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_3 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS condition_count_3, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_3 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_3 
         THEN TMP2.occurance_threshold_3 END, 0)                       AS condition_threshold_3, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_4 = 'CONDITION_CODE' AND TMP1.condition_code_instance = TMP2.rule_4 
         THEN TMP1.condition_code_instance END                         AS condition_code_4, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_4 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_4 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS condition_count_4, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_4 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_4 
         THEN TMP2.occurance_threshold_4 END, 0)                       AS condition_threshold_4, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_5 = 'CONDITION_CODE' AND TMP1.condition_code_instance = TMP2.rule_5 
         THEN TMP1.condition_code_instance END                         AS condition_code_5, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_5 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_5 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS condition_count_5, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_5 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_5 
         THEN TMP2.occurance_threshold_5 END, 0)                       AS condition_threshold_5, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_6 = 'CONDITION_CODE' AND TMP1.condition_code_instance = TMP2.rule_6 
         THEN TMP1.condition_code_instance END                         AS condition_code_6, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_6 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_6 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS condition_count_6, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_6 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_6 
         THEN TMP2.occurance_threshold_6 END, 0)                       AS condition_threshold_6, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_7 = 'CONDITION_CODE' AND TMP1.condition_code_instance = TMP2.rule_7 
         THEN TMP1.condition_code_instance END                         AS condition_code_7, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_7 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_7 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS condition_count_7, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_7 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_7 
         THEN TMP2.occurance_threshold_7 END, 0)                       AS condition_threshold_7, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_8 = 'CONDITION_CODE' AND TMP1.condition_code_instance = TMP2.rule_8 
         THEN TMP1.condition_code_instance END                         AS condition_code_8, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_8 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_8 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS condition_count_8, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_8 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_8 
         THEN TMP2.occurance_threshold_8 END, 0)                       AS condition_threshold_8, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_9 = 'CONDITION_CODE' AND TMP1.condition_code_instance = TMP2.rule_9 
         THEN TMP1.condition_code_instance END                         AS condition_code_9, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_9 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_9 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS condition_count_9, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_9 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_9 
         THEN TMP2.occurance_threshold_9 END, 0)                       AS condition_threshold_9, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_10 = 'CONDITION_CODE' AND TMP1.condition_code_instance = TMP2.rule_10 
         THEN TMP1.condition_code_instance END                         AS condition_code_10, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_10 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_10 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS condition_count_10, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_10 = 'CONDITION_CODE'  AND TMP1.condition_code_instance = TMP2.rule_10 
         THEN TMP2.occurance_threshold_10 END, 0)                      AS condition_threshold_10, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_1 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_1 
         THEN TMP1.condition_group END                                  AS group_1, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_1 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_1 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS group_count_1, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_1 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_1 
         THEN TMP2.occurance_threshold_1 END, 0)                       AS group_threshold_1, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_2 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_2 
         THEN TMP1.condition_group END                                  AS group_2, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_2 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_2 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS group_count_2, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_2 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_2 
         THEN TMP2.occurance_threshold_2 END, 0)                       AS group_threshold_2, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_3 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_3 
         THEN TMP1.condition_group END                                  AS group_3, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_3 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_3 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS group_count_3, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_3 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_3 
         THEN TMP2.occurance_threshold_3 END, 0)                       AS group_threshold_3, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_4 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_4 
         THEN TMP1.condition_group END                                  AS group_4, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_4 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_4 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS group_count_4, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_4 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_4 
         THEN TMP2.occurance_threshold_4 END, 0)                       AS group_threshold_4, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_5 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_5 
         THEN TMP1.condition_group END                                  AS group_5, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_5 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_5 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS group_count_5, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_5 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_5 
         THEN TMP2.occurance_threshold_5 END, 0)                       AS group_threshold_5, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_6 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_6 
         THEN TMP1.condition_group END                                  AS group_6, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_6 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_6 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS group_count_6, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_6 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_6 
         THEN TMP2.occurance_threshold_6 END, 0)                       AS group_threshold_6, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_7 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_7 
         THEN TMP1.condition_group END                                  AS group_7, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_7 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_7 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS group_count_7, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_7 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_7 
         THEN TMP2.occurance_threshold_7 END, 0)                       AS group_threshold_7, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_8 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_8 
         THEN TMP1.condition_group END                                  AS group_8, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_8 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_8 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS group_count_8, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_8 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_8 
         THEN TMP2.occurance_threshold_8 END, 0)                       AS group_threshold_8, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_9 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_9 
         THEN TMP1.condition_group END                                  AS group_9, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_9 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_9 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS group_count_9, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_9 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_9 
         THEN TMP2.occurance_threshold_9 END, 0)                       AS group_threshold_9, 
         -- ********************************** 
         CASE 
         WHEN TMP2.rule_type_10 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_10 
         THEN TMP1.condition_group END                                  AS group_10, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_10 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_10 
         THEN COUNT(TMP1.condition_code_instance) END, 0)              AS group_count_10, 
         COALESCE( 
         CASE 
         WHEN TMP2.rule_type_10 = 'CONDITION_GROUP' AND TMP1.condition_group = TMP2.rule_10 
         THEN TMP2.occurance_threshold_10 END, 0)                      AS group_threshold_10 
        FROM 
                ( 
                 SELECT
                  TMP.*, 
                  CC2.condition_group 
                 FROM   ( 
                         SELECT 
                          CW.uid_component, 
                          CW.comp_type, 
                          CW.end_date, 
                          CW.condition_code_array, 
                          unnest(cw.condition_code_array) AS condition_code_instance 
                         FROM       grid.correlation_working            CW 
                         GROUP BY 
                          CW.uid_component, 
                          CW.comp_type, 
                          CW.end_date, 
                          CW.condition_code_array 
                        ) TMP 
                 INNER JOIN grid.condition_code                 CC2 
                  ON TMP.condition_code_instance = CC2.condition_code 
                ) TMP1, 
                (
                 SELECT 
                  DISTINCT 
                  CM.correlation_code, 
                  CM.comp_type, 
                  CC.criticality_factor, 
                  CM.confidence_factor, 
                  -- ********************************** 
                  CASE WHEN CMR.condition_sequence = 1  THEN CMR.rule_type           END AS rule_type_1, 
                  CASE WHEN CMR.condition_sequence = 1  THEN CMR.rule                END AS rule_1, 
                  CASE WHEN CMR.condition_sequence = 1  THEN CMR.occurance_threshold END AS occurance_threshold_1, 
                  -- ********************************** 
                  CASE WHEN CMR.condition_sequence = 2  THEN CMR.rule_type           END AS rule_type_2, 
                  CASE WHEN CMR.condition_sequence = 2  THEN CMR.rule                END AS rule_2, 
                  CASE WHEN CMR.condition_sequence = 2  THEN CMR.occurance_threshold END AS occurance_threshold_2, 
                  -- ********************************** 
                  CASE WHEN CMR.condition_sequence = 3  THEN CMR.rule_type           END AS rule_type_3, 
                  CASE WHEN CMR.condition_sequence = 3  THEN CMR.rule                END AS rule_3, 
                  CASE WHEN CMR.condition_sequence = 3  THEN CMR.occurance_threshold END AS occurance_threshold_3, 
                  -- ********************************** 
                  CASE WHEN CMR.condition_sequence = 4  THEN CMR.rule_type           END AS rule_type_4, 
                  CASE WHEN CMR.condition_sequence = 4  THEN CMR.rule                END AS rule_4, 
                  CASE WHEN CMR.condition_sequence = 4  THEN CMR.occurance_threshold END AS occurance_threshold_4, 
                  -- ********************************** 
                  CASE WHEN CMR.condition_sequence = 5  THEN CMR.rule_type           END AS rule_type_5, 
                  CASE WHEN CMR.condition_sequence = 5  THEN CMR.rule                END AS rule_5, 
                  CASE WHEN CMR.condition_sequence = 5  THEN CMR.occurance_threshold END AS occurance_threshold_5, 
                  -- ********************************** 
                  CASE WHEN CMR.condition_sequence = 6  THEN CMR.rule_type           END AS rule_type_6, 
                  CASE WHEN CMR.condition_sequence = 6  THEN CMR.rule                END AS rule_6, 
                  CASE WHEN CMR.condition_sequence = 6  THEN CMR.occurance_threshold END AS occurance_threshold_6, 
                  -- ********************************** 
                  CASE WHEN CMR.condition_sequence = 7  THEN CMR.rule_type           END AS rule_type_7, 
                  CASE WHEN CMR.condition_sequence = 7  THEN CMR.rule                END AS rule_7, 
                  CASE WHEN CMR.condition_sequence = 7  THEN CMR.occurance_threshold END AS occurance_threshold_7, 
                  -- ********************************** 
                  CASE WHEN CMR.condition_sequence = 8  THEN CMR.rule_type           END AS rule_type_8, 
                  CASE WHEN CMR.condition_sequence = 8  THEN CMR.rule                END AS rule_8, 
                  CASE WHEN CMR.condition_sequence = 8  THEN CMR.occurance_threshold END AS occurance_threshold_8, 
                  -- ********************************** 
                  CASE WHEN CMR.condition_sequence = 9  THEN CMR.rule_type           END AS rule_type_9, 
                  CASE WHEN CMR.condition_sequence = 9  THEN CMR.rule                END AS rule_9, 
                  CASE WHEN CMR.condition_sequence = 9  THEN CMR.occurance_threshold END AS occurance_threshold_9, 
                  -- ********************************** 
                  CASE WHEN CMR.condition_sequence = 10 THEN CMR.rule_type           END AS rule_type_10, 
                  CASE WHEN CMR.condition_sequence = 10 THEN CMR.rule                END AS rule_10, 
                  CASE WHEN CMR.condition_sequence = 10 THEN CMR.occurance_threshold END AS occurance_threshold_10 
                 FROM       grid.correlation_method             CM 
                 INNER JOIN grid.correlation_method_rule        CMR 
                  ON CM.correlation_code = CMR.correlation_code 
                 INNER JOIN grid.correlation_criticality        CC 
                  ON CM.criticality_rank = CC.criticality_rank 
                ) TMP2 
        WHERE 
         TMP1.comp_type = TMP2.comp_type 
        GROUP BY 
         TMP1.uid_component, 
         TMP2.correlation_code, 
         TMP1.end_date, 
         TMP2.criticality_factor, 
         TMP2.confidence_factor, 
         TMP1.condition_code_array, 
         TMP1.condition_group, 
         TMP1.condition_code_instance, 
         TMP2.rule_type_1, 
         TMP2.rule_1, 
         TMP2.occurance_threshold_1, 
         TMP2.rule_type_2, 
         TMP2.rule_2, 
         TMP2.occurance_threshold_2, 
         TMP2.rule_type_3, 
         TMP2.rule_3, 
         TMP2.occurance_threshold_3, 
         TMP2.rule_type_4, 
         TMP2.rule_4, 
         TMP2.occurance_threshold_4, 
         TMP2.rule_type_5, 
         TMP2.rule_5, 
         TMP2.occurance_threshold_5, 
         TMP2.rule_type_6, 
         TMP2.rule_6, 
         TMP2.occurance_threshold_6, 
         TMP2.rule_type_7, 
         TMP2.rule_7, 
         TMP2.occurance_threshold_7, 
         TMP2.rule_type_8, 
         TMP2.rule_8, 
         TMP2.occurance_threshold_8, 
         TMP2.rule_type_9, 
         TMP2.rule_9, 
         TMP2.occurance_threshold_9, 
         TMP2.rule_type_10, 
         TMP2.rule_10, 
         TMP2.occurance_threshold_10 
       ) TMP3 
INNER JOIN    grid.component               CP 
 ON TMP3.uid_component = CP.uid_component 
WHERE 
     TMP3.condition_count_1  >= TMP3.condition_threshold_1 
 AND TMP3.condition_count_2  >= TMP3.condition_threshold_2 
 AND TMP3.condition_count_2  >= TMP3.condition_threshold_2 
 AND TMP3.condition_count_3  >= TMP3.condition_threshold_3 
 AND TMP3.condition_count_4  >= TMP3.condition_threshold_4 
 AND TMP3.condition_count_5  >= TMP3.condition_threshold_5 
 AND TMP3.condition_count_6  >= TMP3.condition_threshold_6  
 AND TMP3.condition_count_7  >= TMP3.condition_threshold_7 
 AND TMP3.condition_count_8  >= TMP3.condition_threshold_8 
 AND TMP3.condition_count_9  >= TMP3.condition_threshold_9 
 AND TMP3.condition_count_10 >= TMP3.condition_threshold_10 
 AND TMP3.group_count_1      >= TMP3.group_threshold_1 
 AND TMP3.group_count_2      >= TMP3.group_threshold_2 
 AND TMP3.group_count_3      >= TMP3.group_threshold_3 
 AND TMP3.group_count_4      >= TMP3.group_threshold_4 
 AND TMP3.group_count_5      >= TMP3.group_threshold_5 
 AND TMP3.group_count_6      >= TMP3.group_threshold_6 
 AND TMP3.group_count_7      >= TMP3.group_threshold_7 
 AND TMP3.group_count_8      >= TMP3.group_threshold_8 
 AND TMP3.group_count_9      >= TMP3.group_threshold_9 
 AND TMP3.group_count_10     >= TMP3.group_threshold_10 
; 