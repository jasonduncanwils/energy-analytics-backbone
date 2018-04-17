create table grid.usage 
( 
uid_component           bigint not null, 
uid_group               bigint not null, 
update_date             timestamp not null, 
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
with  (appendonly=true,  compresstype=quicklz)   distributed by (uid_group, uid_component)  
partition by range(end_date) 
(start(date '2014-01-01') end(date '2014-12-31') inclusive every (interval '1 month'));