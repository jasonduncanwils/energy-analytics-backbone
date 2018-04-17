create table stage.attribute_sp 
( 
update_date             text not null, 
component_id            text not null, 
comp_source_system      text not null, 
comp_type               text not null, 
address                 text, 
city                    text, 
state                   text, 
postal_code             text, 
customer_name           text, 
account_active_yn       text DEFAULT 'Y', 
service_connected_yn    text DEFAULT 'Y', 
net_metering_yn         text DEFAULT 'N' 

) 
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly;