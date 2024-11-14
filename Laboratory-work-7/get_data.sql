CREATE OR REPLACE FUNCTION get_data(attribute_value VARCHAR)
RETURNS TABLE(a_id INTEGER, name VARCHAR, year INTEGER, confidentiality_label INTEGER) AS $$
DECLARE
    query TEXT;
BEGIN
    query := 'SELECT * FROM auto WHERE name = ''' || attribute_value || ''';';
    RETURN QUERY EXECUTE query;
END;
$$ LANGUAGE plpgsql;
