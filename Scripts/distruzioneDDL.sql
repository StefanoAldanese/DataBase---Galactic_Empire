-- File: drop_all.sql
-- Questo file contiene tutti i comandi per eliminare completamente il database
-- Eseguilo come amministratore: sqlplus amministratore/admin123@//localhost:1521/XEPDB1

--%%%%%%%%      DROPPA LE TABELLE IN ORDINE DI DIPENDENZE
-- Le tabelle vengono eliminate in ordine inverso rispetto alle dipendenze per evitare errori di vincolo

-- Prima eliminiamo tutti gli utenti creati
DROP USER imperatore CASCADE;
DROP USER generale CASCADE;
DROP USER dirigente_corporation CASCADE;

-- Poi eliminiamo tutti i trigger
DROP TRIGGER check_perdite_NO_negative;
DROP TRIGGER check_gioviano_abitabile;
DROP TRIGGER check_capacita_carico_max_armi;
DROP TRIGGER check_capacita_carico_max_minerali;
DROP TRIGGER check_guerra_attiva;
DROP TRIGGER check_data_guerra;
DROP TRIGGER check_data_occupazione;
DROP TRIGGER check_guerra_prima_di_occupazione;
DROP TRIGGER check_viaggio_guerra_attiva;
DROP TRIGGER check_viaggio_stessa_destinazione;

-- Poi eliminiamo tutte le procedure e funzioni
DROP PROCEDURE fine_guerra;
DROP PROCEDURE dichiara_guerra;
DROP PROCEDURE assegna_divisione;
DROP PROCEDURE rinforza_divisione;
DROP PROCEDURE finanzia_guerra;
DROP FUNCTION determina_corporation;

-- Poi eliminiamo tutte le viste
DROP VIEW vista_effettivi_attuali;
DROP VIEW vista_guerre_attive;
DROP VIEW vista_guerre_finite;

-- Infine eliminiamo tutte le tabelle in ordine inverso di creazione
DROP TABLE Soth CASCADE CONSTRAINTS;
DROP TABLE e_presidiato CASCADE CONSTRAINTS;
DROP TABLE Stazionamento CASCADE CONSTRAINTS;
DROP TABLE viene_trasportato_attraverso_armi CASCADE CONSTRAINTS;
DROP TABLE viene_trasportato_attraverso_minerali CASCADE CONSTRAINTS;
DROP TABLE Ferro_Titanico CASCADE CONSTRAINTS;
DROP TABLE Nanosabbia_di_dune_profonde CASCADE CONSTRAINTS;
DROP TABLE Cristalli_di_plutonio CASCADE CONSTRAINTS;
DROP TABLE Viaggio CASCADE CONSTRAINTS;
DROP TABLE Navi_mercantili CASCADE CONSTRAINTS;
DROP TABLE Corporation_Trasporti CASCADE CONSTRAINTS;
DROP TABLE Navi_da_combattimento CASCADE CONSTRAINTS;
DROP TABLE Navi CASCADE CONSTRAINTS;
DROP TABLE Armi CASCADE CONSTRAINTS;
DROP TABLE Corporation_Bellica CASCADE CONSTRAINTS;
DROP TABLE Partita_di_minerali CASCADE CONSTRAINTS;
DROP TABLE Corporation_Mineraria CASCADE CONSTRAINTS;
DROP TABLE finanzia CASCADE CONSTRAINTS;
DROP TABLE Occupazione CASCADE CONSTRAINTS;
DROP TABLE Flotta CASCADE CONSTRAINTS;
DROP TABLE combatte2 CASCADE CONSTRAINTS;
DROP TABLE Divisione_Imperiale CASCADE CONSTRAINTS;
DROP TABLE combatte1 CASCADE CONSTRAINTS;
DROP TABLE Gruppo_Ribelle CASCADE CONSTRAINTS;
DROP TABLE Guerra_Conquista CASCADE CONSTRAINTS;
DROP TABLE Pianeta CASCADE CONSTRAINTS;
DROP TABLE Sistema_Planetario CASCADE CONSTRAINTS;
DROP TABLE Corporation CASCADE CONSTRAINTS;

-- Infine eliminiamo l'utente amministratore
-- Nota: per eliminare l'utente amministratore, devi essere connesso come SYSDBA
-- DROP USER amministratore CASCADE;

COMMIT;