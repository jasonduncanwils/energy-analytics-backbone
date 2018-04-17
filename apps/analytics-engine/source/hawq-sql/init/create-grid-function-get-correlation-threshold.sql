CREATE OR REPLACE FUNCTION grid.getcorrelationthreshold(text,text,text) 
RETURNS int 
AS $$
 SELECT 
  CMR.occurance_threshold 
 FROM       grid.correlation_method             CM 
 INNER JOIN grid.correlation_method_rule        CMR 
  ON CM.correlation_code = CMR.correlation_code 
 WHERE 
      CM.correlation_code = $1 
  AND CMR.rule_type = $2 
  AND CMR.rule = $3 
  ; 
$$ 
LANGUAGE SQL;