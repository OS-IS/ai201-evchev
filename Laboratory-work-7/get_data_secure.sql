CREATE OR REPLACE FUNCTION get_data_safe(attribute_value VARCHAR)
RETURNS TABLE(a_id INTEGER, name VARCHAR, year INTEGER, confidentiality_label INTEGER) AS $$
BEGIN
    RETURN QUERY EXECUTE format('SELECT * FROM auto WHERE name = %L', attribute_value);
END;
$$ LANGUAGE plpgsql;
