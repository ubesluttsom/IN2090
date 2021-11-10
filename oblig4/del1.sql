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
