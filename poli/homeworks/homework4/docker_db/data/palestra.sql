-- create an empty database. Name of the database: 
SET FOREIGN_KEY_CHECKS=1;
CREATE DATABASE IF NOT EXISTS `palestra`;

-- use palestra 
USE `palestra`;


-- drop tables if they already exist
DROP TABLE IF EXISTS PROGRAMMA;
DROP TABLE IF EXISTS CORSI;
DROP TABLE IF EXISTS ISTRUTTORE;

-- create tables

CREATE TABLE Istruttore (
	CodFisc CHAR(20) ,
	Nome CHAR(50) NOT NULL ,
	Cognome CHAR(50) NOT NULL ,
	DataNascita DATE NOT NULL ,
	Email CHAR(50) NOT NULL ,
	Telefono CHAR(20) NULL ,
	PRIMARY KEY (CodFisc)
);

CREATE TABLE Corsi (
	CodC CHAR(10) ,
	Nome CHAR(50) NOT NULL ,
	Tipo CHAR(50) NOT NULL ,
	Livello SMALLINT NOT NULL,
	PRIMARY KEY (CodC),
	CONSTRAINT chk_Livello CHECK (Livello>=1 and Livello<=4)
);

CREATE TABLE Programma (
	CodFisc CHAR(20) NOT NULL ,
	Giorno CHAR(15) NOT NULL ,
	OraInizio CHAR(32) NOT NULL ,
	Durata SMALLINT NOT NULL ,
	Sala CHAR(5) NOT NULL,
	CodC CHAR(10) NOT NULL,
	PRIMARY KEY (CodFisc,Giorno,OraInizio),
	FOREIGN KEY (CodFisc)
		REFERENCES Istruttore(CodFisc) 
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (CodC)
		REFERENCES Corsi(CodC) 
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- Insert data
INSERT INTO Istruttore (CodFisc,Nome,Cognome,DataNascita,Email, Telefono)
VALUES ('SMTPLA80N31B791Z','Paul','Smith','1980-12-31','p.smith@email.it',NULL);
INSERT INTO Istruttore (CodFisc,Nome,Cognome,DataNascita,Email, Telefono)
VALUES ('KHNJHN81E30C455Y','John','Johnson','1983-05-30','j.johnson@email.it','+2300110303214');
INSERT INTO Istruttore (CodFisc,Nome,Cognome,DataNascita,Email, Telefono)
VALUES ('LKDMD920113TSLF','Luke','Diamond','1992-01-13','l.diamond@email.it','+876651320919');
INSERT INTO Istruttore (CodFisc,Nome,Cognome,DataNascita,Email, Telefono)
VALUES ('AAAGGG83E30C445A','Peter','Johnson','1981-05-30','p.johnson@email.it','+2300110303444');
INSERT INTO Istruttore (CodFisc,Nome,Cognome,DataNascita,Email, Telefono)
VALUES ('MGDLNJVS880202FM','Magdalina','Jevis','1988-02-02','m.jevis@email.it','+1279304911134');
INSERT INTO Istruttore (CodFisc,Nome,Cognome,DataNascita,Email, Telefono)
VALUES ('NNSPNCR960805MML','Anne','Spencer','1996-08-05','a.spencer@email.it','+6566612818222');
INSERT INTO Istruttore (CodFisc,Nome,Cognome,DataNascita,Email, Telefono)
VALUES ('JNNFRLVNS880202F','Jennifer','Luvens','1988-02-02','j.luvens@email.it','+1377212331');
INSERT INTO Corsi (CodC,Nome,Tipo,Livello)
VALUES ('CT100','Spinning principianti','Spinning ',1);
INSERT INTO Corsi (CodC,Nome,Tipo,Livello)
VALUES ('CT101','Ginnastica e musica','Attività musicale',2);
INSERT INTO Corsi (CodC,Nome,Tipo,Livello)
VALUES ('CT104','Spinning professionisti','Spinning',4);
INSERT INTO Corsi (CodC,Nome,Tipo,Livello)
VALUES ('CT106','Yoga Strength','Yoga ',4);
INSERT INTO Corsi (CodC,Nome,Tipo,Livello)
VALUES ('CT107','Yoga Align','Yoga ',2);
INSERT INTO Corsi (CodC,Nome,Tipo,Livello)
VALUES ('CT108','Cross Cardio','Attività musicale',3);
INSERT INTO Corsi (CodC,Nome,Tipo,Livello)
VALUES ('CT110','Hydrobike','Piscina',1);
INSERT INTO Programma (CodFisc,Giorno,OraInizio,Durata,Sala,CodC)
VALUES ('SMTPLA80N31B791Z','Lunedì','10:00:00',45,'S1','CT100');
INSERT INTO Programma (CodFisc,Giorno,OraInizio,Durata,Sala,CodC)
VALUES ('SMTPLA80N31B791Z','Martedì','11:00:00',45,'S1','CT100');
INSERT INTO Programma (CodFisc,Giorno,OraInizio,Durata,Sala,CodC)
VALUES ('SMTPLA80N31B791Z','Martedì','15:00:00',45,'S2','CT107');
INSERT INTO Programma (CodFisc,Giorno,OraInizio,Durata,Sala,CodC)
VALUES ('AAAGGG83E30C445A','Lunedì','10:00:00',30,'S2','CT101');
INSERT INTO Programma (CodFisc,Giorno,OraInizio,Durata,Sala,CodC)
VALUES ('KHNJHN81E30C455Y','Lunedì','11:30:00',30,'S2','CT104');
INSERT INTO Programma (CodFisc,Giorno,OraInizio,Durata,Sala,CodC)
VALUES ('JNNFRLVNS880202F','Mercoledì','10:00:00',60,'S1','CT104');
INSERT INTO Programma (CodFisc,Giorno,OraInizio,Durata,Sala,CodC)
VALUES ('SMTPLA80N31B791Z','Venerdì','10:00:00',40,'S1','CT107');
INSERT INTO Programma (CodFisc,Giorno,OraInizio,Durata,Sala,CodC)
VALUES ('MGDLNJVS880202FM','Lunedì','11:00:00',20,'S10','CT110');
INSERT INTO Programma (CodFisc,Giorno,OraInizio,Durata,Sala,CodC)
VALUES ('JNNFRLVNS880202F','Giovedì','16:00:00',45,'S8','CT104');
INSERT INTO Programma (CodFisc,Giorno,OraInizio,Durata,Sala,CodC)
VALUES ('KHNJHN81E30C455Y','Mercoledì','11:30:00',20,'S1','CT110');
INSERT INTO Programma (CodFisc,Giorno,OraInizio,Durata,Sala,CodC)
VALUES ('AAAGGG83E30C445A','Mercoledì','17:00:00',30,'S3','CT106');

