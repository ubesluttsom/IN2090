-- OPPGAVE 2

-- (a) Timelistelinjer som er lagt inn for timeliste nummer 3.

SELECT *
  FROM timelistelinje
 WHERE timelistenr = 3;

--   timelistenr | linjenr | startdato  | starttid | sluttid  | pause | beskrivelse
--  -------------+---------+------------+----------+----------+-------+-------------
--             3 |       1 | 2016-07-01 | 15:00:00 | 16:00:00 |       | Test 1
--             3 |       2 | 2016-07-04 | 13:15:00 | 17:00:00 |    40 | Test 2
--             3 |       3 | 2016-07-04 | 22:00:00 | 01:00:00 |    30 | Test 3
--             3 |       4 | 2016-07-05 | 14:00:00 | 18:00:00 |       | Test 4
--             3 |       5 | 2016-07-06 | 10:00:00 | 16:50:00 |    55 | Test 5
--             3 |       6 | 2016-07-07 | 10:00:00 | 12:00:00 |       | Test 6
--             3 |       7 | 2016-07-07 | 15:00:00 | 18:00:00 |    20 | Test 7
--             3 |       8 | 2016-07-08 | 13:00:00 | 13:50:00 |       | Test 8
--             3 |       9 | 2016-07-09 | 22:00:00 | 03:00:00 |    25 | Retesting
--  (9 rows)


-- (b) Hvor mange timelister det er.

SELECT DISTINCT COUNT(timelistenr) AS antall_timelister
  FROM timeliste;

-- antall timelister
-- -------------------
--                  8
-- (1 row)


-- (c) Hvor mange timelister som det ikke er utbetalt penger for.

SELECT COUNT(status) AS antall_ubetalte_timelister
  FROM timeliste
 WHERE status != 'utbetalt';

--  antall ubetalte timelister
-- ----------------------------
--                           3
-- (1 row)


-- (d) Antall timelistelinjer antall timelistelinjer med en pauseverdi.

SELECT COUNT(*) AS antall_timelister,
       COUNT(pause) AS antall_med_pause
  FROM timelistelinje;

--  antall timelister | antall med pause
-- -------------------+------------------
--                 34 |               12
-- (1 row)


-- (e) Alle timelistelinjer som ikke har pauseverdier (der pause er satt til
--     null)

SELECT COUNT(*) AS antall_pauseverdier_null
  FROM timelistelinje
 WHERE pause IS NULL;

--  antall pauseverdier null
-- --------------------------
--                        22
-- (1 row)


-- OPPGAVE 3

-- (a) Antall timer som det ikke er utbetalt penger for. Her kan det også være
--     lurt å ta i bruk viewet varighet, men merk at varigheten her er i
--     minutter, ikke timer.

SELECT SUM(varighet)/60 AS antall_timer
  FROM timeliste
       NATURAL JOIN varighet
 WHERE status != 'utbetalt';

-- antall timer
-- --------------
--            13
-- (1 row)


-- (b) Hvilke timelister (nr og beskrivelse) har en timelistelinje med en
--     beskrivelse som inneholder ’test’ eller ’Test’. Ikke vis duplikater.

SELECT DISTINCT timelistenr, beskrivelse
  FROM timeliste
 WHERE beskrivelse ~* '.*[Tt]est.*';

--  timelistenr |           beskrivelse
-- -------------+---------------------------------
--            7 | Opprettelse av testdatabase
--            8 | Videreutvikling av testdatabase
--            3 | Test av database
-- (3 rows)


-- (c) Hvor mye penger som har blitt utbetalt, dersom man blir utbetalt 200
--     kr per time. Tips: Finn først antall timer som det er utbetalt penger
--     for (ref. oppg. 3a).

SELECT SUM(varighet)*200/60 AS totalt_kroner_utbetalt
  FROM timeliste
       NATURAL JOIN varighet
 WHERE status = 'utbetalt';

-- totalt kroner utbetalt
-- ------------------------
--                   13266
-- (1 row)


/* 
   OPPGAVE 4

   (a) Forklar hvorfor følgende to spørringer IKKE GIR likt svar:
       ```
       SELECT COUNT(*)
         FROM timeliste
              NATURAL JOIN timelistelinje;
  
       SELECT COUNT(*)
         FROM timeliste AS t
              INNER JOIN timelistelinje AS l
              ON (t.timelistenr = l.timelistenr);
       ```
       
   Fordi `NATURAL JOIN` finner rader hvor *alle* de delte attributtene til
   tabellene er like, nemlig `timelistenr` og `beskrivelse`, i motsetning til
   andre spørring hvor du kun forener en attributt. Den første spørringen er
   ekvivalent med:
   ```
   SELECT *
     FROM timeliste AS t
        INNER JOIN timelistelinje AS l
        ON (t.timelistenr = l.timelistenr)
           AND (t.beskrivelse = l.beskrivelse);
   ```

   (b) Forklar hvorfor følgende to spørringer GIR likt svar:
       ```
       SELECT COUNT(*)
         FROM timeliste NATURAL JOIN varighet;
       
       SELECT COUNT(*)
         FROM timeliste AS t
              INNER JOIN varighet AS v
              ON (t.timelistenr = v.timelistenr);
       ```
  
   I dette tilfellet er det eneste attributtet som `timeliste` og `varighet`
   deler `timelistenr`. `NATURAL JOIN` vil derfor forene på denne, akkurat som
   i andre spørring.
*/
