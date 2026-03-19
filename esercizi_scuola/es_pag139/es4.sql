CREATE DATABASE cinema;
CREATE TABLE cinema.film(
ID_film Integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    titolo VARCHAR(20),
    sceneggiatore VARCHAR(20),
    produttore VARCHAR(20),
    nazione VARCHAR(20),
    durata Integer,
    genere VARCHAR(20),
    anno DATE,
    costo Integer,
    incasso Integer
);
SELECT * FROM film WHERE titolo = 'S%' OR titolo = 'U%';
SELECT * FROM film WHERE YEAR(anno) >= 1996 AND YEAR(anno) <= 2001 AND incasso >= 50000000 AND incasso <= 100000000;
SELECT * FROM film WHERE incasso - costo < 0;
SELECT * FROM film WHERE incasso / costo > 1;
SELECT produttore FROM film WHERE incasso > costo;
SELECT produttore FROM film WHERE YEAR(anno) < 2000;
SELECT sceneggiatore FROM film WHERE costo > 20000000 AND costo < 30000000;
SELECT * FROM film WHERE genere = 'comico' AND nazione = 'Italia' AND durata > 100;
