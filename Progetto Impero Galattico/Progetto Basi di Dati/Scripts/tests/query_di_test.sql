-- Query fatte per provare il database in fare iniziale di costruzione
-- Potrebbero non funzionare più!

SELECT
    s.DATA_INIZIO_STAZIONAMENTO,
    d.NUMERO_ARMATA,
    d.SPECIALIZZAZIONE
FROM 
    STAZIONAMENTO s
JOIN 
    DIVISIONE_IMPERIALE d
    ON (s.NUMERO_ARMATA) = (d.NUMERO_ARMATA);







-- tutti gli stazionamenti fatti da divisioni fatti da effetivi minori di 800
SELECT
    s.DATA_INIZIO_STAZIONAMENTO,
    d.NUMERO_ARMATA,
    d.EFFETTIVI
FROM 
    STAZIONAMENTO s
JOIN 
    DIVISIONE_IMPERIALE d
    ON (s.NUMERO_ARMATA) = (d.NUMERO_ARMATA)
WHERE 
    d.EFFETTIVI < 800;







-- tutti gli stanziamenti minori di 800 effetivi fatti su pianeti
SELECT
    s.DATA_INIZIO_STAZIONAMENTO,
    d.NUMERO_ARMATA,
    d.EFFETTIVI,
    s.NOME_PIANETA
FROM 
    STAZIONAMENTO s
JOIN 
    DIVISIONE_IMPERIALE d
    ON (s.NUMERO_ARMATA) = (d.NUMERO_ARMATA)
WHERE 
    d.EFFETTIVI < 800;







-- Tutti gli stazionameti fatti sul pianeta/stella
SELECT * 
FROM STAZIONAMENTO
WHERE STAZIONAMENTO.NOME_STELLA_PRINCIPALE = 'Gamma';







-- Tutti i gruppi ribelli partecioanti in una guerra
SELECT GR.NOME_ARMATA
FROM GRUPPO_RIBELLE GR JOIN (
    COMBATTE1 CO JOIN (
        SELECT * FROM GUERRA_CONQUISTA GC
        WHERE NOT EXISTS(
            SELECT * FROM OCCUPAZIONE OC
            WHERE OC.DATA_INIZIO=GC.DATA_INIZIO
            AND OC.NOME_STELLA_PRINCIPALE=GC.NOME_STELLA_PRINCIPALE
            AND OC.NOME_PIANETA=GC.NOME_PIANETA
        )
    )
    on CO.DATA_INIZIO=GC.DATA_INIZIO
    AND CO.NOME_STELLA_PRINCIPALE=GC.NOME_STELLA_PRINCIPALE
    AND CO.NOME_PIANETA=GC.NOME_PIANETA) ON GR.NOME_ARMATA=CO.NOME_ARMATA_RIBELLE
WHERE upper(GR.STATUS)='ATTIVO'







-- Tutte le guerra fatte (finite e non)
SELECT * FROM GUERRA_CONQUISTA GC

-- Tutte le guerre finite (che quindi hanno generato un occupazione)
SELECT GC.nome_pianeta, GC.NOME_STELLA_PRINCIPALE, GC.DATA_INIZIO, GC.NOME_OPERAZIONE 
FROM GUERRA_CONQUISTA GC INNER JOIN OCCUPAZIONE OC on GC.DATA_INIZIO=OC.DATA_INIZIO;

-- Tutte le guerra in corso (che non hanno generato un occupazione)
SELECT * FROM GUERRA_CONQUISTA GC
WHERE NOT EXISTS(
    SELECT * FROM OCCUPAZIONE OC
    WHERE OC.DATA_INIZIO=GC.DATA_INIZIO
    AND OC.NOME_STELLA_PRINCIPALE=GC.NOME_STELLA_PRINCIPALE
    AND OC.NOME_PIANETA=GC.NOME_PIANETA
)







-- Tutte le Armate ribelli attive che combatto nella guerra (tutti i nemici che si oppongono attivamente/in una guerra all'impero) 
SELECT GR.NOME_ARMATA
FROM GRUPPO_RIBELLE GR JOIN (
    COMBATTE1 CO JOIN (
        SELECT * FROM GUERRA_CONQUISTA GC
        WHERE NOT EXISTS(
            SELECT * FROM OCCUPAZIONE OC
            WHERE OC.DATA_INIZIO=GC.DATA_INIZIO
            AND OC.NOME_STELLA_PRINCIPALE=GC.NOME_STELLA_PRINCIPALE
            AND OC.NOME_PIANETA=GC.NOME_PIANETA
        )
    ) GC
    on CO.DATA_INIZIO=GC.DATA_INIZIO
    AND CO.NOME_STELLA_PRINCIPALE=GC.NOME_STELLA_PRINCIPALE
    AND CO.NOME_PIANETA=GC.NOME_PIANETA) ON GR.NOME_ARMATA=CO.NOME_ARMATA_RIBELLE
WHERE upper(GR.STATUS)='ATTIVO'







-- Tutte le Armate ribelli attive che combatto nella guerra su uno specifico pianeta
SELECT GR.NOME_ARMATA
FROM GRUPPO_RIBELLE GR JOIN (
    COMBATTE1 CO JOIN (
        SELECT * FROM GUERRA_CONQUISTA GC
        WHERE NOT EXISTS(
            SELECT * FROM OCCUPAZIONE OC
            WHERE OC.DATA_INIZIO=GC.DATA_INIZIO
            AND OC.NOME_STELLA_PRINCIPALE=GC.NOME_STELLA_PRINCIPALE
            AND OC.NOME_PIANETA=GC.NOME_PIANETA
        )
    ) GC
    on CO.DATA_INIZIO=GC.DATA_INIZIO
    AND CO.NOME_STELLA_PRINCIPALE=GC.NOME_STELLA_PRINCIPALE
    AND CO.NOME_PIANETA=GC.NOME_PIANETA) ON GR.NOME_ARMATA=CO.NOME_ARMATA_RIBELLE
WHERE upper(GR.STATUS)='ATTIVO' AND GC.NOME_PIANETA='REA'







-- Se una divisione ha partecipato a più battaglie, le perdite di tutte le battaglie verranno sommate prima di essere sottratte dagli effettivi originali.
-- Fa un LEFT JOIN con la tabella combatte2 per includere tutte le divisioni, anche quelle che non hanno partecipato a battaglie
-- NVL: dove si sarebbe stato un null viene mostrato uno 0
SELECT 
    d.numero_armata,
    d.nome_armata,
    d.effettivi AS "Effettivi Originali",
    NVL(SUM(c.numero_perdite), 0) AS "Perdite Totali",
    d.effettivi - NVL(SUM(c.numero_perdite), 0) AS "Effettivi Attuali"
FROM 
    Divisione_Imperiale d
LEFT JOIN 
    combatte2 c ON d.numero_armata = c.numero_armata
GROUP BY 
    d.numero_armata, d.nome_armata, d.effettivi
ORDER BY 
    d.numero_armata;