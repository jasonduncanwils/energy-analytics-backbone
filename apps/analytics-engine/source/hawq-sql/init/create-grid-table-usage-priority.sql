create table grid.usage_priority 
( 
data_origin             text not null, 
priority                integer not null 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly; 