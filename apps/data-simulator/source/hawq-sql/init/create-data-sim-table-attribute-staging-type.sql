create table data_sim.attribute_staging_type
(
    attr_stg_type           text   not null
)
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly;