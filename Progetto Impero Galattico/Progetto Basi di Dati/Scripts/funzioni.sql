-- Funzione per determinare la corporation migliore per un pianeta
-- la corporation primaria sia la corporation che ha finanaziamenti sulla guerra di conquista maggiori, 
-- ma se ha troppi pianeti (il 50% dell'intero sitema) sullo stesso sistema si considera di dare alla corporation nella seconda posizione. 
-- Se la guerra non è finanziata da nessuno allora il pianeta viene assegnato alla corporation che ha somma totale dei finanziamenti più alto in assoluto.


CREATE OR REPLACE FUNCTION determina_corporation(
    p_data_inizio DATE,
    p_stella_principale VARCHAR2,
    p_pianeta VARCHAR2
) RETURN VARCHAR2 
IS
    v_corporation_primaria VARCHAR2(50);
    v_corporation_secondaria VARCHAR2(50);
    v_corporation_assoluto VARCHAR2(50); -- Corporation con finanziamenti totali più alti
    v_totale_pianeti_sistema NUMBER;
    v_pianeti_corporation NUMBER;
    v_percentuale NUMBER;
    v_ha_finanziatori NUMBER;
BEGIN
    -- 1. Controlla se ci sono finanziatori per questa guerra specifica
    SELECT COUNT(*) INTO v_ha_finanziatori
    FROM finanzia f
    WHERE f.data_inizio = p_data_inizio
      AND f.nome_stella_principale = p_stella_principale
      AND f.nome_pianeta = p_pianeta;

    -- 2. Se ci sono finanziatori per questa guerra
    IF v_ha_finanziatori > 0 THEN
        -- Trova la corporation con il finanziamento maggiore per questa guerra
        BEGIN
            SELECT nome_corporation INTO v_corporation_primaria
            FROM (
                SELECT f.nome_corporation, SUM(f.valore_contributo) as totale_finanziamenti
                FROM finanzia f
                WHERE f.data_inizio = p_data_inizio
                  AND f.nome_stella_principale = p_stella_principale
                  AND f.nome_pianeta = p_pianeta
                GROUP BY f.nome_corporation
                HAVING SUM(f.valore_contributo) = (
                    SELECT MAX(SUM(f2.valore_contributo))
                    FROM finanzia f2
                    WHERE f2.data_inizio = p_data_inizio
                      AND f2.nome_stella_principale = p_stella_principale
                      AND f2.nome_pianeta = p_pianeta
                    GROUP BY f2.nome_corporation
                )
            );
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_corporation_primaria := NULL;
        END;

        -- Trova la seconda corporation per finanziamenti per questa guerra
        BEGIN
            SELECT nome_corporation INTO v_corporation_secondaria
            FROM (
                SELECT f.nome_corporation
                FROM finanzia f
                WHERE f.data_inizio = p_data_inizio
                  AND f.nome_stella_principale = p_stella_principale
                  AND f.nome_pianeta = p_pianeta
                  AND f.nome_corporation != v_corporation_primaria
                GROUP BY f.nome_corporation
                HAVING SUM(f.valore_contributo) = (
                    SELECT MAX(SUM(f2.valore_contributo))
                    FROM finanzia f2
                    WHERE f2.data_inizio = p_data_inizio
                      AND f2.nome_stella_principale = p_stella_principale
                      AND f2.nome_pianeta = p_pianeta
                      AND f2.nome_corporation != v_corporation_primaria
                    GROUP BY f2.nome_corporation
                )
            );
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_corporation_secondaria := NULL;
        END;

        -- Conta quanti pianeti ci sono nel sistema
        SELECT COUNT(*) INTO v_totale_pianeti_sistema
        FROM Pianeta
        WHERE nome_stella_principale = p_stella_principale;

        -- Conta quanti pianeti la corporation primaria ha già nel sistema (cioè attorno alla stessa stella)
        IF v_corporation_primaria IS NOT NULL THEN
            SELECT COUNT(*) INTO v_pianeti_corporation
            FROM Occupazione o
            JOIN Guerra_Conquista g ON o.data_inizio = g.data_inizio
                                   AND o.nome_stella_principale = g.nome_stella_principale
                                   AND o.nome_pianeta = g.nome_pianeta
            WHERE o.nome_corporation = v_corporation_primaria
              AND g.nome_stella_principale = p_stella_principale;

            -- Calcola la percentuale
            v_percentuale := (v_pianeti_corporation / v_totale_pianeti_sistema) * 100;

            -- Se supera il 50%, usa la secondaria (se esiste)
            IF v_percentuale > 50 AND v_corporation_secondaria IS NOT NULL THEN
                RETURN v_corporation_secondaria;
            ELSIF v_percentuale > 50 AND v_corporation_secondaria IS NULL THEN
                -- Se non c'è una seconda corporation, passa al assoluto
                NULL; -- Continua alla corporation assoluta
            ELSE
                RETURN v_corporation_primaria;
            END IF;
        END IF;
    END IF;

    -- 3. Se non ci sono finanziatori per questa guerra o non si può assegnare la corporation primaria/secondaria
    -- Trova la corporation con il finanziamento totale più alto in assoluto
    BEGIN
        SELECT nome_corporation INTO v_corporation_assoluto
        FROM (
            SELECT f.nome_corporation, SUM(f.valore_contributo) as totale_finanziamenti
            FROM finanzia f
            GROUP BY f.nome_corporation
            HAVING SUM(f.valore_contributo) = (
                SELECT MAX(SUM(valore_contributo))
                FROM finanzia
                GROUP BY nome_corporation
            )
        );
        
        RETURN v_corporation_assoluto;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END;
END;
/














