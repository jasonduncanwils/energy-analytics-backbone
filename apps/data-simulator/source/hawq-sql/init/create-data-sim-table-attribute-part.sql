create table data_sim.attribute_part
(   
    uid_attr_part           bigint not null,
    attr_part_type          text   not null,
    attr_part_value         text   not null
)
with  (appendonly=true,  compresstype=quicklz)   distributed  by (uid_attr_part);