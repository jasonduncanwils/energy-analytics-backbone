create table data_sim.attribute_sp
(
    component_id            text    not null,
    component_source_system text    not null,
    component_type          text    not null,
    address                 text            ,
    city                    text            ,
    state                   text            ,
    postal_code             text            ,
    customer_name           text            ,
    account_active_yn       text            ,
    service_connected_yn    text         
)
with  (appendonly=true,  compresstype=quicklz)   distributed  by (component_id, component_source_system, component_type) ;