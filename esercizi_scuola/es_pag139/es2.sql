CREATE DATABASE es2_139;
CREATE TABLE es2_139.alunni(
matricola Integer PRIMARY KEY AUTO_INCREMENT NOT NULL,
    cognome VARCHAR(20),
    nome VARCHAR(20),
    indirizzo VARCHAR(30),
    classe VARCHAR(10),
    media_voti FLOAT,
    maggiorenne CHAR(1)
);
SELECT * FROM alunni WHERE maggiorenne = 'S';
SELECT * FROM alunni WHERE classe = '4A';
INSERT INTO `alunni`(
    `matricola`,
    `cognome`,
    `nome`,
    `indirizzo`,
    `classe`,
    `media_voti`,
    `maggiorenne`
)
VALUES(
    0,
    'esposito',
    'ciro',
    'Via Scampia 2',
    '2B',
    6.1,
    'N'
);

INSERT INTO `alunni`(
    `matricola`,
    `cognome`,
    `nome`,
    `indirizzo`,
    `classe`,
    `media_voti`,
    `maggiorenne`
)
VALUES(
    1,
    'pluto',
    'pippo',
    'Via Scampia 3',
    '2B',
    6.5,
    'S'
);

INSERT INTO `alunni`(
    `matricola`,
    `cognome`,
    `nome`,
    `indirizzo`,
    `classe`,
    `media_voti`,
    `maggiorenne`
)
VALUES(
    2,
    'lino',
    'gino',
    'Via Scampia 21',
    '2B',
    5.6,
    'N'
);
SELECT * FROM alunni WHERE media_voti >= 6 & media_voti <= 7 & classe NOT LIKE '5A' & classe NOT LIKE '5B';
SELECT * FROM alunni WHERE media_voti >= 5 AND media_voti <= 6 AND media_voti >= 8 AND media_voti <= 9;
SELECT * FROM alunni WHERE classe LIKE '4' OR classe LIKE '5';
SELECT * FROM alunni WHERE cognome = 'L%' OR cognome = 'S%';
