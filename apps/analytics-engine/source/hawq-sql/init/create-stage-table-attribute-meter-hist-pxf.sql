CREATE EXTERNAL TABLE stage.attribute_meter_hist_pxf
(
update_date				timestamp,
component_id            text, 
comp_source_system      text, 
comp_type               text, 
meter_id                text, 
meter_source_system     text, 
install_date            timestamp, 
remove_date             timestamp 
)
LOCATION ('pxf://pivhdsne:50070/xd/xray/data/stage/attribute_meter_hist*.csv?profile=HdfsTextSimple')
FORMAT 'TEXT' (DELIMITER = E'|')
ENCODING 'LATIN1';
