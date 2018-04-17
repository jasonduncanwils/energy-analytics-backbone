\copy (select localtimestamp, a.* from data_sim.attribute_meter_hist a) to '/tmp/attribute_meter_hist.csv' with DELIMITER '|';
