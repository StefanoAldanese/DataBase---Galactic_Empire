-- Procedure Imperatore

-- 1. Procedura per assegnare le corporation (con la funzione determina_corporation) ai pianeti non assegnati e finire le guerre di conquista
-- tabelle coinvolte: Guerra_Conquista, Occupazione, Corporation, Divisione Imperiale
CREATE OR REPLACE PROCEDURE fine_guerra (
    p_data_inizio_guerra IN DATE,
    p_nome_stella_principale IN VARCHAR2,
    p_nome_pianeta IN VARCHAR2,
    p_popolazione IN NUMBER, -- la popolazione è una variabile messa all'inserimento per la creazione della nuova tupla Occupazione
    p_perdite_totali IN NUMBER DEFAULT 0 -- Default: 0, nessuna perdita
)
IS
    v_corporation_scelta VARCHAR2(50);
    v_anno_conquista DATE := SYSDATE + 100*365; -- Usa la data corrente (+ 100 anni) di quando viene lanciata la procedura
    v_divisioni_coinvolte NUMBER;
    v_perdite_per_divisione NUMBER;
BEGIN

   -- Calcola e distribuisce le perdite tra le divisioni coinvolte
    IF p_perdite_totali > 0 THEN
        -- Conta quante divisioni hanno partecipato alla guerra
        SELECT COUNT(*) INTO v_divisioni_coinvolte
        FROM combatte2
        WHERE data_inizio = p_data_inizio_guerra
          AND nome_stella_principale = p_nome_stella_principale
          AND nome_pianeta = p_nome_pianeta;
        
        IF v_divisioni_coinvolte = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Attenzione: Perdite totali specificate (' || p_perdite_totali || 
                                ') ma nessuna divisione imperiale risulta coinvolta nella guerra.');
        ELSE
            -- Calcola perdite per divisione (distribuzione equa -> potremmo assegnare le perdite in modo casuale, ma è così è più semplice da implementare)
            v_perdite_per_divisione := FLOOR(p_perdite_totali / v_divisioni_coinvolte);
            
            -- Aggiorna le perdite per ogni divisione e verifica se è stata distrutta
            FOR divisione IN (
                SELECT d.numero_armata, d.nome_armata, d.effettivi AS Effettivi_Originali,
                       NVL(SUM(c.numero_perdite), 0) AS Perdite_Totali
                FROM Divisione_Imperiale d
                LEFT JOIN combatte2 c ON d.numero_armata = c.numero_armata
                WHERE c.data_inizio = p_data_inizio_guerra
                  AND c.nome_stella_principale = p_nome_stella_principale
                  AND c.nome_pianeta = p_nome_pianeta
                GROUP BY d.numero_armata, d.nome_armata, d.effettivi
            ) LOOP
                UPDATE combatte2
                SET numero_perdite = NVL(numero_perdite, 0) + v_perdite_per_divisione
                WHERE data_inizio = p_data_inizio_guerra
                  AND nome_stella_principale = p_nome_stella_principale
                  AND nome_pianeta = p_nome_pianeta
                  AND numero_armata = divisione.numero_armata;
                
                -- Verifica se la divisione è stata distrutta e manda il messaggio di distruzione
                -- Abbiamo fatto in modo che le perdite vengono calcolate solo alla fine della guerra, quindi non ci sono perdite parziali (mid-guerra)
                IF (divisione.Perdite_Totali + v_perdite_per_divisione) >= divisione.Effettivi_Originali THEN
                    DBMS_OUTPUT.PUT_LINE('Divisione distrutta: ' || divisione.nome_armata || 
                                        ' (Codice: ' || divisione.numero_armata || 
                                        '), Perdite: ' || (divisione.Perdite_Totali + v_perdite_per_divisione) || 
                                        '/' || divisione.Effettivi_Originali);
                ELSE
                    DBMS_OUTPUT.PUT_LINE('Aggiornate ' || v_perdite_per_divisione || 
                                        ' perdite per la divisione ' || divisione.numero_armata);
                END IF;
            END LOOP;
        END IF;
    END IF;
    
    -- Usa la funzione determina_corporation per assegnare una corporation al pianeta conquistato
    v_corporation_scelta := determina_corporation(
        p_data_inizio => p_data_inizio_guerra,
        p_stella_principale => p_nome_stella_principale,
        p_pianeta => p_nome_pianeta
    );
    
    INSERT INTO Occupazione (
        anno_conquista,
        nome_stella_principale,
        nome_pianeta,
        data_inizio,
        popolazione,
        nome_corporation
    ) VALUES (
        v_anno_conquista,   -- Usa SYSDATE qui
        p_nome_stella_principale,
        p_nome_pianeta,
        p_data_inizio_guerra,
        p_popolazione,
        v_corporation_scelta
    );
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Guerra conclusa con successo. Corporation ' || v_corporation_scelta || 
                         ' assegnata al pianeta ' || p_nome_pianeta || ' nel sistema ' || p_nome_stella_principale ||
                         ' in data ' || TO_CHAR(v_anno_conquista, 'DD/MM/YYYY') ||
                         '. Perdite totali: ' || p_perdite_totali);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Errore durante la conclusione della guerra: ' || SQLERRM);
        RAISE;
