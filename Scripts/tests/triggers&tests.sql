---------------------------------------------------------------------------------------------------------------------------------------------
-- Impediamo di immettere un numero di perdite superiore agli effettivi che andrebbe in negativo 
-- Per via dell'errore mutating table, non consentiamo l'aggiornamento delle perdite, ma solo l'inserimento 


-- Capire su quale pianeta e stella è operativa l'armata
SELECT CC.NOME_STELLA_PRINCIPALE, CC.NOME_PIANETA , CC.DATA_INIZIO
FROM Divisione_Imperiale DI join COMBATTE2 CC on DI.NUMERO_ARMATA=CC.NUMERO_ARMATA
WHERE DI.numero_armata = 'DIV00-001';

-- Poi inseriamo un record con perdite maggiori rispetto agli effettivi andando in negativo
INSERT INTO combatte2 VALUES ('DIV00-006', TO_DATE('2323-01-03','YYYY-MM-DD'), 'Gamma', 'Selene', 1001);









-- -----------------------------------------------------------------------------------------------------------------------
-- Trigger per impedire l'inserimento di pianeti gioviani abitabili

-- Questo inserimento dovrebbe fallire
INSERT INTO Pianeta VALUES ('Test', 'Helios', 'Gioviani', 1);

-- Questi inserimenti dovrebbero riuscire
INSERT INTO Pianeta VALUES ('Test', 'Helios', 'Gioviani', 0);
INSERT INTO Pianeta VALUES ('Test', 'Helios', 'Terrestre', 1);








-- -----------------------------------------------------------------------------------------------------------------------
-- Oracole non consente trigger multitabella quindi ci avvaliamo di 2 trigger che si controllano a vicenda prima dell'inserimento
-- Trigger per impedire la saturazione della capacità di carico delle navi mercantili

-- Test: saturazione nave con minerali (ok), aggiunta armi (fail)
INSERT INTO viene_trasportato_attraverso_minerali VALUES ('STE00-3003', TO_DATE('2424-03-15','YYYY-MM-DD'), 'Starfarer', 2000); 
INSERT INTO viene_trasportato_attraverso_armi VALUES ('TARKON Armaments', 'LaserCannonOZ-32', 'Laser', TO_DATE('2424-03-15','YYYY-MM-DD'), 'Starfarer', 1); 

-- Test2: saturazione nave con armi (ok), aggiunta minerali (fail)
INSERT INTO viene_trasportato_attraverso_armi VALUES ('TARKON Armaments', 'LaserCannonOZ-32', 'Laser', TO_DATE('2424-03-15','YYYY-MM-DD'), 'Starfarer', 2000); 
INSERT INTO viene_trasportato_attraverso_minerali VALUES ('STE00-3003', TO_DATE('2424-03-15','YYYY-MM-DD'), 'Starfarer', 1);







-- -----------------------------------------------------------------------------------------------------------------------
-- Trigger per impedire l'inserimento di una nuova guerra su un pianeta che ha già una guerra attiva

-- Questo pianeta ha già una guerra in corso e non è ancora stato occupato: Terra nel sistema Helios ha una Guerra_Conquista senza Occupazione
INSERT INTO Guerra_Conquista VALUES (TO_DATE('2500-02-01', 'YYYY-MM-DD'), 'Beta', 'Rhea', 'Operazione Duplicata');








-- -----------------------------------------------------------------------------------------------------------------------
-- Trigger per impedire l'inserimento di una guerra con data di inizio precedente all'ultima occupazione sul quel pianeta

-- Questo pianeta ha già un occupazione e proviamo ad inserire una guerra con data di inizio precedente all'occupazione
INSERT INTO Guerra_Conquista VALUES (TO_DATE('1100-02-01', 'YYYY-MM-DD'), 'Helios', 'Terra', 'Operazione Duplicata');









-- -----------------------------------------------------------------------------------------------------------------------
-- Occupazione deve essere dopo l'inizio dell'ultima guerra attiva

-- Inserviamo un occupazione con data d'inizio precedere alla data di inizio della guerra
INSERT INTO Occupazione VALUES (TO_DATE('2399-12-31','YYYY-MM-DD'),'Helios','Terra',TO_DATE('2400-01-01','YYYY-MM-DD'),5000000,'KRAXX Extractors');









-- -----------------------------------------------------------------------------------------------------------------------
-- Non si pùò inserire un occupazione senza prima inizare una guerra

-- Inseriamo un'occupazione senza prima fare una guerra
INSERT INTO Occupazione VALUES (TO_DATE('2501-01-01','YYYY-MM-DD'),'Alpha','Nova',TO_DATE('2500-01-01','YYYY-MM-DD'),3000000,'TARKON Armaments');










-- -----------------------------------------------------------------------------------------------------------------------
-- Viaggio non può partire/arrivare su pianeta con guerra attiva, non usiamo l'altra vista dato che non vogliamo complicare il trigger
-- in più ci potrebbero essere errori di mutating table (trigger lanciato sulla stessa tabella su cui agisce la view)

-- Inseriamo un viaggio che parte da un pianeta con guerra attiva
INSERT INTO Viaggio VALUES (TO_DATE('2500-02-01','YYYY-MM-DD'), NULL, 500, 'Carrack', NULL, 'Beta', 'Rhea', TO_DATE('2116-02-01','YYYY-MM-DD'), 'Terra', 'Helios', TO_DATE('2424-02-01','YYYY-MM-DD'), TO_DATE('2416-01-01','YYYY-MM-DD'));

-- Inseriamo un viaggio che arriva su un pianeta con guerra attiva
INSERT INTO Viaggio VALUES (TO_DATE('2500-02-01','YYYY-MM-DD'), NULL, 500, 'Carrack', TO_DATE('2424-02-01','YYYY-MM-DD'), 'Helios', 'Terra', TO_DATE('2416-01-01','YYYY-MM-DD'), 'Rhea', 'Beta', NULL, TO_DATE('2116-02-01','YYYY-MM-DD'));










-- -----------------------------------------------------------------------------------------------------------------------
-- Trigger per impedire l'inserimento di un viaggio con partenza e destinazione uguali


-- Inseriamo un viaggio con partenza e destinazione uguali
INSERT INTO Viaggio VALUES (TO_DATE('2500-03-01','YYYY-MM-DD'), NULL, 6969, 'Carrack', TO_DATE('2424-02-01','YYYY-MM-DD'), 'Helios', 'Terra', TO_DATE('2416-01-01','YYYY-MM-DD'), 'Terra', 'Helios', TO_DATE('2424-02-01','YYYY-MM-DD'), TO_DATE('2416-01-01','YYYY-MM-DD'));









-- -----------------------------------------------------------------------------------------------------------------------
-- Trigger per garantire che una divisione non possa essere assegnata a più guerre attive contemporaneamente










-- -----------------------------------------------------------------------------------------------------------------------
-- Trigger per garantire che una divisione non possa essere assegnata a una guerra 
-- se gli effettivi disponibili sono inferiori a una soglia minima (100 in questo caso)
