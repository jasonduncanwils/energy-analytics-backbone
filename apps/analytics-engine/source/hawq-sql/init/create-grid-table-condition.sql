create table grid.condition 
( 
uid_component           bigint not null, 
component_id            text not null, 
comp_source_system      text not null, 
comp_type               text not null, 
condition_code          text not null, 
end_date                timestamp not null, 
update_date             timestamp not null 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed by (uid_component) 
partition by range(end_date) 
(start(date '2014-01-01') end(date '2014-12-31') inclusive every (interval '1 month')); 