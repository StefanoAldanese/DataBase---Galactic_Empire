-- Impediamo di immettere un numero di perdite superiore agli effettivi che andrebbe in negativo 
CREATE OR REPLACE TRIGGER check_perdite_NO_negative
BEFORE INSERT ON combatte2
FOR EACH ROW
DECLARE
    v_effettivi_disponibili NUMBER;
BEGIN
    -- Ottiene gli effettivi disponibili direttamente dalla vista
    SELECT Effettivi_Attuali INTO v_effettivi_disponibili
    FROM vista_effettivi_attuali
    WHERE numero_armata = :NEW.numero_armata;
    
    -- Verifica se le perdite superano gli effettivi disponibili
    IF :NEW.numero_perdite > v_effettivi_disponibili THEN
        RAISE_APPLICATION_ERROR(-20001, 
            'Errore: Perdite (' || :NEW.numero_perdite || ') superiori agli effettivi disponibili (' || 
            v_effettivi_disponibili || ') per la divisione ' || :NEW.numero_armata);
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 
            'Divisione ' || :NEW.numero_armata || ' non trovata nei registri imperiali');
END;
/


-- Approccio Abbandonato perche LENTO!
-- al crescere delle tuple in combatte2 può diventare via via più lento dato che le conta tutte!
/*
CREATE OR REPLACE TRIGGER check_perdite_NO_negative
AFTER INSERT OR UPDATE ON combatte2
DECLARE
    v_tuple_negative NUMBER;
BEGIN
    -- Conta le righe con perdite superiori agli effettivi
    SELECT COUNT(*) INTO v_tuple_negative
    FROM combatte2 c
    JOIN vista_effettivi_attuali v ON c.numero_armata = v.numero_armata
    WHERE c.numero_perdite > v.Effettivi_Attuali;

    -- Verifica dove ci sono le perdite negative ed annulla il commit se ne trova
    IF v_tuple_negative > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 
            'Trovate ' || v_tuple_negative || ' divisioni con perdite superiori agli effettivi disponibili');
    END IF;
END;
/
*/








-- -----------------------------------------------------------------------------------------------------------------------

-- Trigger per impedire l'inserimento di pianeti gioviani abitabili
CREATE OR REPLACE TRIGGER check_gioviano_abitabile
BEFORE INSERT OR UPDATE ON Pianeta
FOR EACH ROW
BEGIN
    IF :NEW.classe = 'Gioviani' AND :NEW.abitabilita = 1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Errore: I pianeti gioviani non possono essere abitabili, fisicamente non puoi viviere sul gas!');
    END IF;
END;
/






-- -----------------------------------------------------------------------------------------------------------------------
-- Oracole non consente trigger multitabella quindi ci avvaliamo di 2 trigger che si controllano a vicenda prima dell'inserimento :-<

-- Trigger per impedire la saturazione della capacità di carico delle navi mercantili
CREATE OR REPLACE TRIGGER check_capacita_carico_max_armi
BEFORE INSERT ON viene_trasportato_attraverso_armi
FOR EACH ROW
DECLARE
    v_capacita_max NUMBER;
    v_carico_minerali NUMBER;
    v_carico_armi NUMBER;
    v_carico_totale NUMBER;
BEGIN
    SELECT nm.capacita_carico_max INTO v_capacita_max
    FROM Navi_mercantili nm
    WHERE nm.nome_nave = :NEW.nome_nave;

    SELECT NVL(SUM(vm.quantita_cargo), 0) INTO v_carico_minerali
    FROM viene_trasportato_attraverso_minerali vm
    WHERE vm.data_inizio_viaggio = :NEW.data_inizio_viaggio
      AND vm.nome_nave = :NEW.nome_nave;

    SELECT NVL(SUM(va.quantita_cargo_armi), 0) INTO v_carico_armi
    FROM viene_trasportato_attraverso_armi va
    WHERE va.data_inizio_viaggio = :NEW.data_inizio_viaggio
      AND va.nome_nave = :NEW.nome_nave;

    -- Includi il nuovo carico in inserimento
    v_carico_totale := v_carico_minerali + v_carico_armi + :NEW.quantita_cargo_armi;

    IF v_carico_totale > v_capacita_max THEN
        RAISE_APPLICATION_ERROR(-20004,
            'Errore: Carico totale (' || v_carico_totale || ') supera capacità nave (' || v_capacita_max || ')');
    END IF;
END;
/


