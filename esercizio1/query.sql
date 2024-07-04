CREATE DATABASE cinema;
USE cinema;
CREATE TABLE attori(
    CODattore Integer AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nome VARCHAR(20),
    annoNascita DATE,
    nazionalita VARCHAR(20)
);

CREATE TABLE film(
    CODfilm Integer AUTO_INCREMENT PRIMARY KEY NOT NULL,
    titolo VARCHAR(20),
    annoProduzione DATE,
    nazionalita VARCHAR(20),
    registra VARCHAR(20),
    genere VARCHAR(20),
    durate Integer
);

CREATE TABLE recita(
    CodAttore Integer NOT NULL,
    CodFilm Integer NOT NULL,
    PRIMARY KEY(CodAttore, CodFilm),
    FOREIGN KEY(CodAttore) REFERENCES attori(CODattore),
    FOREIGN KEY(CodFilm) REFERENCES film(CODfilm)
);

CREATE TABLE sale(
    CODsala Integer AUTO_INCREMENT PRIMARY KEY NOT NULL,
    posti Integer,
    nome VARCHAR(20),
    city VARCHAR(20)
);

CREATE TABLE proiezioni (
    CODproiezione Integer AUTO_INCREMENT PRIMARY KEY NOT NULL,
    CodFilm Integer NOT NULL,
    CodSala Integer NOT NULL,
    incasso Integer,
    dataProiezione DATE,
    FOREIGN KEY(CodFilm) REFERENCES film(CODfilm),
    FOREIGN KEY(CodSala) REFERENCES sale(CODsala)
);

SELECT * FROM sale WHERE sale.city = 'Pisa';

SELECT film.titolo FROM film WHERE film.registra = 'F. Fellini' AND YEAR(film.annoProduzione) > 1960;

SELECT film.titolo, film.durate FROM film WHERE film.genere = 'fantascienza' AND (film.nazionalita = 'giapponese' OR film.nazionalita = 'francese');

SELECT film.titolo FROM film WHERE film.genere = 'fantascienza' AND (film.nazionalita = 'giapponese' OR film.nazionalita = 'francese');

SELECT film.titolo FROM film WHERE film.registra = (SELECT film.registra FROM film WHERE film.titolo = 'Casablanca');

SELECT film.titolo, film.genere FROM film, proiezioni WHERE proiezioni.dataProiezione = '2004-12-25';

SELECT film.titolo, film.genere FROM film, proiezioni, sale WHERE proiezioni.dataProiezione = '2004-12-25' AND sale.city = 'Napoli';

SELECT
    sale.nome
FROM
    sale,
    proiezioni,
    recita,
    attori
WHERE
    sale.city = 'Napoli' AND proiezioni.dataProiezione = '2004-12-25' AND proiezioni.CodFilm = (
        SELECT proiezioni.CodFilm FROM proiezioni, attori WHERE attori.nome = 'R. Williams');

SELECT film.titolo FROM film, recita WHERE recita.CodFilm = (SELECT recita.CodFilm FROM recita, attori WHERE attori.nome = 'M. Mastroianni' OR attori.nome = 'S. Loren');

SELECT film.titolo FROM film, recita WHERE recita.CodFilm = (SELECT recita.CodFilm FROM recita, attori WHERE attori.nome = 'M. Mastroianni' AND attori.nome = 'S. Loren');

SELECT film.titolo, attori.nome FROM film, attori, recita WHERE recita.CodAttore = (SELECT recita.CodAttore FROM recita WHERE attori.nazionalita = 'francese');

SELECT film.titolo, sale.nome FROM film, sale, proiezioni WHERE sale.city = 'Pisa' AND sale.CODsala = (SELECT proiezioni.CodSala FROM proiezioni WHERE proiezioni.dataProiezione = '2005-12-?')

SELECT COUNT(sale.CODsala) AS num_sale FROM sale WHERE sale.posti > 60 AND sale.city = 'Pisa';

SELECT COUNT(sale.posti) AS tot_posti FROM sale WHERE sale.city = 'Pisa';

SELECT sale.city, COUNT(sale.city) AS n_sale FROM sale GROUP BY sale.city;

SELECT sale.city, COUNT(sale.city) AS n_sale FROM sale WHERE sale.posti > 60 GROUP BY sale.city ;

SELECT film.registra, COUNT(film.registra) AS n_film FROM film WHERE YEAR(film.annoProduzione) > 1990 GROUP BY film.registra;

SELECT film.registra, SUM(proiezioni.incasso) AS tot_incassi
FROM film
LEFT JOIN proiezioni ON film.CODfilm = proiezioni.CodFilm
GROUP BY film.CODfilm, film.registra;

SELECT
    film.titolo,
    COUNT(proiezioni.CODproiezione) AS n_proiezioni,
    SUM(proiezioni.incasso) AS tot_incassi
FROM proiezioni
LEFT JOIN film ON proiezioni.CodFilm = film.CODfilm
LEFT JOIN sale ON proiezioni.CodSala = sale.CODsala
WHERE registra = 'S. Spielberg' AND city = 'Pisa';

SELECT film.registra, attori.nome AS nome_attore, COUNT(film.CODfilm) AS n_film_insieme FROM film LEFT JOIN recita ON film.CODfilm = recita.CodFilm LEFT JOIN attori ON recita.CodAttore = attori.CODattore GROUP BY film.registra, attori.nome;

SELECT film.registra, film.titolo
FROM film
LEFT JOIN recita ON film.CODfilm = recita.CodFilm
LEFT JOIN attori ON recita.CodAttore = attori.CODattore
GROUP BY film.CODfilm
HAVING COUNT(nome) < 6;

