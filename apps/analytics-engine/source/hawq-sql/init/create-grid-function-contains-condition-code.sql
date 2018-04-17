/*
 * Checks whether the input array contains a condition and its count is equal or
 * greater than the threshold.
 * 
 * Parameters:
 *     conditions - three-dimensional array representing condition code and count
 *     c_code - condition code
 *     threshold - condition threshold
 *
 */
CREATE OR REPLACE FUNCTION grid.contains_condition_code(conditions text[][][], c_code text, threshold int) RETURNS boolean AS $$ 
BEGIN
    
    FOR x IN 1..array_upper($1, 1) LOOP
        IF $1[x][1] = $2 AND CAST($1[x][3] AS INT) >= $3 THEN 
            RETURN true; 
        END IF;
    END LOOP;
    
    RETURN false;
END;
$$ LANGUAGE plpgsql;
