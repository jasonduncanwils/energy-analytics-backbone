create table stage.attribute_connection_hist 
( 
update_date             text not null, 
component_id            text not null, 
comp_source_system      text not null, 
comp_type               text not null, 
connection_status       text not null, 
connection_date         timestamp not null, 
disconnect_method       text 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed   randomly;
