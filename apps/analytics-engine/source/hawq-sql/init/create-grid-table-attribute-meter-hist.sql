create table grid.attribute_meter_hist 
( 
uid_component           bigint not null, 
update_date             timestamp not null, 
component_id            text not null, 
comp_source_system      text not null, 
comp_type               text not null, 
meter_id                text not null, 
meter_source_system     text not null, 
install_date            timestamp not null, 
remove_date             timestamp 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed by (uid_component) ;