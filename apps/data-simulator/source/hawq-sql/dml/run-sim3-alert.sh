echo running alert simulation...

# ************************************************************************ 
#           Create alerts for a period of time for service points 
#        (running this multiple times will produce different results)
# ************************************************************************ 

psql -q -f data-sim-simulator-alert.sql xray

# ************************************************************************ 
echo run statistics on data_sim schema...
# ************************************************************************ 
psql -q -f data-sim-stats.sql xray

echo done. 
