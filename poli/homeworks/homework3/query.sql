--- es1         cambiare 'Ematologica' con 'ematologica' in fase di consegna

WITH valid_lab AS (SELECT LABORATORIO.CodL, LABORATORIO.NomeL
                   FROM LABORATORIO, ESECUZIONE, ESAME
                   WHERE ESAME.Categoria = 'Ematologica' AND ESECUZIONE.CodE = ESAME.CodE AND LABORATORIO.CodL = ESECUZIONE.CodL
                   GROUP BY LABORATORIO.CodL, LABORATORIO.NomeL
                   HAVING COUNT(*) > 100 AND COUNT(DISTINCT ESECUZIONE.CodP) > 50)

SELECT valid_lab.NomeL, ESAME.NomeEsame, AVG(ESECUZIONE.DataReferto - ESECUZIONE.DataEsecuzione) AS MediaGiorni
FROM ESECUZIONE, ESAME, valid_lab
WHERE ESAME.Categoria = 'Ematologica' AND EXTRACT(YEAR FROM ESECUZIONE.DataEsecuzione) = 2025 AND ESECUZIONE.CodE = ESAME.CodE AND ESECUZIONE.CodL = valid_lab.CodL
GROUP BY valid_lab.CodL, valid_lab.NomeL, ESAME.NomeEsame


--- es2

WITH categoria_tempo_medio(Categoria, Media) AS (SELECT ESAME.Categoria, AVG(ESECUZIONE.DataReferto - ESECUZIONE.DataEsecuzione)
                               FROM ESECUZIONE, ESAME
                               WHERE ESECUZIONE.CodE = ESAME.CodE
                               GROUP BY ESAME.Categoria)
                               
SELECT ESAME.NomeEsame, COUNT(*) AS VolteEseguito, AVG(ESECUZIONE.DataReferto - ESECUZIONE.DataEsecuzione) AS TempoMedio
FROM ESECUZIONE, ESAME, LABORATORIO
WHERE LABORATORIO.Città = 'Torino' AND ESECUZIONE.CodE = ESAME.CodE AND ESECUZIONE.CodL = LABORATORIO.CodL
GROUP BY ESAME.CodE, ESAME.NomeEsame, ESAME.Categoria
HAVING AVG(ESECUZIONE.DataReferto - ESECUZIONE.DataEsecuzione) > (SELECT categoria_tempo_medio.Media
                                                                  FROM categoria_tempo_medio
                                                                  WHERE categoria_tempo_medio.Categoria = ESAME.Categoria)

--- oppure

ELECT ES1.NomeEsame, COUNT(*) AS VolteEseguito, AVG(ESECUZIONE.DataReferto - ESECUZIONE.DataEsecuzione) AS TempoMedio
FROM ESECUZIONE, ESAME ES1, LABORATORIO
WHERE LABORATORIO.Città = 'Torino' AND ESECUZIONE.CodE = ES1.CodE AND ESECUZIONE.CodL = LABORATORIO.CodL
GROUP BY ES1.CodE, ES1.NomeEsame, ES1.Categoria
HAVING AVG(ESECUZIONE.DataReferto - ESECUZIONE.DataEsecuzione) > (SELECT AVG(ESECUZIONE.DataReferto - ESECUZIONE.DataEsecuzione)
                               									  FROM ESECUZIONE, ESAME ES2
                               									  WHERE ES2.Categoria = ES1.Categoria AND ESECUZIONE.CodE = ES2.CodE
                               									  GROUP BY ES2.Categoria)