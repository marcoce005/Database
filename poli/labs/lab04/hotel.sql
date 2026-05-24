-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Creato il: Mag 17, 2023 alle 10:02
-- Versione del server: 8.0.33
-- Versione PHP: 8.1.18


--
-- Database: `hotel`
--
CREATE DATABASE IF NOT EXISTS `hotel`;
USE `hotel`;

--
-- Struttura della tabella `CITTA`
--

CREATE TABLE `CITTA` (
  `Nome` varchar(32) NOT NULL,
  `Latitudine` float DEFAULT NULL,
  `Longitudine` float DEFAULT NULL,
  `Nazione` varchar(32) DEFAULT NULL,
  `Regione` varchar(32) NOT NULL,
  PRIMARY KEY (Nome)
);


--
-- Dump dei dati per la tabella `CITTA`
--

INSERT INTO `CITTA` (`Nome`, `Latitudine`, `Longitudine`, `Nazione`, `Regione`) VALUES
('Bari', 41.1253, 16.8667, 'Italy', 'Puglia'),
('Bologna', 44.4939, 11.3428, 'Italy', 'Emilia-Romagna'),
('Brescia', 45.5389, 10.2203, 'Italy', 'Lombardy'),
('Catania', 37.5, 15.0903, 'Italy', 'Sicilia'),
('Cosenza', 39.3, 16.25, 'Italy', 'Calabria'),
('Firenze', 43.7714, 11.2542, 'Italy', 'Tuscany'),
('Genoa', 44.4111, 8.9328, 'Italy', 'Liguria'),
('Messina', 38.1936, 15.5542, 'Italy', 'Sicilia'),
('Milano', 45.4669, 9.19, 'Italy', 'Lombardy'),
('Modena', 44.6458, 10.9257, 'Italy', 'Emilia-Romagna'),
('Napoli', 40.8333, 14.25, 'Italy', 'Campania'),
('Padova', 45.4064, 11.8778, 'Italy', 'Veneto'),
('Palermo', 38.1157, 13.3613, 'Italy', 'Sicilia'),
('Parma', 44.8015, 10.328, 'Italy', 'Emilia-Romagna'),
('Prato', 43.8808, 11.0966, 'Italy', 'Tuscany'),
('Roma', 41.8931, 12.4828, 'Italy', 'Lazio'),
('Taranto', 40.4711, 17.2431, 'Italy', 'Puglia'),
('Torino', 45.0792, 7.6761, 'Italy', 'Piedmont'),
('Trieste', 45.6503, 13.7703, 'Italy', 'Friuli Venezia Giulia'),
('Venezia', 45.4397, 12.3319, 'Italy', 'Veneto'),
('Verona', 45.4386, 10.9928, 'Italy', 'Veneto');

-- --------------------------------------------------------


CREATE TABLE `AGENZIA` (
  `CodA` int NOT NULL,
  `SitoWeb` varchar(32) DEFAULT NULL,
  `Tel` varchar(32) NOT NULL,
  `Via_Indirizzo` varchar(32) NOT NULL,
  `CAP_Indirizzo` int NOT NULL,
  `Citta_Indirizzo` varchar(32) NOT NULL,
  `Numero_Indirizzo` int NOT NULL,
  `Stato_Indirizzo` varchar(32) NOT NULL,
  PRIMARY KEY (`CodA`),
  FOREIGN KEY (`Citta_Indirizzo`) REFERENCES `CITTA` (`Nome`)
);

--
-- Dump dei dati per la tabella `AGENZIA`
--

INSERT INTO `AGENZIA` (`CodA`, `SitoWeb`, `Tel`, `Via_Indirizzo`, `CAP_Indirizzo`, `Citta_Indirizzo`, `Numero_Indirizzo`, `Stato_Indirizzo`) VALUES
(1, 'www.ag1.it', '070-123456', 'Via Stretta', 1234, 'Milano', 12, 'Italia'),
(2, 'www.ag2.it', '070-234567', 'Via Corta', 2345, 'Roma', 24, 'Italia'),
(3, NULL, '070-345678', 'Via Lunga', 3456, 'Napoli', 38, 'Italia'),
(4, 'www.ag4.it', '070-23232', 'Via Leonardo', 2345, 'Roma', 11, 'Italia'),
(5, 'www.ag5.it', '070-89821', 'Via Rimini', 1234, 'Milano', 5, 'Italia'),
(6, 'www.ag6.it', '070-77623', 'Via Cavour', 1234, 'Milano', 89, 'Italia'),
(7, 'www.ag7.it', '070-14521', 'Via dei Maritri', 1234, 'Milano', 43, 'Italia'),
(8, 'www.ag8.it', '070-22121', 'Via Ugo Foscolo', 7777, 'Brescia', 130, 'Italia'),
(9, 'www.ag9.it', '070-34012', 'Via Milano', 8989, 'Firenze', 77, 'Italia'),
(10, 'www.ag10.it', '070-99881', 'Via Trento', 8989, 'Firenze', 10, 'Italia'),
(11, 'www.ag11.it', '070-01001', 'Via Linati', 9876, 'Parma', 10, 'Italia');

