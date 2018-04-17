create table data_sim.alert
(
    component_id            text      not null,
    component_source_system text      not null,
    component_type          text      not null,
    data_origin             text      not null,
    alert_date              timestamp not null,
    alert_message           text      not null,
    alert_system            text
)
with  (appendonly=true,  compresstype=quicklz)   distributed  by (component_id, component_source_system, component_type) ;