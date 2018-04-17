create table grid.correlation 
( 
uid_component           bigint not null, 
component_id            text not null, 
comp_source_system      text not null, 
comp_type               text not null, 
correlation_code        text not null, 
end_date                timestamp not null, 
priority_score          integer not null, 
condition_code_array    text[] not null, 
update_date             timestamp not null 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed  by (uid_component) ; 