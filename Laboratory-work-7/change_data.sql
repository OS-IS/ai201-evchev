CREATE OR REPLACE FUNCTION change_data(attribute1 VARCHAR, attribute2 VARCHAR)
RETURNS VOID AS $$
DECLARE
    query TEXT;
BEGIN
    query := 'UPDATE auto SET name = ''' || attribute2 || ''' WHERE name = ''' || attribute1 || ''';';
    EXECUTE query;
END;
$$ LANGUAGE plpgsql;
