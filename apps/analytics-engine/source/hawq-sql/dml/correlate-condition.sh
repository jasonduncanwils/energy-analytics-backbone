echo Running condition correlation...

echo Populate correlation working table...
psql -f correlate-condition-populate-working-table.sql xray

echo Run through electric correlation logic...
#these can all be run in parallel
psql -f correlate-condition-e-abnormal-usage-100.sql xray
psql -f correlate-condition-e-abnormal-usage-101.sql xray
psql -f correlate-condition-e-abnormal-usage-102.sql xray
psql -f correlate-condition-e-abnormal-usage-200.sql xray
psql -f correlate-condition-e-abnormal-usage-201.sql xray
psql -f correlate-condition-e-abnormal-usage-202.sql xray
psql -f correlate-condition-e-abnormal-usage-300.sql xray
psql -f correlate-condition-e-abnormal-usage-400.sql xray
psql -f correlate-condition-e-communication-issue-100.sql xray
psql -f correlate-condition-e-communication-issue-200.sql xray
psql -f correlate-condition-e-communication-issue-300.sql xray
psql -f correlate-condition-e-overloaded-service-100.sql xray
psql -f correlate-condition-e-power-quality-100.sql xray
psql -f correlate-condition-e-power-quality-101.sql xray
psql -f correlate-condition-e-power-quality-102.sql xray
psql -f correlate-condition-e-power-quality-200.sql xray
psql -f correlate-condition-e-power-quality-201.sql xray
psql -f correlate-condition-e-power-quality-202.sql xray
psql -f correlate-condition-e-power-quality-300.sql xray
psql -f correlate-condition-e-power-quality-400.sql xray
psql -f correlate-condition-e-reverse-usage-100.sql xray
psql -f correlate-condition-e-swapped-meter-100.sql xray
psql -f correlate-condition-e-tamper-100.sql xray
psql -f correlate-condition-e-tamper-200.sql xray
psql -f correlate-condition-e-tamper-300.sql xray
psql -f correlate-condition-e-tamper-400.sql xray
psql -f correlate-condition-e-tamper-500.sql xray
psql -f correlate-condition-e-tamper-600.sql xray
psql -f correlate-condition-e-tamper-700.sql xray
psql -f correlate-condition-e-tamper-800.sql xray
psql -f correlate-condition-e-uods-100.sql xray
psql -f correlate-condition-e-uods-200.sql xray
psql -f correlate-condition-e-upside-down-meter-100.sql xray
psql -f correlate-condition-e-upside-down-meter-200.sql xray
psql -f correlate-condition-e-upside-down-meter-300.sql xray
psql -f correlate-condition-e-zero-use-100.sql xray
psql -f correlate-condition-e-zero-use-200.sql xray
psql -f correlate-condition-e-zero-use-300.sql xray

echo Run through gas correlation logic...
#these can all be run in parallel
psql -f correlate-condition-g-abnormal-usage-100.sql xray
psql -f correlate-condition-g-abnormal-usage-101.sql xray
psql -f correlate-condition-g-abnormal-usage-102.sql xray
psql -f correlate-condition-g-abnormal-usage-200.sql xray
psql -f correlate-condition-g-abnormal-usage-201.sql xray
psql -f correlate-condition-g-abnormal-usage-202.sql xray
psql -f correlate-condition-g-abnormal-usage-300.sql xray
psql -f correlate-condition-g-abnormal-usage-400.sql xray
psql -f correlate-condition-g-communication-issue-100.sql xray
psql -f correlate-condition-g-uods-100.sql xray
psql -f correlate-condition-g-zero-use-100.sql xray


echo done.
