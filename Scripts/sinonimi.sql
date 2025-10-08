-- Creazione sinonimi per tutte le tabelle
BEGIN
  FOR i IN (SELECT table_name FROM all_tables WHERE owner = 'AMMINISTRATORE') LOOP
    EXECUTE IMMEDIATE 'CREATE OR REPLACE PUBLIC SYNONYM ' || i.table_name || ' FOR amministratore.' || i.table_name;
  END LOOP;
END;
/

-- Creazione sinonimi per le viste
BEGIN
  FOR j IN (SELECT view_name FROM all_views WHERE owner = 'AMMINISTRATORE') LOOP
    EXECUTE IMMEDIATE 'CREATE OR REPLACE PUBLIC SYNONYM ' || j.view_name || ' FOR amministratore.' || j.view_name;
  END LOOP;
END;
/

-- Creazione sinonimi per le funzioni
BEGIN
  FOR k IN (SELECT object_name FROM all_objects WHERE owner = 'AMMINISTRATORE' AND object_type = 'FUNCTION') LOOP
    EXECUTE IMMEDIATE 'CREATE OR REPLACE PUBLIC SYNONYM ' || k.object_name || ' FOR amministratore.' || k.object_name;
  END LOOP;
END;
/

-- Creazione sinonimi per le procedure
BEGIN
  FOR o IN (SELECT object_name FROM all_objects WHERE owner = 'AMMINISTRATORE' AND object_type = 'PROCEDURE') LOOP
    EXECUTE IMMEDIATE 'CREATE OR REPLACE PUBLIC SYNONYM ' || o.object_name || ' FOR amministratore.' || o.object_name;
  END LOOP;
END;
/
