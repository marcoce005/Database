SELECT MAX(ordinativi.importo) / MIN(ordinativi.importo) AS rapporto_min_max, clienti.ID_cliente FROM ordinativi
LEFT JOIN clienti ON ordinativi.id_cliente = clienti.ID_cliente
WHERE ordinativi.importo < 100
GROUP BY clienti.ID_cliente;

SELECT COUNT(ordinativi.ID_ordine) AS n_ordini, ordinativi.id_cliente FROM ordinativi GROUP BY ordinativi.id_cliente;

SELECT SUM(ordinativi.importo) / COUNT(ordinativi.importo) AS media, ordinativi.id_cliente, ordinativi.data_ordine FROM ordinativi
GROUP BY ordinativi.data_ordine, ordinativi.id_cliente;

SELECT SUM(ordinativi.importo) / COUNT(ordinativi.importo) AS media, ordinativi.id_cliente FROM ordinativi
GROUP BY ordinativi.id_cliente;

SELECT MAX(ordinativi.importo) AS ordinativi_evasi FROM ordinativi WHERE ordinativi.evaso = 0;
SELECT MAX(ordinativi.importo) AS ordinativi_evasi FROM ordinativi WHERE ordinativi.evaso = 1;

SELECT COUNT(ordinativi.ID_ordine) AS n_ordinativi, clienti.ID_cliente FROM clienti
LEFT JOIN ordinativi ON ordinativi.id_cliente = clienti.ID_cliente
GROUP BY clienti.ID_cliente;

SELECT AVG(ordinativi.importo) AS media_importi, clienti.ID_cliente FROM clienti
LEFT JOIN ordinativi ON ordinativi.id_cliente = clienti.ID_cliente
WHERE ordinativi.importo > 50
GROUP BY clienti.ID_cliente;

SELECT MAX(ordinativi.importo) AS max_importo, MIN(ordinativi.importo) AS min_importo, ordinativi.data_ordine FROM ordinativi GROUP BY ordinativi.data_ordine HAVING MIN(ordinativi.importo) > 20;

SELECT MIN(ordinativi.importo) AS min_import, clienti.ID_cliente FROM clienti LEFT JOIN ordinativi ON clienti.ID_cliente = ordinativi.id_cliente GROUP BY clienti.ID_cliente HAVING MIN(ordinativi.importo) < 50;
