-- Creazione dell'utente che possiede il Database: 
-- amministratore (Password: admin123)
create user amministratore identified by admin123;
GRANT ALL PRIVILEGES TO amministratore;



-- 1. Comando accesso come administrator (Le mie password sono: User SYSDBA  || password SYSDBA: 1peroGalattic0) 
--                                                  N.B: le tue saranno diverse, controlla la password al momento di instalalzione!
-- sqlplus sys/1peroGalattic0 AS SYSDBA

-- 2. Connetersi al PDB
-- select name from v$pdbs;

-- 3. Spostarsi dentro il PDB
--                               Y <- questo va messo con quel tuo PDB 
-- ALTER SESSION SET CONTAINER = XEPDB1;

-- 4. Lanciare i comandi di creazione del superuser (quelli in cima a questo file)

-- 5. Login come user possesore di databse
-- sqlplus amministratore/admin123@//localhost:1521/XEPDB1





-- END. Elimina lo user
-- DROP USER amministratore CASCADE;








-- creare un admin, pero si fa il dump dal punto di vista dell'admin non dell'amministratore di sistema 
