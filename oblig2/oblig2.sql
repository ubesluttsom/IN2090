-- OPPGAVE 2

-- (a) Timelistelinjer som er lagt inn for timeliste nummer 3.
SELECT * FROM timelistelinje WHERE timelistenr=3;

-- (b) Hvor mange timelister det er.
SELECT DISTINCT count(timelistenr) FROM timeliste;

-- (c) Hvor mange timelister som det ikke er utbetalt penger for.
SELECT status FROM timeliste WHERE status != 'utbetalt';

-- (d) Antall timelistelinjer antall timelistelinjer med en pauseverdi
SELECT count(*) FROM timelistelinje;
SELECT count(pause) FROM timelistelinje WHERE pause IS NOT NULL;

-- (e) Alle timelistelinjer som ikke har pauseverdier (der pause er satt til
--     null)
SELECT count(pause) FROM timelistelinje WHERE pause IS NULL;

-- OPPGAVE 3

-- (a) Antall timer som det ikke er utbetalt penger for. Her kan det også være
--     lurt å ta i bruk viewet varighet, men merk at varigheten her er i
--     minutter, ikke timer.
SELECT sum(varighet)/60
  FROM timeliste NATURAL JOIN varighet
 WHERE status != 'utbetalt';