-- Trigger per impedire la saturazione della capacità di carico delle navi mercantili
CREATE OR REPLACE TRIGGER check_capacita_carico_max_minerali
BEFORE INSERT ON viene_trasportato_attraverso_minerali
FOR EACH ROW
DECLARE
    v_capacita_max NUMBER;
    v_carico_minerali NUMBER;
    v_carico_armi NUMBER;
    v_carico_totale NUMBER;
BEGIN
    SELECT nm.capacita_carico_max INTO v_capacita_max
    FROM Navi_mercantili nm
    WHERE nm.nome_nave = :NEW.nome_nave;

    SELECT NVL(SUM(vm.quantita_cargo), 0) INTO v_carico_minerali
    FROM viene_trasportato_attraverso_minerali vm
    WHERE vm.data_inizio_viaggio = :NEW.data_inizio_viaggio
      AND vm.nome_nave = :NEW.nome_nave;

    SELECT NVL(SUM(va.quantita_cargo_armi), 0) INTO v_carico_armi
    FROM viene_trasportato_attraverso_armi va
    WHERE va.data_inizio_viaggio = :NEW.data_inizio_viaggio
      AND va.nome_nave = :NEW.nome_nave;

    -- Includi il nuovo carico in inserimento
    v_carico_totale := v_carico_minerali + v_carico_armi + :NEW.quantita_cargo;

    IF v_carico_totale > v_capacita_max THEN
        RAISE_APPLICATION_ERROR(-20004,
            'Errore: Carico totale (' || v_carico_totale || ') supera capacità nave (' || v_capacita_max || ')');
    END IF;
END;
/






-- -----------------------------------------------------------------------------------------------------------------------
-- Trigger per impedire l'inserimento di una nuova guerra su un pianeta che ha già una guerra attiva
CREATE OR REPLACE TRIGGER check_guerra_attiva
BEFORE INSERT ON Guerra_Conquista
FOR EACH ROW
DECLARE
    guerra_attiva NUMBER;
BEGIN
    -- Controlla se esiste già una guerra attiva per questo pianeta (contiamo le guerre che non hanno ancora una data_fine/Non hanno l'occupazione associata)
    SELECT COUNT(*) INTO guerra_attiva
    FROM Guerra_Conquista gc
    LEFT JOIN Occupazione o ON gc.data_inizio = o.data_inizio 
                          AND gc.nome_stella_principale = o.nome_stella_principale 
                          AND gc.nome_pianeta = o.nome_pianeta
    WHERE gc.nome_stella_principale = :NEW.nome_stella_principale
    AND gc.nome_pianeta = :NEW.nome_pianeta
    AND o.anno_conquista IS NULL;
    
    IF guerra_attiva > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Esiste già una guerra attiva per il pianeta ' || :NEW.nome_pianeta || ' nel sistema ' || :NEW.nome_stella_principale);
    END IF;
END;
/






-- -----------------------------------------------------------------------------------------------------------------------
-- Trigger per impedire l'inserimento di una guerra con data di inizio precedente all'ultima occupazione sul quel pianeta
CREATE OR REPLACE TRIGGER check_data_guerra
BEFORE INSERT ON Guerra_Conquista
FOR EACH ROW
DECLARE
    v_ultima_occupazione DATE;
BEGIN
    -- Ottimizzazione: usa subquery con MAX invece di join
    SELECT MAX(anno_conquista)
    INTO v_ultima_occupazione
    FROM Occupazione
    WHERE nome_stella_principale = :NEW.nome_stella_principale
    AND nome_pianeta = :NEW.nome_pianeta;
    
    -- Se esiste un'occupazione precedente e la nuova guerra inizia prima
    IF :NEW.data_inizio < v_ultima_occupazione AND v_ultima_occupazione IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Data guerra (' || TO_CHAR(:NEW.data_inizio, 'YYYY-MM-DD') || 
                               ') precedente all''ultima occupazione (' || 
                               TO_CHAR(v_ultima_occupazione, 'YYYY-MM-DD') || ')');
    END IF;
END;
/





-- -----------------------------------------------------------------------------------------------------------------------
-- Occupazione deve essere dopo l'inizio dell'ultima guerra attiva
CREATE OR REPLACE TRIGGER check_data_occupazione
BEFORE INSERT ON Occupazione
FOR EACH ROW
DECLARE
    data_inizio_guerra DATE;
BEGIN
    -- Ottiene la data di inizio dell'ultima guerra per questo pianeta
    SELECT MAX(data_inizio) INTO data_inizio_guerra
    FROM Guerra_Conquista
    WHERE nome_stella_principale = :NEW.nome_stella_principale
    AND nome_pianeta = :NEW.nome_pianeta;
    
    -- Verifica che la data di occupazione sia successiva alla data di inizio guerra
    IF :NEW.anno_conquista < data_inizio_guerra THEN
        RAISE_APPLICATION_ERROR(-20002, 'La data di occupazione deve essere successiva alla data di inizio della guerra');
    END IF;
END;
/





-- -----------------------------------------------------------------------------------------------------------------------
-- Non si pùò inserire un occupazione senza prima inizare una guerra
CREATE OR REPLACE TRIGGER check_guerra_prima_di_occupazione
BEFORE INSERT ON Occupazione
FOR EACH ROW
DECLARE
    v_guerra_esiste NUMBER;
BEGIN
    -- Verifica se esiste una guerra corrispondente
    SELECT COUNT(*) INTO v_guerra_esiste
    FROM Guerra_Conquista
    WHERE data_inizio = :NEW.data_inizio
    AND nome_stella_principale = :NEW.nome_stella_principale
    AND nome_pianeta = :NEW.nome_pianeta;
    
    -- Se non esiste la guerra corrispondente
    IF v_guerra_esiste = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 
            'Non è possibile inserire un''occupazione senza una corrispondente guerra. ' ||
            'Prima crea una guerra per ' || :NEW.nome_pianeta || 
            ' nel sistema ' || :NEW.nome_stella_principale);
    END IF;
