\copy (select localtimestamp, a.* from data_sim.attribute_connection_hist a) to '/tmp/attribute_connection_hist.csv' with DELIMITER '|';
