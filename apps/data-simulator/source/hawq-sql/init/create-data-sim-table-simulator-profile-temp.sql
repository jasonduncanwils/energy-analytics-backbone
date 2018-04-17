create table data_sim.simulator_profile_temp
(
    table_name              text    not null,
    prf_type                text    not null,
    component_type          text    not null
)
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly;