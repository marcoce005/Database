SELECT AVG(dipendenti.stipendio), dipendenti.citta FROM dipendenti GROUP BY dipendenti.citta;

SELECT AVG(dipendenti.stipendio), dipendenti.anzianita FROM dipendenti GROUP BY dipendenti.anzianita;

SELECT dipendenti.nome FROM dipendenti WHERE MONTH(dipendenti.data_nascita) = 4 OR MONTH(dipendenti.data_nascita) = 5 OR MONTH(dipendenti.data_nascita) = 6;

SELECT reparti.ID_reparto, MIN(dipendenti.stipendio) AS stipendio_min, MAX(dipendenti.stipendio) AS stipendio_max FROM reparti
INNER JOIN dipendenti ON reparti.ID_reparto = dipendenti.id_reparto
GROUP BY reparti.ID_reparto;

SELECT mansioni.tariffa_oraria, COUNT(dipendenti.ID_matricola) AS n_dipendenti FROM mansioni
INNER JOIN dipendenti ON mansioni.ID_mansione = dipendenti.id_mansione
GROUP BY mansioni.tariffa_oraria;

SELECT dipendenti.nome, dipendenti.cognome FROM dipendenti WHERE dipendenti.stipendio >= 3000 AND dipendenti.stipendio <= 4000;