END fine_guerra;
/






-- 2. Dichiara guerra, crea una guerra di conquista 
-- tabelle coinvolte: pianeta, guerra di conquista, gruppo ribelle, combatte1

CREATE OR REPLACE PROCEDURE dichiara_guerra(
    p_nome_stella_principale IN VARCHAR2,
    p_nome_pianeta IN VARCHAR2,
    p_nome_operazione IN VARCHAR2,
    p_ha_ribelli IN NUMBER DEFAULT 0, -- 0 = no ribelli, 1 = con ribelli (DEFAULT: pianeta disabitato)
    p_livello_pericolo IN NUMBER DEFAULT 0 -- l'Impero prima di attaccare fa una ricognizione per stabilire il livello di pericolo (DEFAULT: 0, pianeta disabitato) 
)
IS
    v_esiste_ribelli NUMBER;
    v_nome_armata_ribelle VARCHAR2(50);
    v_e_abitabile NUMBER;
    v_data_inizio DATE := SYSDATE + 100*365; -- Usa la data corrente (+ 100 anni) di quando viene lanciata la procedura
BEGIN
    -- Verifica che il pianeta sia abitabile, dato che non facciamo guerre su pianeti inospitali
    SELECT abitabilita INTO v_e_abitabile
    FROM pianeta PI
    WHERE PI.nome_pianeta = p_nome_pianeta
        AND PI.nome_stella_principale = p_nome_stella_principale;

    IF v_e_abitabile = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Il pianeta ' || p_nome_pianeta || 
                               ' non è abitabile');
    END IF;

    -- Inserisce la nuova guerra
    INSERT INTO Guerra_Conquista (
        data_inizio,
        nome_stella_principale,
        nome_pianeta,
        nome_operazione
    ) VALUES (
        v_data_inizio,
        p_nome_stella_principale,
        p_nome_pianeta,
        p_nome_operazione
    );

    -- Se ci sono ribelli, crea o associa il gruppo ribelle
    IF p_ha_ribelli = 1 THEN
        v_nome_armata_ribelle := 'Ribelli ' || p_nome_stella_principale;

        -- Verifica se esiste già un gruppo ribelle per questo sistema
        SELECT COUNT(*) INTO v_esiste_ribelli
        FROM Gruppo_Ribelle
        WHERE nome_armata = v_nome_armata_ribelle;

        -- Se non esiste, lo crea
        IF v_esiste_ribelli = 0 THEN
            INSERT INTO Gruppo_Ribelle (
                nome_armata,
                livello_pericolo,
                stato
            ) VALUES (
                v_nome_armata_ribelle,
                p_livello_pericolo,
                'Attivo'
            );
        END IF;

        -- Associa il gruppo ribelle alla guerra
        INSERT INTO combatte1 (
            nome_armata_ribelle,
            data_inizio,
            nome_stella_principale,
            nome_pianeta
        ) VALUES (
            v_nome_armata_ribelle,
            v_data_inizio,
            p_nome_stella_principale,
            p_nome_pianeta
        );
    END IF;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Guerra dichiarata con successo sul pianeta ' || p_nome_pianeta || 
                        ' nel sistema ' || p_nome_stella_principale || 
                        ' con data inizio: ' || TO_CHAR(v_data_inizio, 'DD/MM/YYYY'));
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Errore durante la dichiarazione di guerra: ' || SQLERRM);
        RAISE;
