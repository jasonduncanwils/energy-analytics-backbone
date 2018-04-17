CREATE OR REPLACE VIEW grid.vw_correlation_method AS 
SELECT 
 DISTINCT 
 CM.correlation_code, 
 CC.criticality_factor, 
 CM.confidence_factor 
FROM       grid.correlation_method             CM 
INNER JOIN grid.correlation_criticality        CC 
 ON CM.criticality_rank = CC.criticality_rank 
 ; 