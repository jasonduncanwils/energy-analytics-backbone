create table grid.condition_code 
( 
condition_code          text not null, 
condition_group         text not null, 
days_valid              integer not null, 
description             text not null 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly; 