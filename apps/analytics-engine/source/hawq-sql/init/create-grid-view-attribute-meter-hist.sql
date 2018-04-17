CREATE OR REPLACE VIEW grid.vw_attribute_meter_hist AS
    SELECT 
     AMH.* 
    FROM    grid.attribute_meter_hist            AMH 
    WHERE
     AMH.update_date = 
                      (SELECT
                        MAX(AMH2.update_date) 
                       FROM    grid.attribute_meter_hist            AMH2 
                       WHERE 
                            AMH2.UID_Component = AMH.UID_Component 
                        AND AMH2.install_date = AMH.install_date 
                      )
    ;