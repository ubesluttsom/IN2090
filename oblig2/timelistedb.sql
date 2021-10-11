DROP VIEW IF EXISTS Timeantall;
DROP VIEW IF EXISTS Varighet;
DROP TABLE IF EXISTS Timelistelinje;
DROP TABLE IF EXISTS Timeliste;

CREATE TABLE Timeliste (
  timelistenr int PRIMARY KEY,
  status text NOT NULL,
  levert date,
  utbetalt date,
  beskrivelse text NOT NULL,
  CHECK (status = 'aktiv' OR status = 'levert' OR status = 'utbetalt')
);

CREATE TABLE Timelistelinje (
  timelistenr int REFERENCES Timeliste(timelistenr),
  linjenr int,
  startdato date NOT NULL,
  starttid time NOT NULL,
  sluttid time,
  pause int,
  beskrivelse text NOT NULL,
  PRIMARY KEY (timelistenr, linjenr)
);

CREATE VIEW Varighet AS
  SELECT timelistenr,
         linjenr, 
         (sluttid - starttid - pause) as varighet
  FROM (SELECT timelistenr,
               linjenr,
               cast(extract(hour from starttid) as integer)*60 +
                    cast(extract(minute from starttid) as integer) AS starttid,
               cast(extract(hour from sluttid) as integer)*60 +
                    cast(extract(minute from sluttid) as integer) +
                         CASE WHEN sluttid < starttid THEN 60*24
                              ELSE 0
                         END AS sluttid,
               CASE WHEN pause IS NULL THEN 0
                    ELSE pause
               END AS pause
        FROM Timelistelinje
        WHERE sluttid IS NOT NULL) AS c;

--\copy Timeliste from 'timeliste.txt' with delimiter '|' null ''

INSERT INTO Timeliste VALUES
(1, 'utbetalt', '2016-07-04', '2016-07-13', 'HMS-kurs'),
(2, 'utbetalt', '2016-07-08', '2016-07-13', 'Innføring'),
(3, 'utbetalt', '2016-07-19', '2016-07-27', 'Test av database'),
(4, 'levert', '2016-07-20', NULL, 'Innlegging av virksomhetsdokumenter'),
(5, 'utbetalt', '2016-07-20', '2016-07-27', 'Oppsporing av manglende underlagsinformasjon'),
(6, 'aktiv', NULL, NULL, 'Identifisering av manglende funksjonalitet'),
(7, 'utbetalt', '2016-08-01', '2016-08-10', 'Opprettelse av testdatabase'),
(8, 'aktiv', '2016-08-10', NULL, 'Videreutvikling av testdatabase');

--\copy Timelistelinje from 'timelistelinje.txt' with delimiter '|' null NULL

INSERT INTO Timelistelinje VALUES
(1, 1, '2016-07-01', '09:00', '12:00', NULL, 'HMS del 1'),
(1, 2, '2016-07-04', '09:00', '12:00', NULL, 'HMS del 2'),
(2, 1, '2016-07-01', '13:00', '15:00', '15', 'Innføring'),
(3, 1, '2016-07-01', '15:00', '16:00', NULL, 'Test 1'),
(3, 2, '2016-07-04', '13:15', '17:00', '40', 'Test 2'),
(3, 3, '2016-07-04', '22:00', '01:00', '30', 'Test 3'),
(3, 4, '2016-07-05', '14:00', '18:00', NULL, 'Test 4'),
(3, 5, '2016-07-06', '10:00', '16:50', '55', 'Test 5'),
(3, 6, '2016-07-07', '10:00', '12:00', NULL, 'Test 6'),
(3, 7, '2016-07-07', '15:00', '18:00', '20', 'Test 7'),
(3, 8, '2016-07-08', '13:00', '13:50', NULL, 'Test 8'),
(3, 9, '2016-07-09', '22:00', '03:00', '25', 'Retesting'),
(4, 1, '2016-07-05', '13:00', '14:00', NULL, 'innlegging'),
(4, 2, '2016-07-08', '11:00', '12:00', NULL, 'innlegging'),
(4, 3, '2016-07-11', '14:20', '16:55', '45', 'innlegging'),
(4, 4, '2016-07-15', '15:00', '17:00', NULL, 'innlegging'),
(4, 5, '2016-07-20', '10:00', '11:45', NULL, 'innlegging'),
(4, 6, '2016-07-20', '12:00', '13:45', NULL, 'Enhetstesting'),
(5, 1, '2016-07-13', '09:15', '12:00', NULL, 'Leting i arkivet'),
(5, 2, '2016-07-18', '14:30', '16:00', NULL, 'Leting i arkivet'),
(5, 3, '2016-07-19', '15:45', '17:20', '20', 'Søk i databasene'),
(5, 4, '2016-07-21', '13:00', '14:00', NULL, 'Leting i arkivet'),
(6, 1, '2016-08-01', '13:15', '14:00', NULL, 'Diskusjoner'),
(6, 2, '2016-08-02', '11:00', '12:10', NULL, 'Diskusjoner'),
(6, 3, '2016-08-05', '14:00', '17:00', '45', 'Skriving av notat'),
(7, 1, '2016-07-13', '14:05', '16:10', NULL, 'Innlegging av data'),
(7, 2, '2016-07-14', '09:20', '13:00', '45', 'Vasking av data'),
(7, 3, '2016-07-15', '10:00', '12:00', NULL, 'Testing'),
(7, 4, '2016-07-18', '18:00', '00:15', '50', 'Testing'),
(7, 5, '2016-07-19', '18:00', '20:15', NULL, 'Innlegging av data'),
(7, 6, '2016-07-21', '17:15', '22:00', '35', 'Testing'),
(7, 7, '2016-07-21', '23:15', '01:10', NULL, 'Feilsøking'),
(7, 8, '2016-07-26', '09:00', '11:35', NULL, 'Testing'),
(7, 9, '2016-08-01', '10:30', '12:40', NULL, 'Stresstesting');
