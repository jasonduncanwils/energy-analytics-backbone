create table data_sim.simulator_comp_temp
(
    component_id            text    not null,
    component_source_system text    not null,
    component_type          text    not null,
    temp_type               text    not null,
    temp_value              text    not null
)
with  (appendonly=true,  compresstype=quicklz)   distributed  by (component_id, component_source_system, component_type) ;