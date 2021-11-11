-- DEL 1

-- Oppgave 1

SELECT filmcharacter, count(filmcharacter)
  FROM filmcharacter
 GROUP BY filmcharacter
HAVING count(filmcharacter) > 2000
 ORDER BY count(filmcharacter) DESC;


-- Oppgave 2

SELECT country
  FROM filmcountry
 GROUP BY country
HAVING count(country) = 1;


-- Oppgave 3

SELECT title, parttype, count(parttype)
  FROM film
       JOIN filmparticipation USING (filmid)
       JOIN filmitem USING (filmid)
 WHERE title LIKE '%Lord of the Rings%' AND
       filmtype = 'C'
 GROUP BY title, parttype;


-- Oppgave 4

SELECT title, prodyear
  FROM filmgenre AS filmnoir
       JOIN filmgenre AS comedy USING (filmid)
       JOIN film USING (filmid)
 WHERE filmnoir.genre = 'Film-Noir' AND
       comedy.genre = 'Comedy';


-- Oppgave 5

SELECT maintitle, rank
  FROM series
       INNER JOIN filmrating ON (seriesid = filmid)
 WHERE votes > 1000 AND
       rank =
       (SELECT MAX(rank)
          FROM series
               INNER JOIN filmrating ON (seriesid = filmid)
         WHERE votes > 1000);


-- Oppgave 6

SELECT DISTINCT title, count(language)
  FROM filmcharacter
       JOIN filmparticipation USING (partid)
       JOIN film USING (filmid)
       LEFT OUTER JOIN filmlanguage USING (filmid)
 WHERE filmcharacter LIKE 'Mr. Bean'
 GROUP BY title, language;


-- Oppgave 7

-- Idk. Har prøvd circa 9001 forskjellige forespørsler her. Blir ikke riktig.
-- Med 192 rader (og øverste skuespillere riktig, virker det som), ble dette
-- nærmest:

SELECT lastname, firstname, COUNT(DISTINCT filmcharacter)
  FROM filmcharacter
       JOIN filmparticipation USING (partid)
       JOIN filmitem USING (filmid)
       JOIN person USING (personid)
 GROUP BY lastname, firstname, filmtype
HAVING COUNT(DISTINCT filmcharacter) > 199 AND
       filmtype = 'C'
 ORDER BY COUNT(DISTINCT filmcharacter) DESC;
