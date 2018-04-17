create table data_sim.attribute_staging
(
    attr_stg_type           text   not null,
    sequence                bigint not null,
    attr_stg_value          text   not null
)
with  (appendonly=true,  compresstype=quicklz)   distributed  by (sequence);