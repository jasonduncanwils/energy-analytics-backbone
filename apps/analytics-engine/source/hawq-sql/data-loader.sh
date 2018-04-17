cd /
echo "********************************************"
echo "Zip up files loaded to directory that are not zipped yet"
echo "********************************************"

gzip -r mnt/hgfs/grid-mount/usage/*.txt
gzip -r mnt/hgfs/grid-mount/usage/*.csv
gzip -r mnt/hgfs/grid-mount/alerts/*.txt
gzip -r mnt/hgfs/grid-mount/alerts/*.csv
gzip -r mnt/hgfs/grid-mount/attributes/attribute-sp/*.txt
gzip -r mnt/hgfs/grid-mount/attributes/attribute-sp/*.csv
gzip -r mnt/hgfs/grid-mount/attributes/attribute-meter-hist/*.txt
gzip -r mnt/hgfs/grid-mount/attributes/attribute-meter-hist/*.csv
gzip -r mnt/hgfs/grid-mount/attributes/attribute-connection-hist/*.txt
gzip -r mnt/hgfs/grid-mount/attributes/attribute-connection-hist/*.csv

# !!!!!!!!!!!!!!!!!!! TO DO: we need to add in file by file processing here with logic 
# !!!!!!!!!!!!!!!!!!! to send them to error directory if they fail 

echo "********************************************"
echo "Load data into HAWQ tables"
echo "********************************************"

zcat mnt/hgfs/grid-mount/usage/*.csv.gz | psql -c "COPY grid.stage_usage FROM STDIN DELIMITER E',' NULL E'';"
zcat mnt/hgfs/grid-mount/alerts/*.csv.gz | psql -c "COPY grid.stage_alert FROM STDIN DELIMITER E',' NULL E'';"
zcat mnt/hgfs/grid-mount/attributes/attribute-sp/*.csv.gz | psql -c "COPY grid.stage_attribute_sp FROM STDIN DELIMITER E',' NULL E'';"
zcat mnt/hgfs/grid-mount/attributes/attribute-meter-hist/*.csv.gz | psql -c "COPY grid.stage_attribute_meter_hist FROM STDIN DELIMITER E',' NULL E'';"
zcat mnt/hgfs/grid-mount/attributes/attribute-connection-hist/*.csv.gz | psql -c "COPY grid.stage_attribute_connection_hist FROM STDIN DELIMITER E',' NULL E'';"

zcat mnt/hgfs/grid-mount/usage/*.txt.gz | psql -c "COPY grid.stage_usage FROM STDIN DELIMITER E'\t' NULL E'';"
zcat mnt/hgfs/grid-mount/alerts/*.txt.gz | psql -c "COPY grid.stage_alert FROM STDIN DELIMITER E'\t' NULL E'';"
zcat mnt/hgfs/grid-mount/attributes/attribute-sp/*.txt.gz | psql -c "COPY grid.stage_attribute_sp FROM STDIN DELIMITER E'\t' NULL E'';"
zcat mnt/hgfs/grid-mount/attributes/attribute-meter-hist/*.txt.gz | psql -c "COPY grid.stage_attribute_meter_hist FROM STDIN DELIMITER E'\t' NULL E'';"
zcat mnt/hgfs/grid-mount/attributes/attribute-connection-hist/*.txt.gz | psql -c "COPY grid.stage_attribute_connection_hist FROM STDIN DELIMITER E'\t' NULL E'';"

echo "********************************************"
echo "Move all processed files to appropriate archive folder"
echo "********************************************"

#mv mnt/hgfs/grid-mount/usage/*.gz mnt/hgfs/grid-mount/usage/archive
#mv mnt/hgfs/grid-mount/alerts/*.gz mnt/hgfs/grid-mount/alerts/archive
#mv mnt/hgfs/grid-mount/attributes/attribute-sp/*.gz mnt/hgfs/grid-mount/attributes/attribute-sp/archive
#mv mnt/hgfs/grid-mount/attributes/attribute-meter-hist/*.gz mnt/hgfs/grid-mount/attributes/attribute-meter-hist/archive
#mv mnt/hgfs/grid-mount/attributes/attribute-connection-hist/*.gz mnt/hgfs/grid-mount/attributes/attribute-connection-hist/archive

cd ~

echo "********************************************"
echo "Move data from stage tables to primary tables"
echo "********************************************"

psql -c "

-- **************************************** 
-- Assign UIDs to any new components 
-- **************************************** 

INSERT INTO grid.component 
SELECT 
 NEXTVAL('grid.SEQ_UID_Component'), 
 TMP1.Component_ID, 
 TMP1.Comp_Source_System, 
 TMP1.Comp_Type 
FROM   ( 
        SELECT 
         DISTINCT 
         ST.Component_ID, 
         ST.Comp_Source_System, 
         ST.Comp_Type 
        FROM   grid.stage_usage                   ST 
        EXCEPT  
        SELECT 
         DISTINCT 
         CP.Component_ID, 
         CP.Comp_Source_System, 
         CP.Comp_Type 
        FROM  grid.component                      CP 
       ) TMP1 
; 

INSERT INTO grid.component 
SELECT 
 NEXTVAL('grid.SEQ_UID_Component'), 
 TMP1.Component_ID, 
 TMP1.Comp_Source_System, 
 TMP1.Comp_Type 
FROM   ( 
        SELECT 
         DISTINCT 
         ST.Component_ID, 
         ST.Comp_Source_System, 
         ST.Comp_Type 
        FROM   grid.stage_alert                   ST 
        EXCEPT  
        SELECT 
         DISTINCT 
         CP.Component_ID, 
         CP.Comp_Source_System, 
         CP.Comp_Type 
        FROM  grid.component                      CP 
       ) TMP1 
; 

INSERT INTO grid.component 
SELECT 
 NEXTVAL('grid.SEQ_UID_Component'), 
 TMP1.Component_ID, 
 TMP1.Comp_Source_System, 
 TMP1.Comp_Type 
FROM   ( 
        SELECT 
         DISTINCT 
         ST.Component_ID, 
         ST.Comp_Source_System, 
         ST.Comp_Type 
        FROM   grid.stage_attribute_sp            ST 
        EXCEPT  
        SELECT 
         DISTINCT 
         CP.Component_ID, 
         CP.Comp_Source_System, 
         CP.Comp_Type 
        FROM  grid.component                      CP 
       ) TMP1 
; 

INSERT INTO grid.component 
SELECT 
 NEXTVAL('grid.SEQ_UID_Component'), 
 TMP1.Component_ID, 
 TMP1.Comp_Source_System, 
 TMP1.Comp_Type 
FROM   ( 
        SELECT 
         DISTINCT 
         ST.Component_ID, 
         ST.Comp_Source_System, 
         ST.Comp_Type 
        FROM   grid.stage_attribute_meter_hist    ST 
        EXCEPT  
        SELECT 
         DISTINCT 
         CP.Component_ID, 
         CP.Comp_Source_System, 
         CP.Comp_Type 
        FROM  grid.component                      CP 
       ) TMP1 
; 

INSERT INTO grid.component 
SELECT 
 NEXTVAL('grid.SEQ_UID_Component'), 
 TMP1.Component_ID, 
 TMP1.Comp_Source_System, 
 TMP1.Comp_Type 
FROM   ( 
        SELECT 
         DISTINCT 
         ST.Component_ID, 
         ST.Comp_Source_System, 
         ST.Comp_Type 
        FROM   grid.stage_attribute_connection_hist   ST 
        EXCEPT  
        SELECT 
         DISTINCT 
         CP.Component_ID, 
         CP.Comp_Source_System, 
         CP.Comp_Type 
        FROM  grid.component                      CP 
       ) TMP1 
; 

-- **************************************** 
--  Move stage_attribute_sp to attribute_sp 
-- **************************************** 

INSERT INTO grid.attribute_sp 
SELECT 
 CP.UID_Component, 
 ST.* 
FROM        grid.stage_attribute_sp               ST 
INNER JOIN  grid.component                        CP 
 ON  ST.Component_ID = CP.Component_ID 
 AND ST.Comp_Source_System = CP.Comp_Source_System 
 AND ST.Comp_Type = CP.Comp_Type 
; 

-- **************************************** 
--  Move stage_attribute_meter_hist to attribute_meter_hist 
-- **************************************** 

INSERT INTO grid.attribute_meter_hist 
SELECT 
 CP.UID_Component, 
 ST.* 
FROM        grid.stage_attribute_meter_hist       ST 
INNER JOIN  grid.component                        CP 
 ON  ST.Component_ID = CP.Component_ID 
 AND ST.Comp_Source_System = CP.Comp_Source_System 
 AND ST.Comp_Type = CP.Comp_Type 
; 

-- **************************************** 
--  Move stage_attribute_connection_hist to attribute_connection_hist 
-- **************************************** 

INSERT INTO grid.attribute_connection_hist 
SELECT 
 CP.UID_Component, 
 ST.* 
FROM        grid.stage_attribute_connection_hist  ST 
INNER JOIN  grid.component                        CP 
 ON  ST.Component_ID = CP.Component_ID 
 AND ST.Comp_Source_System = CP.Comp_Source_System 
 AND ST.Comp_Type = CP.Comp_Type 
; 

-- **************************************** 
-- Assign a group ID for this new usage data 
-- **************************************** 

INSERT INTO grid.group_tracking 
SELECT 
 NEXTVAL('grid.SEQ_UID_Group'), 
 'LOAD_PENDING', 
 'GRID.USAGE', 
 MAX(ST.End_Date) 
FROM grid.stage_usage                      ST 
; 

-- **************************************** 
--  Move stage_usage to usage 
-- **************************************** 

INSERT INTO grid.usage 
SELECT 
 CP.UID_Component, 
 -- This can be replaced once in Java with an in-memory variable 
 ( 
 SELECT MAX(GT.UID_Group) 
 FROM   grid.group_tracking           GT 
 WHERE  GT.Group_Status = 'LOAD_PENDING' 
  AND   GT.Related_Data = 'GRID.USAGE' 
 ), 
 ST.* 
FROM        grid.stage_usage                      ST 
INNER JOIN  grid.component                        CP 
 ON  ST.Component_ID = CP.Component_ID 
 AND ST.Comp_Source_System = CP.Comp_Source_System 
 AND ST.Comp_Type = CP.Comp_Type 
WHERE 
 ST.Comp_Type NOT IN ('METER_ELEC','METER_GAS') 
; 

INSERT INTO grid.usage 
SELECT 
 CASE 
 WHEN AMH.UID_Component IS NOT NULL 
 THEN AMH.UID_Component 
 ELSE CP.UID_Component 
 END, 
 -- This can be replaced once in Java with an in-memory variable 
 ( 
 SELECT MAX(GT.UID_Group) 
 FROM   grid.group_tracking           GT 
 WHERE  GT.Group_Status = 'LOAD_PENDING' 
  AND   GT.Related_Data = 'GRID.USAGE' 
 ), 
 ST.update_date, 
 CASE 
 WHEN AMH.UID_Component IS NOT NULL 
 THEN AMH.component_id 
 ELSE CP.component_id 
 END, 
 CASE 
 WHEN AMH.UID_Component IS NOT NULL 
 THEN AMH.comp_source_system 
 ELSE CP.comp_source_system 
 END, 
 CASE 
 WHEN AMH.UID_Component IS NOT NULL 
 THEN AMH.comp_type 
 ELSE CP.comp_type 
 END, 
 ST.measurement_type, 
 ST.start_date, 
 ST.end_date, 
 ST.usage_value, 
 ST.seconds, 
 ST.multiplier, 
 ST.data_origin, 
 ST.quality_code 
FROM        grid.stage_usage                      ST 
INNER JOIN  grid.component                        CP 
 ON  ST.Component_ID = CP.Component_ID 
 AND ST.Comp_Source_System = CP.Comp_Source_System 
 AND ST.Comp_Type = CP.Comp_Type 
INNER JOIN  grid.vw_attribute_meter_hist          AMH 
 ON  AMH.meter_id = ST.component_id 
 AND AMH.meter_source_system = ST.comp_source_system 
 AND AMH.comp_type = ST.comp_type 
 AND ST.end_date > amh.install_date 
 AND (    ST.end_date <= amh.remove_date 
	  or  amh.remove_date is null) 
WHERE 
 ST.Comp_Type IN ('METER_ELEC','METER_GAS') 
; 

-- **************************************** 
-- Assign a group ID for this new alert data 
-- **************************************** 

INSERT INTO grid.group_tracking 
SELECT 
 NEXTVAL('grid.SEQ_UID_Group'), 
 'LOAD_PENDING', 
 'GRID.ALERT', 
 MAX(ST.Alert_Date) 
FROM    grid.stage_alert                     ST 
; 

-- **************************************** 
--  Move stage_alert to alert 
-- **************************************** 

INSERT INTO grid.alert 
SELECT 
 CP.UID_Component, 
 -- This can be replaced once in Java with an in-memory variable 
 ( 
 SELECT MAX(GT.UID_Group) 
 FROM   grid.group_tracking           GT 
 WHERE  GT.Group_Status = 'LOAD_PENDING' 
  AND   GT.Related_Data = 'GRID.ALERT' 
 ), 
 ST.update_date, 
 ST.component_ID, 
 ST.comp_source_system, 
 ST.comp_type, 
 ST.data_origin, 
 COALESCE(AM.measurement_type,'GENERAL-DATA'), 
 ST.alert_date, 
 ST.alert_message 
FROM        grid.stage_alert                      ST 
INNER JOIN  grid.component                        CP 
 ON  ST.Component_ID = CP.Component_ID 
 AND ST.Comp_Source_System = CP.Comp_Source_System 
 AND ST.Comp_Type = CP.Comp_Type 
 LEFT
OUTER JOIN  grid.alert_mapping                    AM 
 ON  ST.data_origin = AM.data_origin 
 AND ST.alert_message = AM.alert_message 
 AND ST.alert_system = AM.alert_system 
WHERE 
     ST.Comp_Type NOT IN ('METER_ELEC','METER_GAS') 
 AND AM.valid_alert = true 
; 

INSERT INTO grid.alert 
SELECT 
 CASE 
 WHEN AMH.UID_Component IS NOT NULL 
 THEN AMH.UID_Component 
 ELSE CP.UID_Component 
 END, 
 -- This can be replaced once in Java with an in-memory variable 
 ( 
 SELECT MAX(GT.UID_Group) 
 FROM   grid.group_tracking           GT 
 WHERE  GT.Group_Status = 'LOAD_PENDING' 
  AND   GT.Related_Data = 'GRID.ALERT' 
 ), 
 ST.update_date, 
 CASE 
 WHEN AMH.UID_Component IS NOT NULL 
 THEN AMH.component_id 
 ELSE CP.component_id 
 END, 
 CASE 
 WHEN AMH.UID_Component IS NOT NULL 
 THEN AMH.comp_source_system 
 ELSE CP.comp_source_system 
 END, 
 CASE 
 WHEN AMH.UID_Component IS NOT NULL 
 THEN AMH.comp_type 
 ELSE CP.comp_type 
 END, 
 ST.data_origin, 
 COALESCE(AM.measurement_type,'GENERAL-DATA'), 
 ST.alert_date, 
 ST.alert_message 
FROM        grid.stage_alert                      ST 
INNER JOIN  grid.component                        CP 
 ON  ST.Component_ID = CP.Component_ID 
 AND ST.Comp_Source_System = CP.Comp_Source_System 
 AND ST.Comp_Type = CP.Comp_Type 
INNER JOIN  grid.vw_attribute_meter_hist          AMH 
 ON  AMH.meter_id = ST.component_id 
 AND AMH.meter_source_system = ST.comp_source_system 
 AND AMH.comp_type = ST.comp_type 
 AND ST.alert_date > amh.install_date 
 AND (    ST.alert_date <= amh.remove_date 
	  or  amh.remove_date is null) 
 LEFT
OUTER JOIN  grid.alert_mapping                    AM 
 ON  ST.data_origin = AM.data_origin 
 AND ST.alert_message = AM.alert_message 
 AND ST.alert_system = AM.alert_system 
WHERE 
     ST.Comp_Type IN ('METER_ELEC','METER_GAS') 
 AND AM.valid_alert = true 
; 

-- **************************************** 
-- Mark group as LOAD_COMPLETE  
-- **************************************** 

INSERT INTO grid.group_tracking 
SELECT 
 GT.uid_group, 
 'LOAD_COMPLETE', 
 GT.related_data, 
 GT.max_data_date 
FROM   grid.group_tracking                      GT 
WHERE  gt.group_status = 'LOAD_PENDING'
 AND NOT EXISTS (SELECT * 
                 FROM   grid.group_tracking 
                 WHERE  
                      uid_group = GT.uid_group 
                  AND group_status = 'LOAD_COMPLETE' 
                ) 
; 

";

echo "********************************************"
echo "Truncate stage tables"
echo "********************************************"

psql -c " 
TRUNCATE grid.stage_usage; 
TRUNCATE grid.stage_alert; 
TRUNCATE grid.stage_attribute_sp; 
TRUNCATE grid.stage_attribute_meter_hist; 
TRUNCATE grid.stage_attribute_connection_hist; 
";

echo "********************************************"
echo "Rerun statistics on new data in tables"
echo "********************************************"

psql -c " 
ANALYZE; 
";
