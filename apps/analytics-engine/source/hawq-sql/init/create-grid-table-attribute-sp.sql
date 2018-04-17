create table grid.attribute_sp  
( 
uid_component           bigint not null, 
update_date             timestamp not null, 
component_id            text not null, 
comp_source_system      text not null, 
comp_type               text not null, 
address                 text, 
city                    text, 
state                   text, 
postal_code             text, 
customer_name           text, 
account_active_yn       text, 
service_connected_yn    text,
net_metering_yn         text
) 
with  (appendonly=true,  compresstype=quicklz)   distributed by (uid_component) ;