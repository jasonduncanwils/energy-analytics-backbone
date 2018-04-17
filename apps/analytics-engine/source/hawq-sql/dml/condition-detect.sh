echo Running condition detection...

echo setting groups to detection_pending...
psql -f insert-group-tracking-condition-detection-pending.sql xray

echo Upside Down Meter 1...
psql -f condition-detect-upside-down-meter-1.sql xray

echo setting groups to detection_complete...
psql -f insert-group-tracking-condition-detection-complete.sql xray

echo done.


