# Oppgave 1

(1)  `SELECT * from genre;`
(2)  `SELECT filmid, title FROM film WHERE prodyear = 1892;`
(3)  `
     SELECT filmid, title
       FROM film
      WHERE 2000 < filmid and filmid < 2030;
     `
(4)  `SELECT filmid, title FROM film WHERE title ~ '.*Star Wars.*'`
(5)  `SELECT firstname, lastname FROM person WHERE personid = 465221;`
(6)  `SELECT distinct(parttype) FROM filmparticipation;`
(7)  `SELECT title, prodyear FROM film WHERE title ~ '.*Rush Hour.*';`
(8)  `SELECT * FROM film WHERE title ~ '.*Norge.*';`
(9) `
     SELECT film.filmid
       FROM film JOIN filmitem ON film.filmid = filmitem.filmid
      WHERE filmitem.filmtype = 'C'
            and film.title = 'Love';
     `
(10) `
     `
