create table grid.calc_method_func 
( 
calc_method             text not null, 
calc_function           text not null, 
measurement_type        text not null, 
calc_trailing_days      integer not null, 
specific_date_needed    boolean not null,
dependency              boolean not null, 
dependent_calc          text 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly;