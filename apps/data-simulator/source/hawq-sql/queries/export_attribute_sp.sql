\copy (select localtimestamp, a.* from data_sim.attribute_sp a) to '/tmp/attribute_sp.csv' with DELIMITER '|';
