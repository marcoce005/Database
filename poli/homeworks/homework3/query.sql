--- es1         cambiare 'Ematologica' con 'ematologica' in fase di consegna

WITH valid_lab AS (SELECT LABORATORIO.CodL, LABORATORIO.NomeL
                   FROM LABORATORIO, ESECUZIONE, ESAME
                   WHERE ESAME.Categoria = 'Ematologica' AND EXTRACT(YEAR FROM ESECUZIONE.DataEsecuzione) = 2025 AND ESECUZIONE.CodE = ESAME.CodE AND LABORATORIO.CodL = ESECUZIONE.CodL
                   GROUP BY LABORATORIO.CodL, LABORATORIO.NomeL
                   HAVING COUNT(*) > 100 AND COUNT(DISTINCT ESECUZIONE.CodP) > 50)

SELECT valid_lab.NomeL, ESAME.NomeEsame, AVG(ESECUZIONE.DataReferto - ESECUZIONE.DataEsecuzione) AS MediaGiorni
FROM ESECUZIONE, ESAME, valid_lab
WHERE ESAME.Categoria = 'Ematologica' AND EXTRACT(YEAR FROM ESECUZIONE.DataEsecuzione) = 2025 AND ESECUZIONE.CodE = ESAME.CodE AND ESECUZIONE.CodL = valid_lab.CodL
GROUP BY valid_lab.CodL, valid_lab.NomeL, ESAME.NomeEsame;


--- es2

WITH categoria_tempo_medio(Categoria, Media) AS (SELECT ESAME.Categoria, AVG(ESECUZIONE.DataReferto - ESECUZIONE.DataEsecuzione)
                               FROM ESECUZIONE, ESAME
                               WHERE ESECUZIONE.CodE = ESAME.CodE
                               GROUP BY ESAME.Categoria)
                               
SELECT ESAME.NomeEsame, ESAME.Categoria, COUNT(*) AS VolteEseguito, AVG(ESECUZIONE.DataReferto - ESECUZIONE.DataEsecuzione) AS TempoMedio
FROM ESECUZIONE, ESAME, LABORATORIO
WHERE LABORATORIO.Città = 'Torino' AND ESECUZIONE.CodE = ESAME.CodE AND ESECUZIONE.CodL = LABORATORIO.CodL
GROUP BY ESAME.CodE, ESAME.NomeEsame, ESAME.Categoria
HAVING AVG(ESECUZIONE.DataReferto - ESECUZIONE.DataEsecuzione) > (SELECT categoria_tempo_medio.Media
                                                                  FROM categoria_tempo_medio
                                                                  WHERE categoria_tempo_medio.Categoria = ESAME.Categoria);

--- oppure

SELECT ES1.NomeEsame, ESAME.Categoria, COUNT(*) AS VolteEseguito, AVG(ESECUZIONE.DataReferto - ESECUZIONE.DataEsecuzione) AS TempoMedio
FROM ESECUZIONE, ESAME ES1, LABORATORIO
WHERE LABORATORIO.Città = 'Torino' AND ESECUZIONE.CodE = ES1.CodE AND ESECUZIONE.CodL = LABORATORIO.CodL
GROUP BY ES1.CodE, ES1.NomeEsame, ES1.Categoria
HAVING AVG(ESECUZIONE.DataReferto - ESECUZIONE.DataEsecuzione) > (SELECT AVG(ESECUZIONE.DataReferto - ESECUZIONE.DataEsecuzione)
                               									  FROM ESECUZIONE, ESAME ES2
                               									  WHERE ES2.Categoria = ES1.Categoria AND ESECUZIONE.CodE = ES2.CodE
                               									  GROUP BY ES2.Categoria)

--- es3

