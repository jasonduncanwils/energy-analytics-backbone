create table grid.calc_method 
( 
calc_method             text not null, 
comp_type               text not null, 
data_origin             text not null, 
calc_sequence           integer not null, 
calc_group              text not null, 
input_location          text not null,
output_location         text not null 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly;