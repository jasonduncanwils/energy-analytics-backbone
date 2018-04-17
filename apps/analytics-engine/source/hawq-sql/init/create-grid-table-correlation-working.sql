create table grid.correlation_working 
( 
uid_component           bigint not null, 
comp_type               text not null, 
end_date                timestamp not null, 
condition_array         text[][][] not null 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed  by (uid_component) ; 