-- --------------------------------------------------------


--
-- Struttura della tabella `STANZA`
--

CREATE TABLE `STANZA` (
  `CodS` int NOT NULL,
  `Piano` int NOT NULL,
  `Superficie` int NOT NULL,
  `Type` varchar(32) NOT NULL,
  PRIMARY KEY (`CodS`)
);
--
-- Dump dei dati per la tabella `STANZA`
--

INSERT INTO `STANZA` (`CodS`, `Piano`, `Superficie`, `Type`) VALUES
(1, 1, 20, 'singola'),
(2, 2, 30, 'doppia'),
(3, 3, 40, 'tripla'),
(4, 2, 20, 'singola'),
(5, 4, 17, 'singola'),
(6, 5, 25, 'doppia'),
(7, 4, 25, 'doppia'),
(8, 2, 45, 'tripla'),
(9, 6, 45, 'tripla'),
(10, 2, 35, 'tripla'),
(11, 4, 15, 'singola'),
(12, 8, 25, 'singola'),
(13, 3, 30, 'doppia');



--
-- Struttura della tabella `HAS_OPTIONAL`
--

CREATE TABLE `HAS_OPTIONAL` (
  `OPTIONAL_Optional` varchar(32) NOT NULL,
  `STANZA_CodS` int NOT NULL,
  PRIMARY KEY (OPTIONAL_Optional, STANZA_CodS),
  FOREIGN KEY (STANZA_CodS) REFERENCES STANZA(CodS)
);
--
-- Dump dei dati per la tabella `HAS_OPTIONAL`
--

INSERT INTO `HAS_OPTIONAL` (`OPTIONAL_Optional`, `STANZA_CodS`) VALUES
('balcone', 1),
('balcone', 2),
('jacuzzi', 2),
('minibar', 2),
('minibar', 3),
('balcone', 4),
('pay-tv', 5),
('minibar', 11),
('balcone', 11),
('balcone', 6),
('jacuzzi', 6),
('balcone', 8),
('jacuzzi', 8),
('jacuzzi', 9),
('minibar', 12),
('minibar', 10),
('pay-tv', 10),
('balcone', 7),
('pay-tv', 13);


-- --------------------------------------------------------

--
-- Struttura della tabella `HAS_SPAZI`
--

CREATE TABLE `HAS_SPAZI` (
  `SPAZI_Spazi` varchar(32) NOT NULL,
  `STANZA_CodS` int NOT NULL,
  PRIMARY KEY (SPAZI_Spazi, STANZA_CodS),
  FOREIGN KEY (STANZA_CodS) REFERENCES STANZA(CodS)
);

--
-- Dump dei dati per la tabella `HAS_SPAZI`
--

INSERT INTO `HAS_SPAZI` (`SPAZI_Spazi`, `STANZA_CodS`) VALUES
('bagno', 3),
('camera da letto', 3),
('cucina', 3),
('cucina', 4),
('cucina', 6),
('cucina', 13),
('sala da pranzo', 3),
('sala da pranzo', 7),
('sala da pranzo', 5);

-- --------------------------------------------------------

--
-- Struttura della tabella `PRENOTAZIONE`
--

CREATE TABLE `PRENOTAZIONE` (
  `STANZA_CodS` int NOT NULL,
  `DataInizio` varchar(32) NOT NULL,
  `DataFine` varchar(32) NOT NULL,
  `Costo` double NOT NULL,
  `AGENZIA_CodA` int NOT NULL,
  PRIMARY KEY (STANZA_CodS, DataInizio),
  FOREIGN KEY (STANZA_CodS) REFERENCES STANZA(CodS),
  FOREIGN KEY (AGENZIA_CodA) REFERENCES AGENZIA(CodA)
);

--
-- Dump dei dati per la tabella `PRENOTAZIONE`
--

INSERT INTO `PRENOTAZIONE` (`STANZA_CodS`, `DataInizio`, `DataFine`, `Costo`, `AGENZIA_CodA`) VALUES
(1, '2023-01-01', '2023-01-10', 1000, 1),
(2, '2023-01-01', '2023-01-10', 1500, 2),
(3, '2023-02-01', '2023-02-10', 800, 2),
(13, '2023-03-01', '2023-03-10', 800, 2),
(2, '2023-01-12', '2023-01-17', 560, 2),
(3, '2023-03-13', '2023-03-17', 270, 2),
(4, '2023-02-01', '2023-02-05', 300, 3),
(3, '2023-02-06', '2023-02-07', 90, 3),
(7, '2023-09-06', '2023-09-17', 1250, 3),
(10, '2023-08-06', '2023-08-09', 950, 3),
(10, '2023-04-16', '2023-04-19', 660, 5),
(10, '2023-07-13', '2023-07-20', 1185, 5),
(8, '2023-12-11', '2023-12-14', 710, 4);

-- --------------------------------------------------------
