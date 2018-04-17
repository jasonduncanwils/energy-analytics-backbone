create table grid.condition_detect_method_func_p 
( 
detection_name          text not null, 
parm_number             integer not null, 
parm_description        text not null, 
parm_value              text not null, 
update_date             timestamp DEFAULT CURRENT_TIMESTAMP 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly; 