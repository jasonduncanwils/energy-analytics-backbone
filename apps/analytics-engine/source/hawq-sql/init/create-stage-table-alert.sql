create table stage.alert 
( 
update_date             text not null, 
component_id            text not null, 
comp_source_system      text not null, 
comp_type               text not null, 
data_origin             text not null, 
alert_date              timestamp not null, 
alert_message           text not null, 
alert_system            text 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed by (component_id, comp_source_system, comp_type);