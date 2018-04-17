create table grid.group_tracking 
( 
uid_group               bigint not null, 
group_status            text not null, 
related_data            text not null, 
max_data_date           timestamp not null,
created_date			timestamp not null default now() 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed  by (uid_group) 
partition by range(max_data_date) 
(start(date '2014-01-01') end(date '2014-12-31') inclusive every (interval '1 month'));