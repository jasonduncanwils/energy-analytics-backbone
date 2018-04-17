create table grid.calc 
( 
uid_component           bigint not null, 
update_date             text not null, 
component_id            text not null, 
comp_source_system      text not null, 
comp_type               text not null, 
calc_function           text not null, 
orig_measurement_type   text, 
data_origin             text,
reliability_percent     decimal, 
start_date              timestamp, 
end_date                timestamp, 
calc_value              decimal, 
seconds                 integer, 
occurance_date          timestamp 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed by (uid_component) 
partition by range(end_date) 
(start(date '2014-01-01') end(date '2014-12-31') inclusive every (interval '1 month'));