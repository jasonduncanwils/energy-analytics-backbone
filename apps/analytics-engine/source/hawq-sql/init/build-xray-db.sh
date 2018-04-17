echo Creating xray database and its schemas...
psql -q -f create-xray-db.sql

echo creating stage tables...
psql -q -f create-stage-table-alert.sql xray
psql -q -f create-stage-table-alert-pxf.sql xray
psql -q -f create-stage-table-attribute-connection-hist.sql xray
psql -q -f create-stage-table-attribute-connection-hist-pxf.sql xray
psql -q -f create-stage-table-attribute-meter-hist.sql xray
psql -q -f create-stage-table-attribute-meter-hist-pxf.sql xray
psql -q -f create-stage-table-attribute-sp.sql xray
psql -q -f create-stage-table-attribute-sp-pxf.sql xray
psql -q -f create-stage-table-usage.sql xray
psql -q -f create-stage-table-usage-pxf.sql xray

echo creating stage views...
psql -q -f create-stage-view-component_pxf.sql xray


echo creating warehouse tables...
psql -q -f create-warehouse-table-alert-pxf.sql xray
psql -q -f create-warehouse-table-attribute-connection-hist-pxf.sql xray
psql -q -f create-warehouse-table-attribute-meter-hist-pxf.sql xray
psql -q -f create-warehouse-table-attribute-sp-pxf.sql xray
psql -q -f create-warehouse-table-usage-pxf.sql xray

echo creating grid tables...
psql -q -f create-grid-table-alert-mapping.sql xray
psql -q -f create-grid-table-alert.sql xray
psql -q -f create-grid-table-attribute-connection-hist.sql xray
psql -q -f create-grid-table-attribute-meter-hist.sql xray
psql -q -f create-grid-table-attribute-sp.sql xray
psql -q -f create-grid-table-calc-method-func.sql xray
psql -q -f create-grid-table-calc-method.sql xray
psql -q -f create-grid-table-calc.sql xray
psql -q -f create-grid-table-component.sql xray
psql -q -f create-grid-table-condition-code.sql xray
psql -q -f create-grid-table-condition-detect-method-func-p.sql xray
psql -q -f create-grid-table-condition-detect-method-func.sql xray
psql -q -f create-grid-table-condition-detect-method.sql xray
psql -q -f create-grid-table-condition.sql xray
psql -q -f create-grid-table-correlation-criticality.sql xray
psql -q -f create-grid-table-correlation-method-rule.sql xray
psql -q -f create-grid-table-correlation-method.sql xray
psql -q -f create-grid-table-correlation-working.sql xray
psql -q -f create-grid-table-correlation.sql xray
psql -q -f create-grid-table-group-tracking.sql xray
psql -q -f create-grid-table-lookup-value.sql xray
psql -q -f create-grid-table-usage-priority.sql xray
psql -q -f create-grid-table-usage.sql xray

echo loading configuration data into grid schema tables...
psql -q -f load-grid-usage-priority-table.sql xray
psql -q -f load-grid-alert-mapping-table.sql xray
psql -q -f load-grid-lookup-value-table.sql xray
psql -q -f load-grid-calc-method-table.sql xray
psql -q -f load-grid-calc-method-func-table.sql xray
psql -q -f load-grid-condition-code-table.sql xray
psql -q -f load-grid-condition-detect-method-table.sql xray
psql -q -f load-grid-condition-detect-method-func-table.sql xray
psql -q -f load-grid-condition-detect-method-func-p-table.sql xray
psql -q -f load-grid-correlation-criticality-table.sql xray
psql -q -f load-grid-correlation-method-table.sql xray
psql -q -f load-grid-correlation-method-rule-table.sql xray


echo creating grid sequences...
psql -q -f create-grid-sequences.sql xray

echo creating grid views...
psql -q -f create-grid-view-alert.sql xray
psql -q -f create-grid-view-attribute-connection-hist.sql xray
psql -q -f create-grid-view-attribute-meter-hist.sql xray
psql -q -f create-grid-view-attribute-sp.sql xray
psql -q -f create-grid-view-calc-pending.sql xray
psql -q -f create-grid-view-calc.sql xray
psql -q -f create-grid-view-condition-detect-parms.sql xray
psql -q -f create-grid-view-condition-detect-pending.sql xray
psql -q -f create-grid-view-correlation-method.sql xray
psql -q -f create-grid-view-correlation-working.sql xray
psql -q -f create-grid-view-usage.sql xray
psql -q -f create-grid-view-group-tracking.sql xray

echo creating grid functions...
psql -q -f create-grid-function-combine-three-arrays.sql xray
psql -q -f create-grid-function-contains-condition-code.sql xray
psql -q -f create-grid-function-contains-condition-group.sql xray
psql -q -f create-grid-function-get-pending-usage-group-id.sql xray
psql -q -f create-grid-function-get-pending-alert-group-id.sql xray
psql -q -f create-grid-function-get-group-id-max-date.sql xray

echo creating xray db hdfs directories and empty data files...
sudo -u hdfs hadoop fs -mkdir -p /xd/xray/data/stage
sudo -u hdfs hadoop fs -touchz /xd/xray/data/stage/alert_empty.csv
sudo -u hdfs hadoop fs -touchz /xd/xray/data/stage/attribute_sp_empty.csv
sudo -u hdfs hadoop fs -touchz /xd/xray/data/stage/attribute_meter_hist_empty.csv
sudo -u hdfs hadoop fs -touchz /xd/xray/data/stage/attribute_conn_hist_empty.csv
sudo -u hdfs hadoop fs -touchz /xd/xray/data/stage/usage_empty.csv
sudo -u hdfs hadoop fs -mkdir -p /xd/xray/data/warehouse
sudo -u hdfs hadoop fs -chown -R spring-xd:hadoop /xd
sudo -u spring-xd hadoop fs -chmod -R a+w /xd/xray

echo done. 