END dichiara_guerra;
/








-- -----------------------------------------------------------------------------------------------------------------------

-- Procedura Generale

-- 1. Manda rinforzi a una guerra attiva, selezionando una divisione da inviare che abbiamo un numero minimo di compoenti per essere inviata
-- tabelle coinvolte: divisione imperiale, guerra di conquista, combatte2

CREATE OR REPLACE PROCEDURE assegna_divisione(
    p_data_inizio_guerra IN DATE,
    p_nome_stella_principale IN VARCHAR2,
    p_nome_pianeta IN VARCHAR2,
    p_numero_armata IN VARCHAR2
)
IS
    v_guerra_attiva NUMBER;
    v_divisione_esiste NUMBER;
    v_divisione_gia_inviata NUMBER;
    v_effettivi_attuali NUMBER;
    v_min_effettivi NUMBER := 100; -- Soglia minima di effettivi
BEGIN
    -- Verifica che la divisione abbia abbastanza effettivi
    SELECT Effettivi_Attuali INTO v_effettivi_attuali
    FROM vista_effettivi_attuali
    WHERE numero_armata = p_numero_armata;
    
    IF v_effettivi_attuali < v_min_effettivi THEN
        RAISE_APPLICATION_ERROR(-20001, 'La divisione ' || p_numero_armata || 
                               ' ha solo ' || v_effettivi_attuali || 
                               ' effettivi disponibili (minimo richiesto: ' || v_min_effettivi || ')');
    END IF;
    
    -- Verifica che la guerra esista ed è attiva
    SELECT COUNT(*) INTO v_guerra_attiva
    FROM vista_guerre_attive
    WHERE data_inizio = p_data_inizio_guerra
      AND nome_stella_principale = p_nome_stella_principale
      AND nome_pianeta = p_nome_pianeta;
    
    IF v_guerra_attiva = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'La guerra specificata non esiste o è gia conclusa');
    END IF;
    
    -- Verifica che la divisione non sia gia stata assegnata a questa guerra
    SELECT COUNT(*) INTO v_divisione_gia_inviata
    FROM combatte2
    WHERE data_inizio = p_data_inizio_guerra
      AND nome_stella_principale = p_nome_stella_principale
      AND nome_pianeta = p_nome_pianeta
      AND numero_armata = p_numero_armata;
    
    IF v_divisione_gia_inviata > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'La divisione ' || p_numero_armata || 
                               ' è gia stata assegnata a questa guerra');
    END IF;
    
    -- Inserisce la divisione nella guerra
    INSERT INTO combatte2 (
        numero_armata,
        data_inizio,
        nome_stella_principale,
        nome_pianeta,
        numero_perdite
    ) VALUES (
        p_numero_armata,
        p_data_inizio_guerra,
        p_nome_stella_principale,
        p_nome_pianeta,
        0 -- Inizialmente le perdite sono 0
    );
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Rinforzi inviati con successo. Divisione ' || p_numero_armata || 
                         ' assegnata alla guerra su ' || p_nome_pianeta || 
                         ' nel sistema ' || p_nome_stella_principale || 
                         ' con ' || v_effettivi_attuali || ' effettivi disponibili');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Errore: Divisione ' || p_numero_armata || ' non trovata');
        RAISE;
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Errore durante l''invio dei rinforzi: ' || SQLERRM);
        RAISE;
END assegna_divisione;
/





-- 2. Aggiunge nuovi effettivi a una divisione imperiale esistente, incrementandone il numero totale di soldati
-- Tabelle coinvolte: divisione imperiale

CREATE OR REPLACE PROCEDURE rinforza_divisione(
    p_numero_armata IN VARCHAR2,
    p_effettivi_da_aggiungere IN NUMBER
) AS
    v_effettivi_attuali NUMBER;
    v_effettivi_nuovi NUMBER;
