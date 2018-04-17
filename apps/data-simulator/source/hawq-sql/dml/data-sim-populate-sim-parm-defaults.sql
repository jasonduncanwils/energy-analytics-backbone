truncate data_sim.simulator_parameters;

insert into data_sim.simulator_parameters
values
('NUMBER_OF_SPS','10000'),
('USAGE_END_DATE','2015-01-01'),
('USAGE_TOTAL_SECONDS','86400'),
('ALERT_END_DATE','2015-01-01'),
('ALERT_TOTAL_SECONDS','86400'),
('MAX_STREET_NUMBER','9999'),
('SERV_PT_ID_ELEC_MIN','10000000'),
('SERV_PT_ID_ELEC_RANGE','10000000'),
('SERV_PT_ID_GAS_MIN','20000000'),
('SERV_PT_ID_GAS_RANGE','10000000'),
('METER_ID_ELEC_MIN','1000000'),
('METER_ID_ELEC_RANGE','5000000'),
('METER_ID_GAS_MIN','1000000'),
('METER_ID_GAS_RANGE','5000000'),
('PERCENT_WITH_GAS','15'),
('NUM_OF_BILL_DAYS','28')
-- ('PERCENT_C_AND_I','10'),
-- ('PERCENT_APTS','20')
;