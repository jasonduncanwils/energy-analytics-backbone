CREATE EXTERNAL TABLE stage.attribute_sp_pxf 
(
update_date				timestamp,
component_id            text, 
comp_source_system      text, 
comp_type               text, 
address                 text, 
city                    text, 
state                   text, 
postal_code             text, 
customer_name           text, 
account_active_yn       text, 
service_connected_yn    text,
net_metering_yn         text 
)
LOCATION ('pxf://pivhdsne:50070/xd/xray/data/stage/attribute_sp*.csv?profile=HdfsTextSimple')
FORMAT 'TEXT' (DELIMITER '|' FILL MISSING FIELDS)
ENCODING 'LATIN1';
