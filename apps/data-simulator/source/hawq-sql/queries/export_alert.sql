\copy (select localtimestamp, a.* from data_sim.alert a) to '/tmp/alert.csv' with DELIMITER '|';
