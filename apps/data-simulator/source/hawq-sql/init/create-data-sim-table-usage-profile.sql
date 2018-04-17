create  table data_sim.usage_profile
(
    usg_prf_type            text    not null,
    component_type          text    not null,
    measurement_type        text    not null,
    data_origin             text    not null,
    seconds                 integer not null,
    meter_multiplier        decimal not null,
    default_quality_code    text    not null,
    likelihood_percent      decimal not null,
    random_value_ind        boolean not null,
    random_value_multiple   integer not null
)
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly;