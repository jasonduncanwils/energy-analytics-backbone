/*
 * Calculates an array of the dates required for a period of usage 
 * 
 * Parameters:
 *     enddate - stop date of the usage 
 *     totalsec - total seconds in the period 
 *     secperinterval - seconds per interval of time 
 *
 */
CREATE OR REPLACE FUNCTION data_sim.getusagedates (enddate timestamp, totalsec int, secperinterval int) 
returns text[]
as $$
DECLARE
    v_iterations       int;
    v_date_array       text[];
BEGIN
    
    v_iterations := floor($2/$3);
    
    FOR i IN 1..v_iterations
    LOOP
        v_date_array[i] := $1 - CAST(((i-1) * $3)||' second' AS INTERVAL);
    END LOOP;
    
    RETURN v_date_array;
    
END;
$$ LANGUAGE plpgsql;