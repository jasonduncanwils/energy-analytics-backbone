create table grid.alert_mapping 
( 
alert_system             text not null, 
data_origin              text not null, 
alert_message            text not null, 
valid_alert              boolean not null, 
measurement_type         text not null 
) 
with  (appendonly=true,  compresstype=quicklz)   distributed  randomly;