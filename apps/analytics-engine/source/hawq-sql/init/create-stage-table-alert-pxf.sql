CREATE EXTERNAL TABLE stage.alert_pxf 
(
update_date 		    timestamp,
component_id 		    text, 
comp_source_system 	    text, 
comp_type 			    text, 
data_origin     	    text, 
alert_date 			    timestamp, 
alert_message 		    text, 
alert_system            text 
)
LOCATION ('pxf://pivhdsne:50070/xd/xray/data/stage/alert*.csv?profile=HdfsTextSimple')
FORMAT 'TEXT' (DELIMITER = E'|')
ENCODING 'LATIN1';
