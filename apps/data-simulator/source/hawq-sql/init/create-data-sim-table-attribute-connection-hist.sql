create table data_sim.attribute_connection_hist
(
    component_id            text      not null,
    component_source_system text      not null,
    component_type          text      not null,
    connection_status       text      not null,
    connection_date         timestamp not null,
    disconnect_method       text            
)
with  (appendonly=true,  compresstype=quicklz)   distributed  by (component_id, component_source_system, component_type) ;
