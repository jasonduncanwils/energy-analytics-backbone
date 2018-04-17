INSERT INTO grid.lookup_value 
VALUES 
-- ********************* 
-- component_type 
-- ********************* 
('COMPONENT_TYPE','SERVICE_PT_ELEC'), 
('COMPONENT_TYPE','SERVICE_PT_GAS'), 
('COMPONENT_TYPE','METER_ELEC'), 
('COMPONENT_TYPE','METER_GAS'), 
('COMPONENT_TYPE','TRANSFORMER'), 
('COMPONENT_TYPE','FEEDER'), 
('COMPONENT_TYPE','SUBSTATION'), 
-- ********************* 
-- data_origin 
-- ********************* 
('DATA_ORIGIN','INTERVAL'), 
('DATA_ORIGIN','DAILY_SCALAR'), 
('DATA_ORIGIN','MONTHLY_SCALAR'), 
('DATA_ORIGIN','METER_EVENT'), 
('DATA_ORIGIN','METER_READER_COMMENT'), 
('DATA_ORIGIN','OUTAGE'), 
-- ********************* 
-- measurement_type 
-- ********************* 
('MEASUREMENT_TYPE','KWH-DEL'),
('MEASUREMENT_TYPE','KWH-REC'),
('MEASUREMENT_TYPE','KW-DEL'),
('MEASUREMENT_TYPE','KW-REC'),
('MEASUREMENT_TYPE','KVARH-DEL'), 
('MEASUREMENT_TYPE','KVARH-REC'), 
('MEASUREMENT_TYPE','KVAR-DEL'), 
('MEASUREMENT_TYPE','KVAR-REC'), 
('MEASUREMENT_TYPE','CCF-DEL'), 
('MEASUREMENT_TYPE','GENERAL-DATA'), 
('MEASUREMENT_TYPE','TAMPER'), 
('MEASUREMENT_TYPE','REVERSE-ROTATION'), 
-- ********************* 
-- group_status 
-- ********************* 
('GROUP_STATUS','LOAD_PENDING'), 
('GROUP_STATUS','LOAD_COMPLETE'), 
('GROUP_STATUS','CALC_PENDING'), 
('GROUP_STATUS','CALC_COMPLETE'),
('GROUP_STATUS','DETECTION_PENDING'),
('GROUP_STATUS','DETECTION_COMPLETE'),
-- ********************* 
-- quality_code 
-- ********************* 
('QUALITY_CODE','METERED'), 
('QUALITY_CODE','PRORATED'),
('QUALITY_CODE','ESTIMATED'), 
('QUALITY_CODE','OUTAGE'), 
('QUALITY_CODE','OTHER'), 
-- ********************* 
-- disconnect_method 
-- ********************* 
('DISCONNECT_METHOD','METER_SOFT_SEAL'), 
('DISCONNECT_METHOD','REMOTE'), 
('DISCONNECT_METHOD','HARD_CUT'), 
('DISCONNECT_METHOD','OTHER'), 
-- ********************* 
-- calc_group 
-- ********************* 
('CALC_GROUP','USAGE_SINGULAR'), 
-- ********************* 
-- calc_function 
-- ********************* 
-- General 
('CALC_FUNCTION','SUM'), 
('CALC_FUNCTION','AVG_DAILY'), 
('CALC_FUNCTION','STDDEV'), 
('CALC_FUNCTION','SUM_30_DAY_ROLLING'), 
('CALC_FUNCTION','AVG_DAILY_30_DAY_ROLLING'), 
('CALC_FUNCTION','STDDEV_30_DAY_ROLLING'), 
('CALC_FUNCTION','Z_SCORE_VS_LAST_MONTH'), 
('CALC_FUNCTION','Z_SCORE_VS_LAST_YEAR'), 
-- kW specific 
('CALC_FUNCTION','AVG_KW'), 
('CALC_FUNCTION','MIN_KW'), 
('CALC_FUNCTION','MAX_KW'), 
('CALC_FUNCTION','AVG_KW_30_DAY_ROLLING'), 
('CALC_FUNCTION','MIN_KW_30_DAY_ROLLING'), 
('CALC_FUNCTION','MAX_KW_30_DAY_ROLLING'), 
-- kVAr specific 
('CALC_FUNCTION','AVG_KVAR'), 
('CALC_FUNCTION','MIN_KVAR'), 
('CALC_FUNCTION','MAX_KVAR'), 
('CALC_FUNCTION','AVG_KVAR_30_DAY_ROLLING'), 
('CALC_FUNCTION','MIN_KVAR_30_DAY_ROLLING'), 
('CALC_FUNCTION','MAX_KVAR_30_DAY_ROLLING'), 
-- Power Factor specific 
('CALC_FUNCTION','AVG_PF'), 
('CALC_FUNCTION','MIN_PF'), 
('CALC_FUNCTION','MAX_PF') 
;