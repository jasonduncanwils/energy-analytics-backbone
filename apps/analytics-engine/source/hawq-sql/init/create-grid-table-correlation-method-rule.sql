create table grid.correlation_method_rule 
( 
correlation_code        text not null, 
rule_type               text not null, 
rule                    text not null, 
occurance_threshold     integer not null 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly; 