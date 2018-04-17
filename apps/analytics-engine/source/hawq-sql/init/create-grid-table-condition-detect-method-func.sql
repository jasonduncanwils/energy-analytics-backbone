create table grid.condition_detect_method_func 
( 
detection_method        text not null, 
detection_name          text not null, 
detection_logic         text not null 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly; 