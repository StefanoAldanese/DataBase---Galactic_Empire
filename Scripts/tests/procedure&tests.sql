-- Procedure Imperatore

-- 1. Procedura per assegnare le corporation (con la funzione determina_corporation) ai pianeti non assegnati e finire le guerre di conquista
-- tabelle coinvolte: Guerra_Conquista, Occupazione, Corporation, Divisione Imperiale


-- Esempio per concludere una guerra con perdite totali
BEGIN
    fine_guerra(
        p_data_inizio_guerra => TO_DATE('2416-01-01', 'YYYY-MM-DD'),
        p_nome_stella_principale => 'Helios',
        p_nome_pianeta => 'Terra',
        p_popolazione => 5000000,
        p_perdite_totali => 300
    );
    COMMIT;
END;
/

-- Esempio senza perdite
BEGIN
    fine_guerra(
        p_data_inizio_guerra => TO_DATE('2425-03-15', 'YYYY-MM-DD'),
        p_nome_stella_principale => 'Alpha',
        p_nome_pianeta => 'Nova',
        p_popolazione => 3000000
    );
    COMMIT;
END;
/





-- 2. Dichiara guerra, crea una guerra di conquista 
-- tabelle coinvolte: pianeta, guerra di conquista, gruppo ribelle, combatte1

-- Dichiariamo guerra su un pianeta che ha ribelli
BEGIN
    dichiara_guerra(
        p_nome_stella_principale => 'Helios',
        p_nome_pianeta => 'Terra',
        p_nome_operazione => 'Operazione Salvare la Terra',
        p_data_inizio => TO_DATE('2425-01-01', 'YYYY-MM-DD'),
        p_ha_ribelli => 1,  -- Pianeta con ribelli
        p_livello_pericolo => 2  -- Livello di pericolo altissimo/mortale ;-)
    );
    COMMIT;  -- Opzionale
END;






-- -----------------------------------------------------------------------------------------------------------------------

-- Procedura Generale

-- 1. Manda rinforzi a una guerra attiva, selezionando una divisione da inviare
-- tabelle coinvolte: divisione imperiale, guerra di conquista, combatte2

BEGIN
    assegna_divisione(
        p_data_inizio_guerra => TO_DATE('2425-01-01', 'YYYY-MM-DD'),
        p_nome_stella_principale => 'Helios',
        p_nome_pianeta => 'Terra',
        p_numero_armata => 'DIV00-002'
    );
    COMMIT;
END;
/


-- Controlliamo che le divisioni siano state assegnate correttamente alla guerra
select c.numero_armata 
from GUERRE_ATTIVE a join COMBATTE2 c 
on a.DATA_INIZIO = c.DATA_INIZIO
    and a.NOME_PIANETA = c.NOME_PIANETA
    and a.NOME_STELLA_PRINCIPALE = c.NOME_STELLA_PRINCIPALE
where a.NOME_PIANETA = 'Terra';



-- 2. Aggiunge nuovi effettivi a una divisione imperiale esistente, incrementandone il numero totale di soldati
-- Tabelle coinvolte: divisione imperiale

BEGIN
    rinforza_divisione(
        p_numero_armata => 'DIV00-001',
        p_effettivi_da_aggiungere => 200
    );
    COMMIT;
END;
/





-- -----------------------------------------------------------------------------------------------------------------------

-- Procedure Dirigente_Corporation

-- 1. Fai finanziare una guerra di conquista da parte di una corporation
-- tabelle coinvolte: Guerra_Conquista, Corporation, finanzia

BEGIN
    finanzia_guerra(
        p_nome_corporation => 'KRAXX Extractors',
        p_data_inizio_guerra => TO_DATE('2425-01-01','YYYY-MM-DD'),
        p_nome_stella_principale => 'Helios',
        p_nome_pianeta => 'Terra',
        p_valore_contributo => 150000
    );
    COMMIT;
END;
/

