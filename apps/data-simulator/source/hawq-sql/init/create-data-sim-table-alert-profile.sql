create table data_sim.alert_profile
(
    alert_prf_type          text    not null,
    component_type          text    not null,
    alert_message           text    not null,
    data_origin             text    not null,
    likelihood_percent      decimal not null,
    alert_system            text            ,
    restrict_to_usg_prf_type text
)
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly;