echo Destroying xray database and its schemas...
psql -q -f drop-xray-db.sql
psql -q -c "drop database xray"
echo Done. 


