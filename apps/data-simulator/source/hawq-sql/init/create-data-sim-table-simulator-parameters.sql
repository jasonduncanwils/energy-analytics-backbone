create table data_sim.simulator_parameters
(
    parameter_name          text      not null,
    parameter_value         text      not null
)
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly;