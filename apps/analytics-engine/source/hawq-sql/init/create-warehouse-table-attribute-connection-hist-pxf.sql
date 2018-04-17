CREATE EXTERNAL TABLE warehouse.attribute_connection_hist_pxf 
(
update_date				timestamp,
component_id            text, 
comp_source_system      text, 
comp_type               text, 
connection_status       text, 
connection_date         timestamp, 
disconnect_method       text 
)
LOCATION ('pxf://pivhdsne:50070/xd/xray/data/warehouse/*/*/attribute_connection_hist*.csv?profile=HdfsTextSimple')
FORMAT 'TEXT' (DELIMITER = E'|')
ENCODING 'LATIN1';
