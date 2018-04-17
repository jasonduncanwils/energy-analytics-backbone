\copy (select localtimestamp, u.* from data_sim.usage u) to '/tmp/usage.csv' with DELIMITER '|';