WITH categoria_media(Categoria, media) AS (SELECT esame_tot.Categoria, AVG(esame_tot.tot)
						 				   FROM (SELECT ESAME.CodE, COUNT(*) AS tot, ESAME.Categoria
	  						   					 FROM ESECUZIONE, ESAME
	  						   					 WHERE ESECUZIONE.CodE = ESAME.CodE
	  						   					 GROUP BY ESAME.CodE, ESAME.Categoria) esame_tot
										   GROUP BY esame_tot.Categoria),

	esami_sup_media AS (SELECT es.CodE
						FROM ESECUZIONE, ESAME es
						WHERE ESECUZIONE.CodE = es.CodE
						GROUP BY es.CodE, es.Categoria
						HAVING COUNT(*) > (SELECT categoria_media.media
                   						   FROM categoria_media
                   						   WHERE categoria_media.Categoria = es.Categoria)),

	esami_less_then_3 AS (SELECT DISTINCT(ESAME.CodE)
						  FROM ESAME, ESECUZIONE
						  WHERE ESECUZIONE.CodE = ESAME.CodE
						  GROUP BY ESAME.CodE, ESECUZIONE.CodL, ESECUZIONE.DataEsecuzione
						  HAVING COUNT(*) > 3), 
                          
	valid_esami AS (SELECT *
				   FROM ESAME
				   WHERE ESAME.CodE IN (SELECT * FROM esami_sup_media) AND ESAME.CodE NOT IN (SELECT * FROM esami_less_then_3))
                   
SELECT MEDICO.NomeM, MEDICO.CognomeM, MEDICO.Specializzazione, valid_esami.NomeEsame, COUNT(*) AS n_volte, COUNT(DISTINCT ESECUZIONE.DataEsecuzione) AS n_date_diverse
FROM MEDICO, valid_esami, ESECUZIONE
WHERE ESECUZIONE.CodE = valid_esami.CodE AND ESECUZIONE.CodM = MEDICO.CodM
GROUP BY MEDICO.CodM, MEDICO.NomeM, MEDICO.CognomeM, MEDICO.Specializzazione, valid_esami.CodE, valid_esami.NomeEsame;

--- es4

CREATE TRIGGER new_recensione
AFTER INSERT ON RECENSIONE_RISTORANTE
FOR EACH ROW
DECLARE
N NUMBER, p_avg_rist NUMBER, p_avg_city NUMBER, tot NUMBER, city VARCHAR2;
BEGIN

    SELECT COUNT(*) INTO N
    FROM RIASSUNTO_RECENSIONI RR
    WHERE RR.CodR = :NEW.CodR;

    IF (N = 0) THEN
        INSERT INTO RIASSUNTO_RECENSIONI(CodR, NumeroRecensioni, PunteggioComplessivo) 
        VALUES (:NEW.CodR, 1, :NEW.Punteggio);

        p_avg_rist := :NEW.Punteggio;
    ELSE
        UPDATE RIASSUNTO_RECENSIONI 
        SET NumeroRecensioni = NumeroRecensioni + 1, PunteggioComplessivo = PunteggioComplessivo + :NEW.Punteggio
        WHERE RIASSUNTO_RECENSIONI.CodR = :NEW.CodR;

        SELECT RIASSUNTO_RECENSIONI.NumeroRecensioni, RIASSUNTO_RECENSIONI.PunteggioComplessivo INTO N, tot
        FROM RIASSUNTO_RECENSIONI
        WHERE RIASSUNTO_RECENSIONI.CodR = :NEW.CodR;

        p_avg_rist := tot / N;
    END IF;

    SELECT RISTORANTE.Città INTO city
    FROM RISTORANTE
    WHERE RISTORANTE.CodR = :NEW.CodR;

    SELECT SUM(RIASSUNTO_RECENSIONI.NumeroRecensioni), SUM(RIASSUNTO_RECENSIONI.PunteggioComplessivo) INTO N, tot
    FROM RIASSUNTO_RECENSIONI, RISTORANTE
    WHERE RISTORANTE.Città = city AND RISTORANTE.CodR = RIASSUNTO_RECENSIONI.CodR;

    p_avg_city := tot / N;

    INSERT INTO NOTIFICA(CodR, DataRecensione, PunteggioMedioRistorante, PunteggioMedioCittà)
    VALUES(:NEW.CodR, :NEW.DataRecensione, p_avg_rist, p_avg_city);

END;