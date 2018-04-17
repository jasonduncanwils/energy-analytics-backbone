create table grid.condition_detect_method 
( 
detection_method        text not null, 
comp_type               text not null 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly; 