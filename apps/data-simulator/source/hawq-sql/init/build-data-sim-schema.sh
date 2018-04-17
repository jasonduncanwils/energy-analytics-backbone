echo Creating data_sim schema...
psql -q -f create-data-sim-schema.sql xray

echo creating data_sim tables...
psql -q -f create-data-sim-table-alert-profile.sql xray
psql -q -f create-data-sim-table-alert.sql xray
psql -q -f create-data-sim-table-attribute-connection-hist.sql xray
psql -q -f create-data-sim-table-attribute-meter-hist.sql xray
psql -q -f create-data-sim-table-attribute-part.sql xray
psql -q -f create-data-sim-table-attribute-sp.sql xray
psql -q -f create-data-sim-table-attribute-staging-type.sql xray
psql -q -f create-data-sim-table-attribute-staging.sql xray
psql -q -f create-data-sim-table-component.sql xray
psql -q -f create-data-sim-table-simulator-comp-temp.sql xray
psql -q -f create-data-sim-table-simulator-parameters.sql xray
psql -q -f create-data-sim-table-simulator-profile-temp.sql xray
psql -q -f create-data-sim-table-usage-profile-value.sql xray
psql -q -f create-data-sim-table-usage-profile.sql xray
psql -q -f create-data-sim-table-usage.sql xray

echo creating data_sim sequences...
psql -q -f create-data-sim-sequences.sql xray

echo creating data_sim views...
psql -q -f create-data-sim-view-attribute-part.sql xray
psql -q -f create-data-sim-view-usage-profile.sql xray

echo creating data_sim functions...
psql -q -f create-data-sim-function-get-attribute-part.sql xray
psql -q -f create-data-sim-function-get-count-attr-stg.sql xray
psql -q -f create-data-sim-function-get-random-bill-day.sql xray
psql -q -f create-data-sim-function-get-random-usg-prf.sql xray
psql -q -f create-data-sim-function-get-sim-parameter-int.sql xray
psql -q -f create-data-sim-function-get-sim-parameter-timestamp.sql xray
psql -q -f create-data-sim-function-get-usage-dates.sql xray

echo done. 
