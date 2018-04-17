CREATE OR REPLACE VIEW grid.vw_attribute_sp AS
    SELECT 
     ASP.* 
    FROM    grid.attribute_sp            ASP 
    WHERE
     ASP.update_date = 
                      (SELECT
                        MAX(ASP2.update_date) 
                       FROM    grid.attribute_sp            ASP2 
                       WHERE 
                            ASP2.UID_Component = ASP.UID_Component 
                      )
    ;