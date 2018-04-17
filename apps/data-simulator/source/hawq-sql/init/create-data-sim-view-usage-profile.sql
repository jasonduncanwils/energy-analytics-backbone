CREATE OR REPLACE VIEW data_sim.vw_usage_profile AS
    SELECT      prf_type,
                component_type
    FROM        data_sim.simulator_profile_temp
    WHERE       table_name = 'USAGE_PROFILE'
    order by    random();