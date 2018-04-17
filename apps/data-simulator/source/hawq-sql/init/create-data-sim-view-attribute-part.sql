CREATE OR REPLACE VIEW data_sim.vw_attribute_part AS
    SELECT      attr_part_value,
                attr_part_type
    FROM        data_sim.attribute_part
    ORDER BY    random();