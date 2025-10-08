-- imperatore (Password: impero4ever)
-- sqlplus imperatore/impero4ever@//localhost:1521/XEPDB1
create user imperatore identified by impero4ever;
GRANT CREATE SESSION TO imperatore;
GRANT CONNECT TO imperatore;
-- Diamo il select su tutte le tabelle dato che il nostro imperatore è paranoico peggio di Kim Jong Un
BEGIN
  FOR i IN (SELECT table_name FROM all_tables WHERE owner = 'ADMIN') LOOP
    EXECUTE IMMEDIATE 'GRANT SELECT ON admin.' || i.table_name || ' TO imperatore';
  END LOOP;
END;
/
GRANT INSERT ON amministratore.Corporation TO imperatore;
GRANT EXECUTE ON amministratore.fine_guerra TO imperatore;
GRANT EXECUTE ON amministratore.dichiara_guerra TO imperatore;
GRANT EXECUTE ON amministratore.assegna_divisione TO imperatore;


-- generale (Password: hateyoda)
-- sqlplus generale/hateyoda@//localhost:1521/XEPDB1
create user generale identified by hateyoda;
GRANT CREATE SESSION TO generale;
GRANT CONNECT TO generale;
GRANT SELECT ON amministratore.vista_effettivi_attuali TO generale;
GRANT SELECT ON amministratore.vista_guerre_attive TO generale;
GRANT SELECT ON amministratore.vista_guerre_finite TO generale;
GRANT UPDATE ON amministratore.Gruppo_Ribelle TO generale;
GRANT SELECT, INSERT ON amministratore.Stazionamento TO generale;
GRANT SELECT, INSERT ON amministratore.e_presidiato TO generale;
GRANT SELECT, INSERT ON amministratore.Soth TO generale;
GRANT EXECUTE ON amministratore.fine_guerra TO generale;
GRANT EXECUTE ON amministratore.assegna_divisione TO generale;
GRANT EXECUTE ON amministratore.rinforza_divisione TO generale;


-- dirigente_corporation (Password: fatturato)
-- sqlplus dirigente_corporation/fatturato@//localhost:1521/XEPDB1
create user dirigente_corporation identified by fatturato;
GRANT CREATE SESSION TO dirigente_corporation;
GRANT CONNECT TO dirigente_corporation;
GRANT SELECT ON amministratore.Corporation TO dirigente_corporation;
GRANT SELECT, INSERT ON amministratore.Corporation_Bellica TO dirigente_corporation;
GRANT SELECT, INSERT ON amministratore.Corporation_Mineraria TO dirigente_corporation;
GRANT SELECT, INSERT ON amministratore.Corporation_Trasporti TO dirigente_corporation;
GRANT SELECT, INSERT ON amministratore.Viaggio TO dirigente_corporation;
GRANT EXECUTE ON amministratore.finanzia_guerra TO dirigente_corporation;




-- Se NON è stato eseguito lo script "sinonimi.sql":
-- Per fare le query dal punto di vista degli users mettere il suffisso "amministratore."
-- SELECT * FROM amministratore.Corporation;


