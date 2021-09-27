---
title: "`IN2090-H21:` Obligatorisk innlevering 1"
author: "Martin Mihle Nygaard (`martimn@ifi.uio.no`)"
---

# Oppgave 1 --- Relasjoner

Entiteten «PING» har en 1:N relasjon «ZIP» til entiteten «PONG»; d.v.s. at PING
kan ha mange PONG-er, men PONG kan maks være relatert til én PING. I tillegg,
vi ser fra den doble streken at PONG har _total deltagelse_ i PING, altså at
hver PONG må nødvendigvis være relatert til et PING (men det motsatte er ikke
tilfelle).

# Oppgave 2 --- ER-diagram

Se Figur \ref{opp2}.

![ER-diagram over _bøker_, _kapitler_, _forfattere_ og _forlag_.\label{opp2}](oppgave2.pdf)

# Oppgave 3 --- Realisering av ER-modell

<!--
Algoritmen, steg for steg:

1) Sterke entiteter med simple attributter:
   a) PERSON
      * \underline{Personnummer}
      * Navn
   b) HUS
      * ~~Adresse~~
         * \underline{Gate}
         * \underline{Gatenummer}
         * \underline{Postnummer}
      * Areal
      * Antall etasjer
2) N/A (Ingen svake entiteter.)
3) N/A (Ingen 1:1 relasjoner.)
4) Kartlegge binære 1:N relasjoner:
   a) PERSON
      * \underline{Personnummer}
      * Navn
      * HUS.Adresse
   b) HUS
      * ~~Adresse~~
         * \underline{Gate}
         * \underline{Gatenummer}
         * \underline{Postnummer}
      * Areal
      * Antall etasjer
5) N/A (Ingen M:N relasjoner.)
6) Kartlegge flervariable attributter:
   c) TELEFONNUMRE
      * \underline{PERSON.Personnummer}
      * \underline{Telefonnummer}
7) N/A (Ingen _N_-ære relasjonstyper.)
-->

Jeg har brukt «fremmednøkkel metoden» der det har vært et valg. Fremmednøkler
er markert slik «FREMMEDENTITET.Nøkkel». Realiseringen av modellen ble:

*  PERSON(\underline{Personnummer,} Navn, HUS.Adresse)
*  HUS(\underline{Gate, Gatenummer, Postnummer,} Areal, Antall etasjer)
*  TELEFONNUMRE(\underline{PERSON.Personnummer, Telefonnummer})
