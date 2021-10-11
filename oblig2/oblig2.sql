-- OPPGAVE 2

-- (a) Timelistelinjer som er lagt inn for timeliste nummer 3.
SELECT * FROM timelistelinje WHERE timelistenr=3;

-- (b) Hvor mange timelister det er.
SELECT DISTINCT count(timelistenr) FROM timeliste;

-- (c) Hvor mange timelister som det ikke er utbetalt penger for.
SELECT status FROM timeliste WHERE status != 'utbetalt';

-- (d) Antall timelistelinjer
SELECT count(*) FROM timelistelinje;
--     antall timelistelinjer med en pauseverdi
SELECT count(pause) FROM timelistelinje WHERE pause IS NOT NULL;

-- (e) Alle timelistelinjer som ikke har pauseverdier (der pause er satt til
--     null)
SELECT count(pause) FROM timelistelinje WHERE pause IS NULL;

-- OPPGAVE 3
