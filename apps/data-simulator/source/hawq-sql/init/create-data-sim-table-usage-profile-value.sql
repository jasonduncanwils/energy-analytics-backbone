create  table data_sim.usage_profile_value
(
    usg_prf_type            text    not null,
    measurement_type        text    not null,
    usage_sequence          integer not null,
    usage_value             decimal not null,
    quality_code            text    
)
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly;