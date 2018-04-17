create table grid.component 
( 
uid_component           bigint not null, 
component_id            text not null, 
comp_source_system      text not null, 
comp_type               text not null 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed  by (uid_component) ;