END;
/






-- -----------------------------------------------------------------------------------------------------------------------
-- Viaggio non può partire/arrivare su pianeta con guerra attiva, non usiamo l'altra vista dato che non vogliamo complicare il trigger
-- in più ci potrebbero essere errori di mutating table (trigger lanciato sulla stessa tabella su cui agisce la view)
CREATE OR REPLACE TRIGGER check_viaggio_guerra_attiva
BEFORE INSERT ON Viaggio
FOR EACH ROW
DECLARE
    guerra_attiva_partenza NUMBER;
    guerra_attiva_destinazione NUMBER;
BEGIN
    -- Controlla guerra attiva al pianeta di partenza
    SELECT COUNT(*) INTO guerra_attiva_partenza
    FROM Guerra_Conquista gc
    LEFT JOIN Occupazione o ON gc.data_inizio = o.data_inizio 
                          AND gc.nome_stella_principale = o.nome_stella_principale 
                          AND gc.nome_pianeta = o.nome_pianeta
    WHERE gc.nome_stella_principale = :NEW.nome_stella_principale_partenza
    AND gc.nome_pianeta = :NEW.nome_pianeta_partenza
    AND o.anno_conquista IS NULL;
    
    -- Controlla guerra attiva al pianeta di destinazione
    SELECT COUNT(*) INTO guerra_attiva_destinazione
    FROM Guerra_Conquista gc
    LEFT JOIN Occupazione o ON gc.data_inizio = o.data_inizio 
                          AND gc.nome_stella_principale = o.nome_stella_principale 
                          AND gc.nome_pianeta = o.nome_pianeta
    WHERE gc.nome_stella_principale = :NEW.nome_stella_principale_destinazione
    AND gc.nome_pianeta = :NEW.nome_pianeta_destinazione
    AND o.anno_conquista IS NULL;
    
    IF guerra_attiva_partenza > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 
            'Viaggio bloccato: guerra attiva sul pianeta di partenza (' || 
            :NEW.nome_pianeta_partenza || ')');
    END IF;
    
    -- Controllo separato per destinazione
    IF guerra_attiva_destinazione > 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 
            'Viaggio bloccato: guerra attiva sul pianeta di destinazione (' || 
            :NEW.nome_pianeta_destinazione || ')');
    END IF;
END;
/






-- -----------------------------------------------------------------------------------------------------------------------
-- Trigger per impedire l'inserimento di un viaggio con partenza e destinazione uguali

CREATE OR REPLACE TRIGGER check_viaggio_stessa_destinazione
BEFORE INSERT ON Viaggio
FOR EACH ROW
BEGIN
    -- Verifica se il pianeta di partenza e destinazione sono uguali
    IF :NEW.nome_pianeta_partenza = :NEW.nome_pianeta_destinazione AND
       :NEW.nome_stella_principale_partenza = :NEW.nome_stella_principale_destinazione THEN
       
        RAISE_APPLICATION_ERROR(-20005, 
            'Il viaggio non può avere lo stesso pianeta di partenza e destinazione: ' ||
            :NEW.nome_pianeta_partenza || ' nel sistema ' || 
            :NEW.nome_stella_principale_partenza);
    END IF;
END;
/





