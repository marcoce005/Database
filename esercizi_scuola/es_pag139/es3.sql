CREATE DATABASE autosalone;
CREATE TABLE autosalone.automobili(
ID_auto Integer PRIMARY KEY AUTO_INCREMENT NOT NULL,
    marca VARCHAR(20),
    modello VARCHAR(20),
    tipo VARCHAR(20),
    prezzo Integer,
    colore VARCHAR(20),
    km Integer,
    gg_attesa Integer,
    nuovo_usato Integer,
    acquirente VARCHAR(20)
);
/*macchina nuova == 0macchina usata == 10*/

SELECT * FROM automobili WHERE nuovo_usato = 0;
SELECT * FROM automobili WHERE nuovo_usato = 0 AND marca = 'Fiat';
SELECT * FROM automobili WHERE nuovo_usato = 10 AND km < 100000;
SELECT * FROM automobili WHERE colore = 'rosso' AND prezzo < 10000;
SELECT * FROM automobili WHERE acquirente = 'Rossi Mario';
SELECT * FROM automobili WHERE marca = 'Fiat' AND gg_attesa < 30;
SELECT * FROM automobili WHERE nuovo_usato = 0 AND colore = 'rosso' AND prezzo < 15000;
SELECT * FROM automobili WHERE modello = 'Panda' AND nuovo_usato = 10 AND km < 200000;
