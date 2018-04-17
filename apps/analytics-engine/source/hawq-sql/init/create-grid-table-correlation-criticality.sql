create table grid.correlation_criticality 
( 
criticality_rank        text not null, 
criticality_factor      decimal not null 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly; 