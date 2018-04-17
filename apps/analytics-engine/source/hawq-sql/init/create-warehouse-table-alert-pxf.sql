CREATE EXTERNAL TABLE warehouse.alert_pxf 
(
update_date	timestamp,
component_id text, 
comp_source_system text, 
comp_type text, 
measurement_type text, 
alert_date timestamp, 
alert_message text
)
LOCATION ('pxf://pivhdsne:50070/xd/xray/data/warehouse/*/*/alert*.csv?profile=HdfsTextSimple')
FORMAT 'TEXT' (DELIMITER = E'|')
ENCODING 'LATIN1';
