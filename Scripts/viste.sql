-- Se una divisione ha partecipato a più battaglie, le perdite di tutte le battaglie verranno sommate prima di essere sottratte dagli effettivi originali.
-- TODO: fare in modo che non veda gli effetivvi originali ma solo quelli attuali
CREATE OR REPLACE VIEW vista_effettivi_attuali AS
SELECT 
    d.numero_armata,
    d.nome_armata,
    NVL(SUM(c.numero_perdite), 0) AS Perdite_Totali,
    d.effettivi - NVL(SUM(c.numero_perdite), 0) AS Effettivi_Attuali
FROM 
    Divisione_Imperiale d
LEFT JOIN 
    combatte2 c ON d.numero_armata = c.numero_armata
GROUP BY 
    d.numero_armata, d.nome_armata, d.effettivi
ORDER BY 
    d.numero_armata;



-- Vista di tutte le guerre attive e finite (serve per il manda_Rinforzi dell'utente GENERALE)
CREATE VIEW vista_guerre_attive AS
SELECT gc.*
FROM Guerra_Conquista gc
WHERE NOT EXISTS (
    SELECT 1
    FROM Occupazione o
    WHERE o.data_inizio = gc.data_inizio
      AND o.nome_pianeta = gc.nome_pianeta
      AND o.nome_stella_principale = gc.nome_stella_principale
);

CREATE VIEW vista_guerre_finite AS
SELECT 
    gc.*, 
    o.anno_conquista AS data_fine
FROM Guerra_Conquista gc
JOIN Occupazione o
  ON o.data_inizio = gc.data_inizio
 AND o.nome_pianeta = gc.nome_pianeta
 AND o.nome_stella_principale = gc.nome_stella_principale;