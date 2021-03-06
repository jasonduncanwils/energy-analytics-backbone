echo Running calculations...

echo setting groups to calc_pending...
psql -f insert-group-tracking-calc-pending.sql xray

echo performing service point calculations - singular - independent...
psql -f calc-service-point-singular-independent.sql xray

echo performing service point calculations - singular - specific date...
psql -f calc-service-point-singular-specific-date.sql xray

echo calculating Z score vs last month...
psql -f calc-service-point-zscore-last-month.sql xray

echo calculating Z score vs last year...
psql -f calc-service-point-zscore-last-year.sql xray

echo calculating average power factor...
psql -f calc-service-point-avg-pf.sql xray

echo performing service point calculations - singular - dependent - specific date...
psql -f calc-service-point-singular-dependent-specific-date.sql xray

echo setting groups to calc_complete...
psql -f insert-group-tracking-calc-complete.sql xray

echo done.


