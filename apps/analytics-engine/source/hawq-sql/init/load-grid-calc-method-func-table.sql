INSERT INTO grid.calc_method_func 
VALUES 
-- ================================================ 
-- Electric Interval KWH 
-- ================================================ 
-- Delivered 
('SP_ELEC_INT_MAIN','SUM','KWH-DEL',1,false,false,''),
('SP_ELEC_INT_MAIN','STDDEV','KWH-DEL',1,false,false,''),
('SP_ELEC_INT_MAIN','AVG_KW','KWH-DEL',1,false,false,''),
('SP_ELEC_INT_MAIN','MIN_KW','KWH-DEL',1,true,false,''),
('SP_ELEC_INT_MAIN','MAX_KW','KWH-DEL',1,true,false,''),
('SP_ELEC_INT_MAIN','SUM_30_DAY_ROLLING','KWH-DEL',30,false,false,''),
('SP_ELEC_INT_MAIN','STDDEV_30_DAY_ROLLING','KWH-DEL',30,false,false,''),
('SP_ELEC_INT_MAIN','AVG_KW_30_DAY_ROLLING','KWH-DEL',30,false,false,''),
('SP_ELEC_INT_MAIN','MIN_KW_30_DAY_ROLLING','KWH-DEL',30,true,false,''),
('SP_ELEC_INT_MAIN','MAX_KW_30_DAY_ROLLING','KWH-DEL',30,true,false,''),
-- Received 
('SP_ELEC_INT_MAIN','SUM','KWH-REC',1,false,false,''),
('SP_ELEC_INT_MAIN','STDDEV','KWH-REC',1,false,false,''),
('SP_ELEC_INT_MAIN','AVG_KW','KWH-REC',1,false,false,''),
('SP_ELEC_INT_MAIN','SUM_30_DAY_ROLLING','KWH-REC',30,false,false,''),
('SP_ELEC_INT_MAIN','AVG_KW_30_DAY_ROLLING','KWH-REC',30,false,false,''),
('SP_ELEC_INT_MAIN','STDDEV_30_DAY_ROLLING','KWH-REC',30,false,false,''),
-- ================================================ 
-- Electric Interval KVARH 
-- ================================================ 
-- Delivered 
('SP_ELEC_INT_MAIN','SUM','KVARH-DEL',1,false,false,''),
('SP_ELEC_INT_MAIN','STDDEV','KVARH-DEL',1,false,false,''),
('SP_ELEC_INT_MAIN','AVG_KVAR','KVARH-DEL',1,false,false,''),
('SP_ELEC_INT_MAIN','MIN_KVAR','KVARH-DEL',1,true,false,''),
('SP_ELEC_INT_MAIN','MAX_KVAR','KVARH-DEL',1,true,false,''),
('SP_ELEC_INT_MAIN','SUM_30_DAY_ROLLING','KVARH-DEL',30,false,false,''),
('SP_ELEC_INT_MAIN','STDDEV_30_DAY_ROLLING','KVARH-DEL',30,false,false,''),
('SP_ELEC_INT_MAIN','AVG_KVAR_30_DAY_ROLLING','KVARH-DEL',30,false,false,''),
('SP_ELEC_INT_MAIN','MIN_KVAR_30_DAY_ROLLING','KVARH-DEL',30,true,false,''),
('SP_ELEC_INT_MAIN','MAX_KVAR_30_DAY_ROLLING','KVARH-DEL',30,true,false,''),
-- Received 
('SP_ELEC_INT_MAIN','SUM','KVARH-REC',1,false,false,''),
('SP_ELEC_INT_MAIN','STDDEV','KVARH-REC',1,false,false,''),
('SP_ELEC_INT_MAIN','AVG_KVAR','KVARH-REC',1,false,false,''),
('SP_ELEC_INT_MAIN','SUM_30_DAY_ROLLING','KVARH-REC',30,false,false,''),
('SP_ELEC_INT_MAIN','AVG_KVAR_30_DAY_ROLLING','KVARH-REC',30,false,false,''),
('SP_ELEC_INT_MAIN','STDDEV_30_DAY_ROLLING','KVARH-REC',30,false,false,''),
-- ================================================ 
-- Electric Interval - Dependent Calcs  
-- ================================================ 
('SP_ELEC_INT_MAIN','Z_SCORE_VS_LAST_MONTH','KWH-DEL',1,false,true,'AVG_KW'), 
('SP_ELEC_INT_MAIN','Z_SCORE_VS_LAST_YEAR','KWH-DEL',1,false,true,'AVG_KW'), 
('SP_ELEC_INT_MAIN','AVG_PF','KVARH-DEL',1,false,true,'AVG_KW'), 
('SP_ELEC_INT_MAIN','MIN_PF','KVARH-DEL',1,true,true,'MIN_KW'), 
('SP_ELEC_INT_MAIN','MAX_PF','KVARH-DEL',1,true,true,'MAX_KW'), 
-- ================================================ 
-- Electric Daily Read Scalar KWH 
-- ================================================ 
-- Delivered 
('SP_ELEC_AR_MAIN','SUM','KWH-DEL',1,false,false,''),
('SP_ELEC_AR_MAIN','AVG_KW','KWH-DEL',1,false,false,''),
('SP_ELEC_AR_MAIN','SUM_30_DAY_ROLLING','KWH-DEL',30,false,false,''),
('SP_ELEC_AR_MAIN','AVG_KW_30_DAY_ROLLING','KWH-DEL',30,false,false,''),
('SP_ELEC_AR_MAIN','STDDEV_30_DAY_ROLLING','KWH-DEL',30,false,false,''),
-- Received 
('SP_ELEC_AR_MAIN','SUM','KWH-REC',1,false,false,''),
('SP_ELEC_AR_MAIN','AVG_KW','KWH-REC',1,false,false,''),
('SP_ELEC_AR_MAIN','SUM_30_DAY_ROLLING','KWH-REC',30,false,false,''),
('SP_ELEC_AR_MAIN','AVG_KW_30_DAY_ROLLING','KWH-REC',30,false,false,''),
('SP_ELEC_AR_MAIN','STDDEV_30_DAY_ROLLING','KWH-REC',30,false,false,''),
-- ================================================ 
-- Electric Daily Read Scalar KW 
-- ================================================ 
-- Delivered 
('SP_ELEC_AR_MAIN','MAX_KW','KW-DEL',1,false,false,''),
('SP_ELEC_AR_MAIN','MAX_KW_30_DAY_ROLLING','KW-DEL',30,false,false,''),
-- ================================================ 
-- Electric Daily Read Scalar KVARH 
-- ================================================ 
-- Delivered 
('SP_ELEC_AR_MAIN','SUM','KVARH-DEL',1,false,false,''),
('SP_ELEC_AR_MAIN','AVG_KVAR','KVARH-DEL',1,false,false,''),
('SP_ELEC_AR_MAIN','SUM_30_DAY_ROLLING','KVARH-DEL',30,false,false,''),
('SP_ELEC_AR_MAIN','AVG_KVAR_30_DAY_ROLLING','KVARH-DEL',30,false,false,''),
('SP_ELEC_AR_MAIN','STDDEV_30_DAY_ROLLING','KVARH-DEL',30,false,false,''),
-- Received 
('SP_ELEC_AR_MAIN','SUM','KVARH-REC',1,false,false,''),
('SP_ELEC_AR_MAIN','AVG_KVAR','KVARH-REC',1,false,false,''),
('SP_ELEC_AR_MAIN','SUM_30_DAY_ROLLING','KVARH-REC',30,false,false,''),
('SP_ELEC_AR_MAIN','AVG_KVAR_30_DAY_ROLLING','KVARH-REC',30,false,false,''),
('SP_ELEC_AR_MAIN','STDDEV_30_DAY_ROLLING','KVARH-REC',30,false,false,''),
-- ================================================ 
-- Electric Daily Read Scalar KVAR 
-- ================================================ 
-- Delivered 
('SP_ELEC_AR_MAIN','MAX_KVAR','KVAR-DEL',1,false,false,''),
('SP_ELEC_AR_MAIN','MAX_KVAR_30_DAY_ROLLING','KVAR-DEL',30,false,false,''),
-- ================================================ 
-- Electric Daily - Dependent Calcs  
-- ================================================ 
('SP_ELEC_AR_MAIN','Z_SCORE_VS_LAST_MONTH','KWH-DEL',1,false,true,'AVG_KW'), 
('SP_ELEC_AR_MAIN','Z_SCORE_VS_LAST_YEAR','KWH-DEL',1,false,true,'AVG_KW'), 
('SP_ELEC_AR_MAIN','AVG_PF','KVARH-DEL',1,false,true,'AVG_KW'), 
-- ================================================ 
-- Electric Monthly Read Scalar KWH 
-- ================================================ 
-- Delivered 
('SP_ELEC_MR_MAIN','SUM','KWH-DEL',1,false,false,''),
('SP_ELEC_MR_MAIN','AVG_KW','KWH-DEL',1,false,false,''),
-- Received 
('SP_ELEC_MR_MAIN','SUM','KWH-REC',1,false,false,''),
('SP_ELEC_MR_MAIN','AVG_KW','KWH-REC',1,false,false,''),
-- ================================================ 
-- Electric Monthly Read Scalar KW 
-- ================================================ 
-- Delivered 
('SP_ELEC_MR_MAIN','MAX_KW','KW-DEL',1,false,false,''),
-- ================================================ 
-- Electric Monthly Read Scalar KVARH 
-- ================================================ 
-- Delivered 
('SP_ELEC_MR_MAIN','SUM','KVARH-DEL',1,false,false,''),
('SP_ELEC_MR_MAIN','AVG_KVAR','KVARH-DEL',1,false,false,''),
-- Received 
('SP_ELEC_MR_MAIN','SUM','KVARH-REC',1,false,false,''),
('SP_ELEC_MR_MAIN','AVG_KVAR','KVARH-REC',1,false,false,''),
-- ================================================ 
-- Electric Monthly Read Scalar KVAR 
-- ================================================ 
-- Delivered 
('SP_ELEC_MR_MAIN','MAX_KVAR','KVAR-DEL',1,false,false,''),
-- ================================================ 
-- Electric Interval - Dependent Calcs  
-- ================================================ 
('SP_ELEC_MR_MAIN','AVG_PF','KVARH-DEL',1,false,true,'AVG_KW'), 
('SP_ELEC_MR_MAIN','MAX_PF','KVAR-DEL',1,true,true,'MAX_KW'), 
-- ================================================ 
-- Gas Interval CCF 
-- ================================================ 
('SP_GAS_INT_MAIN','SUM','CCF-DEL',1,false,false,''),
('SP_GAS_INT_MAIN','AVG_DAILY','CCF-DEL',1,false,false,''),
('SP_GAS_INT_MAIN','SUM_30_DAY_ROLLING','CCF-DEL',30,false,false,''),
('SP_GAS_INT_MAIN','AVG_DAILY_30_DAY_ROLLING','CCF-DEL',30,false,false,''),
('SP_GAS_INT_MAIN','STDDEV_30_DAY_ROLLING','CCF-DEL',30,false,false,''),
-- ================================================ 
-- Gas Daily Read Scalar CCF 
-- ================================================ 
('SP_GAS_AR_MAIN','SUM','CCF-DEL',1,false,false,''),
('SP_GAS_AR_MAIN','AVG_DAILY','CCF-DEL',1,false,false,''),
('SP_GAS_AR_MAIN','SUM_30_DAY_ROLLING','CCF-DEL',30,false,false,''),
('SP_GAS_AR_MAIN','AVG_DAILY_30_DAY_ROLLING','CCF-DEL',30,false,false,''),
('SP_GAS_AR_MAIN','STDDEV_30_DAY_ROLLING','CCF-DEL',30,false,false,''),
-- ================================================ 
-- Gas Monthly Read Scalar CCF 
-- ================================================ 
('SP_GAS_MR_MAIN','SUM','CCF-DEL',1,false,false,''),
('SP_GAS_MR_MAIN','AVG_DAILY','CCF-DEL',1,false,false,'')
;