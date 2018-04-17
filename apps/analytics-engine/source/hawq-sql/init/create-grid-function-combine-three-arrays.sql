CREATE OR REPLACE FUNCTION grid.combinethreearrays(text[],text[],text[]) 
RETURNS text[][][] 
AS $$
DECLARE
    v_combined_array text[][][];
BEGIN
 FOR x IN 1..array_upper($1, 1) 
 LOOP
     v_combined_array := v_combined_array|| ARRAY[[
                               $1[x], 
                               $2[x], 
                               $3[x]]]; 
 end loop; 
 return v_combined_array; 
END;
$$ LANGUAGE plpgsql; 