SELECT film.CODfilm, film.titolo, SUM(incasso) AS somma_incassi
FROM film
LEFT JOIN proiezioni ON film.CODfilm = proiezioni.CodFilm
WHERE YEAR(dataProiezione) > 2000
GROUP BY film.CODfilm;

SELECT COUNT(attori.CODattore) AS n_attori FROM attori WHERE YEAR(attori.annoNascita) < 1970;

SELECT film.titolo, SUM(proiezioni.incasso) AS tot_incassi
FROM film
LEFT JOIN proiezioni ON film.CODfilm = proiezioni.CodFilm
WHERE film.genere = 'fantascienza'
GROUP BY film.CODfilm;

SELECT film.titolo, SUM(proiezioni.incasso) AS tot_incassi
FROM film
LEFT JOIN proiezioni ON film.CODfilm = proiezioni.CodFilm
WHERE film.genere = 'fantascienza' AND proiezioni.dataProiezione > '2001-1-1'
GROUP BY film.CODfilm;

SELECT film.titolo, SUM(proiezioni.incasso) AS tot_incassi
FROM film
LEFT JOIN proiezioni ON film.CODfilm = proiezioni.CodFilm
WHERE film.genere = 'fantascienza'
GROUP BY film.CODfilm
HAVING MIN(proiezioni.dataProiezione) > '2001-1-1';

SELECT sale.nome AS nome_sala, SUM(proiezioni.incasso) AS tot_incassi
FROM proiezioni
LEFT JOIN sale ON proiezioni.CodSala = sale.CODsala
WHERE city = 'Pisa' AND YEAR(proiezioni.dataProiezione) = 2005 AND MONTH(proiezioni.dataProiezione) = 1
GROUP BY proiezioni.CODproiezione
HAVING SUM(proiezioni.incasso) > 20000;


SELECT film.titolo FROM film
LEFT JOIN proiezioni ON film.CODfilm = proiezioni.CodFilm
LEFT JOIN sale ON proiezioni.CodSala = sale.CODsala
WHERE film.titolo NOT IN(
 SELECT film.titolo FROM film
    LEFT JOIN proiezioni ON film.CODfilm = proiezioni.CodFilm
LEFT JOIN sale ON proiezioni.CodSala = sale.CODsala
    WHERE sale.city = 'Pisa'
);

SELECT DISTINCT(film.titolo) FROM film
LEFT JOIN proiezioni ON film.CODfilm = proiezioni.CodFilm
LEFT JOIN sale ON proiezioni.CodSala = sale.CODsala
WHERE film.titolo IN(
 SELECT film.titolo FROM film
    LEFT JOIN proiezioni ON film.CODfilm = proiezioni.CodFilm
LEFT JOIN sale ON proiezioni.CodSala = sale.CODsala
    WHERE sale.city = 'Pisa'
);

SELECT DISTINCT(film.titolo) FROM film
LEFT JOIN proiezioni ON film.CODfilm = proiezioni.CodFilm
WHERE film.CODfilm NOT IN(
 SELECT film.CODfilm FROM film
    LEFT JOIN proiezioni ON film.CODfilm = proiezioni.CodFilm
    WHERE proiezioni.incasso > 500
);

SELECT DISTINCT(film.titolo) FROM film
LEFT JOIN proiezioni ON film.CODfilm = proiezioni.CodFilm
WHERE film.CODfilm NOT IN(
 SELECT DISTINCT(film.CODfilm) FROM film
    LEFT JOIN proiezioni ON film.CODfilm = proiezioni.CodFilm
    WHERE proiezioni.incasso < 500
) AND proiezioni.incasso IS NOT NULL;


SELECT DISTINCT(attori.nome) AS nome_attore FROM attori
LEFT JOIN recita ON attori.CODattore = recita.CodAttore
LEFT JOIN film ON recita.CodFilm = film.CODfilm
WHERE attori.CODattore NOT IN(
SELECT DISTINCT(attori.CODattore) FROM attori
    LEFT JOIN recita ON attori.CODattore = recita.CodAttore
LEFT JOIN film ON recita.CodFilm = film.CODfilm
    WHERE registra = 'Fellini'
) AND attori.nazionalita = 'italiana';

SELECT film.titolo FROM film
WHERE film.CODfilm NOT IN(
SELECT DISTINCT(recita.CodFilm) FROM recita
)

SELECT DISTINCT(attori.nome) FROM attori
LEFT JOIN recita ON attori.CODattore = recita.CodAttore
LEFT JOIN film ON recita.CodFilm = film.CODfilm
WHERE attori.CODattore NOT IN(
SELECT attori.CODattore FROM attori
LEFT JOIN recita ON attori.CODattore = recita.CodAttore
LEFT JOIN film ON recita.CodFilm = film.CODfilm
WHERE film.registra NOT LIKE 'Fellini'
) AND YEAR(film.annoProduzione) < 1960;

SELECT DISTINCT(attori.nome) FROM attori
LEFT JOIN recita ON attori.CODattore = recita.CodAttore
LEFT JOIN film ON recita.CodFilm = film.CODfilm
WHERE attori.CODattore NOT IN(
SELECT attori.CODattore FROM attori
LEFT JOIN recita ON attori.CODattore = recita.CodAttore
LEFT JOIN film ON recita.CodFilm = film.CODfilm
WHERE YEAR(film.annoProduzione) > 1960
) AND film.registra = 'Fellini';