BEGIN
    -- Verifica che gli effettivi da aggiungere siano positivi
    IF p_effettivi_da_aggiungere <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Il numero di effettivi da aggiungere deve essere positivo');
    END IF;
    
    -- Recupera gli effettivi attuali della divisione
    SELECT effettivi INTO v_effettivi_attuali
    FROM Divisione_Imperiale
    WHERE numero_armata = p_numero_armata;
    
    -- Calcola i nuovi effettivi
    v_effettivi_nuovi := v_effettivi_attuali + p_effettivi_da_aggiungere;
    
    -- Esegui l'aggiornamento
    UPDATE Divisione_Imperiale
    SET effettivi = v_effettivi_nuovi
    WHERE numero_armata = p_numero_armata;
    
    -- Output di conferma
    DBMS_OUTPUT.PUT_LINE('Divisione ' || p_numero_armata || ' aggiornata:');
    DBMS_OUTPUT.PUT_LINE('Effettivi precedenti: ' || v_effettivi_attuali);
    DBMS_OUTPUT.PUT_LINE('Effettivi incrementare : ' || v_effettivi_nuovi);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'Divisione con numero armata ' || p_numero_armata || ' non trovata');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20004, 'Errore durante l''aggiornamento: ' || SQLERRM);
END rinforza_divisione;
/




-- -----------------------------------------------------------------------------------------------------------------------

-- Procedure Dirigente_Corporation

-- 1. Fai finanziare una guerra di conquista da parte di una corporation
-- tabelle coinvolte: Guerra_Conquista, Corporation, finanzia

CREATE OR REPLACE PROCEDURE finanzia_guerra(
    p_nome_corporation IN VARCHAR2,
    p_data_inizio_guerra IN DATE,
    p_nome_stella_principale IN VARCHAR2,
    p_nome_pianeta IN VARCHAR2,
    p_valore_contributo IN NUMBER
)
IS
    v_min_contributo NUMBER;
BEGIN
    -- Verifica se esiste gia un finanziamento per questa guerra
    SELECT MIN(valore_contributo)
    INTO v_min_contributo
    FROM finanzia
    WHERE data_inizio = p_data_inizio_guerra
      AND nome_stella_principale = p_nome_stella_principale
      AND nome_pianeta = p_nome_pianeta;
    
    -- Se esiste un finanziamento precedente e il nuovo è minore, dai errore
    IF v_min_contributo IS NOT NULL AND p_valore_contributo < v_min_contributo THEN
        RAISE_APPLICATION_ERROR(-20001, 'Il finanziamento non può essere inferiore a ' || v_min_contributo || ' a quelli gia fatti per questa guerra.
        L impero non accetta lowballing');
    END IF;
    
    -- Inserisce il finanziamento
    INSERT INTO finanzia (
        nome_corporation,
        data_inizio,
        nome_stella_principale,
        nome_pianeta,
        valore_contributo
    ) VALUES (
        p_nome_corporation,
        p_data_inizio_guerra,
        p_nome_stella_principale,
        p_nome_pianeta,
        p_valore_contributo
    );
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Finanziamento registrato con successo. ' || 
                         p_nome_corporation || ' ha contribuito con ' || 
                         p_valore_contributo || ' alla guerra su ' || 
                         p_nome_pianeta || ' nel sistema ' || p_nome_stella_principale);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Nessun finanziamento esistente, procedi con l'inserimento
        INSERT INTO finanzia (
            nome_corporation,
            data_inizio,
            nome_stella_principale,
            nome_pianeta,
            valore_contributo
        ) VALUES (
            p_nome_corporation,
            p_data_inizio_guerra,
            p_nome_stella_principale,
            p_nome_pianeta,
            p_valore_contributo
        );
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Finanziamento registrato con successo. ' || 
                             p_nome_corporation || ' ha contribuito con ' || 
                             p_valore_contributo || ' alla guerra su ' || 
                             p_nome_pianeta || ' nel sistema ' || p_nome_stella_principale);
    
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Errore durante il finanziamento della guerra: ' || SQLERRM);
        RAISE;
END finanzia_guerra;
/
