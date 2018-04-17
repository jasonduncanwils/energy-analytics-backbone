CREATE OR REPLACE VIEW grid.vw_alert AS
    SELECT 
     AL.* 
    FROM    grid.alert            AL 
    ;