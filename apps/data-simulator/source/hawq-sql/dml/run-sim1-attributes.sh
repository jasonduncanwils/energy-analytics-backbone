echo running attribute simulation...

# ************************************************************************ 
#        Populate simulator with data by running scripts below 
#              (this will refresh all data in the simulator)
# ************************************************************************ 
    
# ************************************************************************ 
echo clearing out all tables...
# ************************************************************************ 
psql -q -f data-sim-simulator-clear.sql xray

# ************************************************************************ 
echo populating sim parameter defaults...
# ************************************************************************ 
psql -q -f data-sim-populate-sim-parm-defaults.sql xray
    
# ************************************************************************ 
echo populate starting attributes...
# ************************************************************************ 
psql -q -f data-sim-populate-general.sql xray
psql -q -f data-sim-populate-address-attrs.sql xray
psql -q -f data-sim-populate-cust-attrs.sql xray

# ************************************************************************ 
echo stage full data strings for simulator...
# ************************************************************************ 
psql -q -f data-sim-stage-customers.sql xray
psql -q -f data-sim-stage-addresses.sql xray
psql -q -f data-sim-stage-meters.sql xray
psql -q -f data-sim-stage-service-pts.sql xray

# ************************************************************************ 
echo run statistics on data_sim schema...
# ************************************************************************ 
psql -q -f data-sim-stats.sql xray

# ************************************************************************ 
echo combine attributes to finalize records...
# ************************************************************************ 
psql -q -f data-sim-combine-attributes.sql xray

# ************************************************************************ 
echo run statistics on data_sim schema...
# ************************************************************************ 
psql -q -f data-sim-stats.sql xray


echo done. 
