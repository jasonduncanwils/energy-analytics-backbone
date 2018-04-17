create  table data_sim.usage
(
    component_id            text      not null,
    component_source_system text      not null,
    component_type          text      not null,
    measurement_type        text      not null,
    start_date              timestamp not null,
    end_date                timestamp not null,
    usage_value             decimal   not null,
    seconds                 integer   not null,
    multiplier              decimal   not null,
    data_origin             text      not null,
    quality_code            text      not null
)
with  (appendonly=true,  compresstype=quicklz)   distributed  by (component_id, component_source_system, component_type) ;