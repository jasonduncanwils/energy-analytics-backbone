create table data_sim.attribute_meter_hist
(
    component_id            text      not null,
    component_source_system text      not null,
    component_type          text      not null,
    meter_id                text      not null,
    meter_source_system     text      not null,
    install_date            timestamp not null,
    remove_date             timestamp        
)
with  (appendonly=true,  compresstype=quicklz)   distributed  by (component_id, component_source_system, component_type) ;