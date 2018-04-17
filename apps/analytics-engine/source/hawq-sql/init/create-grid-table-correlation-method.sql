create table grid.correlation_method 
( 
correlation_code        text not null, 
description             text not null, 
correlation_category    text not null, 
comp_type               text not null, 
criticality_rank        text not null, 
confidence_factor       decimal not null 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly; 