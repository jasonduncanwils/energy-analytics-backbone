CREATE OR REPLACE VIEW grid.vw_attribute_connection_hist AS
    SELECT 
     ACH.* 
    FROM    grid.attribute_connection_hist            ACH 
    WHERE
     ACH.update_date = 
                      (SELECT
                        MAX(ACH2.update_date) 
                       FROM    grid.attribute_connection_hist            ACH2 
                       WHERE 
                            ACH2.UID_Component = ACH.UID_Component 
                        AND ACH2.connection_date = ACH.connection_date 
                      )
    ;