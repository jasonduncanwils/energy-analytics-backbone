create table grid.lookup_value 
( 
lookup_column             text not null, 
lookup_val                text not null 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed   by (lookup_column);