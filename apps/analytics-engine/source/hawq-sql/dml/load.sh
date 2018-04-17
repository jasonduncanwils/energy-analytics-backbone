echo Loading data from stage tables into grid schema...

echo loading data into the component table
psql -f load-component.sql xray

echo loading data into the attribute_sp table
psql -f load-attribute-sp.sql xray

echo loading data into the attribute_meter_hist table
psql -f load-attribute-meter-hist.sql xray

echo loading data into the attribute_connection_hist table
psql -f load-attribute-connection-hist.sql xray

echo loading usage tracking data into the group_tracking table
psql -f load-usage-group-tracking.sql xray

echo loading data into the usage table
psql -f load-service-point-usage.sql xray
psql -f load-meter-usage.sql xray

echo loading alert tracking data into the group_tracking table
psql -f load-alert-group-tracking.sql xray

echo loading data into the alert table
psql -f load-service-point-alert.sql xray
psql -f load-meter-alert.sql xray

echo loading data into the group_tracking table
psql -f load-group-tracking.sql xray

echo done.