CREATE EXTERNAL TABLE warehouse.attribute_sp_pxf 
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
account_active_ind      text, 
service_connected_ind   text 
)
LOCATION ('pxf://pivhdsne:50070/xd/xray/data/warehouse/*/*/attribute_sp*.csv?profile=HdfsTextSimple')
FORMAT 'TEXT' (DELIMITER = E'|')
ENCODING 'LATIN1';
