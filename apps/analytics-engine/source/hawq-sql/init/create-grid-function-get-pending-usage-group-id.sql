CREATE OR REPLACE FUNCTION grid.getpendingusagegroupId() RETURNS BIGINT
AS $$
SELECT GT_VW.UID_Group 
 FROM   grid.vw_group_tracking GT_VW 
 WHERE  GT_VW.Group_Status = 'LOAD_PENDING' 
  AND   GT_VW.Related_Data = 'GRID.USAGE'
 LIMIT 1;
$$ 
LANGUAGE SQL;