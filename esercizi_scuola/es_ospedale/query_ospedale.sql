CREATE DATABASE ospedale;
USE ospedale;
CREATE TABLE pazienti(
ID_paziente Integer PRIMARY KEY AUTO_INCREMENT,
    cognome VARCHAR(20) NOT NULL,
    nome VARCHAR(20) NOT NULL,
    tessera_sanitaria Numeric(20) NOT NULL,
    data_nascita DATE NOT NULL
);
CREATE TABLE specializzazioni(
ID_specializzazione Integer PRIMARY KEY AUTO_INCREMENT,
    descrizione TEXT
);
CREATE TABLE medici(
matricola Integer PRIMARY KEY AUTO_INCREMENT,
    cognome VARCHAR(20) NOT NULL,
    nome VARCHAR(20) NOT NULL,
    id_reparto Integer NOT NULL,
    id_specializzazione Integer NOT NULL,
    FOREIGN KEY(id_specializzazione) REFERENCES specializzazioni(ID_specializzazione)
);
CREATE TABLE reparti(
ID_reparto Integer PRIMARY KEY AUTO_INCREMENT,
    descrizione TEXT,
    nome VARCHAR(20) NOT NULL,
    id_matricola_primario Integer NOT NULL,
    FOREIGN KEY(id_matricola_primario) REFERENCES medici(matricola)
);
CREATE TABLE medici_pazienti(
id_medico Integer NOT NULL,
    id_paziente Integer NOT NULL,
    FOREIGN KEY(id_medico) REFERENCES medici(matricola),
    FOREIGN KEY(id_paziente) REFERENCES pazienti(ID_paziente)    
);
ALTER TABLE medici ADD FOREIGN KEY(id_reparto) REFERENCES reparti(ID_reparto);

SELECT pazienti.nome, pazienti.cognome FROM pazienti
LEFT JOIN medici_pazienti ON pazienti.ID_paziente = medici_pazienti.id_paziente
LEFT JOIN medici ON medici_pazienti.id_medico = medici.matricola
WHERE medici.cognome = "ciro";

SELECT specializzazioni.descrizione FROM specializzazioni
LEFT JOIN medici ON specializzazioni.ID_specializzazione = medici.id_specializzazione
WHERE specializzazioni.descrizione = traumatologia;

SELECT reparti.nome FROM reparti
LEFT JOIN medici ON reparti.id_matricola_primario = medici.matricola
LEFT JOIN specializzazioni ON medici.id_specializzazione = specializzazioni.ID_specializzazione
WHERE specializzazioni.descrizione = ematologo;

SELECT reparti.nome FROM reparti WHERE reparti.id_matricola_primario IS NULL;

SELECT pazienti.nome, pazienti.cognome FROM pazienti
LEFT JOIN medici_pazienti ON pazienti.ID_paziente = medici_pazienti.id_paziente
LEFT JOIN reparti ON medici_pazienti.id_medico = reparti.id_matricola_primario
LEFT JOIN medici ON medici_pazienti.id_medico = medici.matricola
WHERE medici.cognome = "Rossi";

SELECT pazienti.nome, pazienti.cognome FROM pazienti
LEFT JOIN medici_pazienti ON pazienti.ID_paziente = medici_pazienti.id_paziente
GROUP BY medici_pazienti.id_paziente
HAVING COUNT(DISTINCT(medici_pazienti.id_medico)) >= 2;

SELECT pazienti.nome, pazienti.cognome FROM pazienti
LEFT JOIN medici_pazienti ON pazienti.ID_paziente = medici_pazienti.id_paziente
LEFT JOIN medici ON medici_pazienti.id_medico = medici.matricola
GROUP BY medici_pazienti.id_paziente
HAVING COUNT(DISTINCT(medici.id_reparto)) >= 2;

SELECT pazienti.nome, pazienti.cognome FROM pazienti
LEFT JOIN medici_pazienti ON pazienti.ID_paziente = medici_pazienti.id_paziente
GROUP BY medici_pazienti.id_paziente
ORDER BY COUNT(DISTINCT(medici_pazienti.id_medico)) DESC
LIMIT 1;
