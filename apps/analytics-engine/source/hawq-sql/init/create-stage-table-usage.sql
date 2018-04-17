create table stage.usage 
( 
update_date             text not null, 
component_id            text not null, 
comp_source_system      text not null, 
comp_type               text not null, 
measurement_type        text not null, 
start_date              timestamp not null, 
end_date                timestamp not null, 
usage_value             decimal not null, 
seconds                 integer not null, 
multiplier              decimal not null, 
data_origin             text not null, 
quality_code            text not null 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed by (component_id, comp_source_system, comp_type);
