CREATE EXTERNAL TABLE warehouse.usage_pxf 
(
update_date				timestamp,
component_id            text, 
comp_source_system      text, 
comp_type               text, 
measurement_type        text, 
start_date              timestamp, 
end_date                timestamp, 
usage_value             decimal, 
seconds                 integer, 
multiplier              decimal, 
data_origin             text, 
quality_code            text
)
LOCATION ('pxf://pivhdsne:50070/xd/xray/data/warehouse/*/*/usage*.csv?profile=HdfsTextSimple')
FORMAT 'TEXT' (DELIMITER = E'|')
ENCODING 'LATIN1';
