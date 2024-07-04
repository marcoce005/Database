CREATE DATABASE archivio;
CREATE TABLE archivio.fotografie( 
    ID_foto PRIMARY KEY AUTO_INCREMENT Integer,
    data DATE,
    dimensione VARCHAR(20),
    stato VARCHAR(20),
    tipo VARCHAR(20),
    soggetto VARCHAR(20),
    luogo VARCHAR(20)
);
SELECT * FROM fotografie WHERE tipo = 'colori';
SELECT * FROM fotografie WHERE tipo = 'colori' & luogo = 'Milano';
SELECT * FROM fotografie WHERE luogo = 'Milano';
SELECT * FROM fotografie WHERE luogo = 'Napoli' & soggetto = 'Papa';
SELECT * FROM fotografie WHERE luogo = 'Roma' & YEAR(data) = 2000;
SELECT * FROM fotografie WHERE tipo = 'colori' & dimensione = '5x12cm';
