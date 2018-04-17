create table grid.alert 
(  
uid_component           bigint not null, 
uid_group               bigint not null, 
update_date             timestamp not null, 
component_id            text not null, 
comp_source_system      text not null, 
comp_type               text not null, 
data_origin             text not null, 
measurement_type        text not null, 
alert_date              timestamp not null, 
alert_message           text not null, 
alert_system            text 
)  
with  (appendonly=true,  compresstype=quicklz)   distributed by (uid_group, uid_component)  
partition by range(alert_date)  
(start(date '2014-01-01') end(date '2014-12-31') inclusive every (interval '1 month'));