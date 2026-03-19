SELECT AVG(dichiarazioni.reddito_complessivo) AS media_lombardia FROM dichiarazioni
INNER JOIN presentazioni ON dichiarazioni.ID_dichiarazione = presentazioni.ID_presentazione INNER JOIN contribuenti ON contribuenti.codice_fiscale = presentazioni.codice_fiscale
WHERE contribuenti.regione = 'Lombardia';

SELECT COUNT(dichiarazioni.ID_dichiarazione) AS n_dichiarazioni FROM dichiarazioni 
INNER JOIN presentazioni ON dichiarazioni.ID_dichiarazione = presentazioni.ID_presentazione
WHERE dichiarazioni.tipo = Unico AND presentazioni.anno = 2003;

SELECT presentazioni.anno, MAX(dichiarazioni.reddito_complessivo) AS max_reddito, MIN(dichiarazioni.reddito_complessivo) AS min_reddito FROM dichiarazioni 
INNER JOIN presentazioni ON dichiarazioni.ID_dichiarazione = presentazioni.ID_presentazione
GROUP BY presentazioni.anno;

SELECT SUM(dichiarazioni.reddito_complessivo) AS somma_redditi, presentazioni.anno FROM dichiarazioni 
INNER JOIN presentazioni ON dichiarazioni.ID_dichiarazione = presentazioni.ID_presentazione
GROUP BY presentazioni.anno
ORDER BY SUM(dichiarazioni.reddito_complessivo)
LIMIT 1;

SELECT contribuenti.codice_fiscale, AVG(dichiarazioni.reddito_complessivo) FROM contribuenti INNER JOIN presentazioni ON contribuenti.codice_fiscale = presentazioni.codice_fiscale INNER JOIN dichiarazioni ON presentazioni.id_dichiarazione = dichiarazioni.ID_dichiarazione GROUP BY contribuenti.codice_fiscale;
