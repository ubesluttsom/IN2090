---
title: '`IN2090-h21`: Obligatorisk innlevering 3'
author: 'Martin Mihle Nygaard (`martimn`)'
header-includes: |
            \usepackage{commath}
            \usepackage{cancel}
            \usepackage[normalem]{ulem}
            \usepackage{verbatim}
#           \setmainfont{Comic Sans MS}
---

# Oppgave 1 --- Lage databaser

Jeg vedlegger \textsc{sql} koden som egen fil, men inkluderer her og:

\verbatiminput{oblig3.sql}

# Oppgave 2 --- FDer og Normalformer

### Kandidatnøklene til $\mathcal{R}$

Nøklene $\cbr{C, F}$ forekommer kun på venstre side av de funksjonelle
avhengighettene, jeg vet da derfor at de nødvendigvis må være en del av alle
kandidatnøkler. $\cbr{G}$, derimot forekommer kun på høyre side, og kan derfor
ikke være inkludert i noen kandidatnøkler. Jeg finner tillukningen til $\cbr{C,
F}$, og utvider den alfabetisk og rekursivt for å finne alle kandidatnøkler;
jeg stryker hvis utvidelsen inneholder en annen kandidatnøkkel, mengden nøkler
allerede er vurdert, eller det utvides med en allerede inkludert nøkkel.

  - $\cbr{C, F}^+ = \cbr{C, F}$
    - $\cbr{C, F, A}^+ = \cbr{C, F, A, B, D, E, G} →  \text{kandidatnøkkel}$
    - $\cbr{C, F, B}^+ = \cbr{C, F, A, B, D, E, G} →  \text{kandidatnøkkel}$
    - ~~${\cbr{C, F, C}^+}$~~
    - $\cbr{C, F, D}^+ = \cbr{C, F, D, G}$
      - ~~${\cbr{C, F, D, A}^+}$~~
      - ~~${\cbr{C, F, D, B}^+}$~~
      - ~~${\cbr{C, F, D, C}^+}$~~
      - ~~${\cbr{C, F, D, D}^+}$~~
      - $\cbr{C, F, D, E}^+ = \cbr{C, F, D, G, E, B, A} →  \text{kandidatnøkkel}$
      - ~~${\cbr{C, F, D, F}^+}$~~
      - ~~${\cbr{C, F, D, G}^+}$~~
    - $\cbr{C, F, E}^+ = \cbr{C, F, E}$
      - ~~${\cbr{C, F, E, A}^+}$~~
      - ~~${\cbr{C, F, E, B}^+}$~~
      - ~~${\cbr{C, F, E, C}^+}$~~
      - ~~${\cbr{C, F, E, D}^+}$~~
      - ~~${\cbr{C, F, E, E}^+}$~~
      - ~~${\cbr{C, F, E, F}^+}$~~
      - ~~${\cbr{C, F, E, G}^+}$~~
    - ~~${\cbr{C, F, F}^+}$~~
    - ~~${\cbr{C, F, G}^+}$~~

Sorry, litt mye som skjer her, men oppsummert: kandidatnøklene blir $\cbr{C, F,
A}$, $\cbr{C, F, B}$ og $\cbr{C, F, D, E}$.


### Høyeste normalform til $\mathcal R$

Jeg følger algoritmen fra forelesning. Jeg har allerede funnet kandidatnøklene:
$\cbr{C, F, A}$, $\cbr{C, F, B}$ og $\cbr{C, F, D, E}$. Jeg vurderer de
funksjonelle avhengighetene etter tur:

  - $CDE →  B$: brudd på \textsc{bcnf}, siden $CDE$ ikke er en supernøkkel.
    - $CDE →  B$: på 3NF, siden $B$ er et nøkkelattributt.
  - $AF →  B$: brudd på \textsc{bcnf}, siden $AF$ ikke er en supernøkkel.
    - $AF →  B$: på 3NF, siden $B$ er er et nøkkelattributt.
  - $B →  A$: brudd på \textsc{bcnf}, siden $B$ ikke er en supernøkkel.
    - $B →  A$: på 3NF, siden $A$ er et nøkkelattributt.
  - $BCF →  DE$: på \textsc{bcnf}, siden $BCF$ er en supernøkkel.
  - $D →  G$ brudd på \textsc{bcnf}, siden $D$ ikke er en supernøkkel.
    - $D →  G$: brudd på 3NF, siden $G$ ikke er et nøkkelattributt.
      - $D →  G$: på 2NF, siden $D$ er en del av en kandidatnøkkel.

Høyeste normalformen som $\mathcal{R}$ tilfredsstiller er 2NF.


### (c) --- Tapsfri dekomponering[^note]

[^note]: Jeg er usikker på om jeg har tenkt riktig i denne oppgaven. Den ble
veldig innviklet. Håper det som følger en noenlunde forståelig.

Bruker algoritmen fra forelesning:

> Tapsfri dekomponering av $R(X)$ med funksjonelle avhengigheter $F$:
>
>   1. Beregn nøklene til $R$
>   2. For hver funksjonell avhengighet $Y →  A ∈ F$, hvis den funksjonelle
>      avhengigheten er et brudd på \textsc{bcnf}:
>       i. beregn $Y⁺$,
>      ii. og dekomponer $R$ til $S₁(Y⁺)$ og $S₂(Y,X/Y⁺)$.
>   3. Fortsett rekursivt (over $S₁$ og $S₂$) til ingen brudd på \textsc{bcnf}

Jeg navngir de forskjellige funksjonelle avhengighetene i tabellen under.
Deretter utfører jeg algoritmen på dem etter tur.

------------ -----------
  \textsc{i} $CDE →  B$
 \textsc{ii} $AF →  B$
\textsc{iii} $B →  A$
 \textsc{iv} $BCF →  DE$
  \textsc{v} $D →  G$
------------ -----------

#### $\mathbfit{CDE→ B}$

Bryter \textsc{bcnf}, siden $CDE$ ikke er en supernøkkel. Jeg dekomponerer til
$S₁(CDE⁺) = S₁(ABCDEG)$ og $S₂(CDE, ABCDEFG/CDE⁺) = S₂(CDEF)$. $S₂$ har ingen
funksjonelle avhengigheter, men $S₁$ har III og V som bryter med \textsc{bcnf}.

Jeg dekomponerer først $S₁$ til $S₁₁(B⁺) = S₁₁(AB)$ og $S₁₂(B, ABCDEG/B⁺)
= S₁₂(CDEG)$.

- $S₁₁(AB)$ har kun III, men denne er på \textsc{bcnf}.

- $S₁₂$ har V, som bryter med \textsc{bcnf}. Jeg dekomponerer $S₁₂$ til $S₁₂₁(D⁺)
  = S₁₂₁(DG)$ og $S₁₂₂(D, CDEG/D⁺) = S₁₂₂(CDE)$. Verken $S₁₂₁$ eller $S₁₂₂$
  har funksjonelle avhengigheter som bryter \textsc{bcnf}.

Jeg dekomponerer også $S₁$ til $T₁₁(D⁺) = T₁₁(DG) = S₁₂₁$ og $T₁₂(D, ABCDEG/D⁺)
= T₁₂(ABCDE)$.

- $T₁₁(DG)$ er lik $S₁₂₁$ og kan ignoreres.

- $T₁₂(ABCDE)$ har I, som ikke bryter, og III, som bryter med \textsc{bcnf}.
  Jeg dekomponerer $T₁₂$ til $T₁₂₁(B⁺) = T₁₂₁(AB) = S₁₁$ og $T₁₂₂(B,ABCDE/B⁺)
  = T₁₂₂(BCDE)$. Jeg kan ignorere $T₁₂₁ = S₁₁$, mens $T₁₂₂$ har ingen
  funksjonelle avhengigheter som bryter \textsc{bcnf}.


#### $\mathbfit{AF→ B}$

Bryter \textsc{bcnf}, siden $AF$ ikke er en supernøkkel. Jeg dekomponerer
$\mathcal R$ til $U₁(AF⁺) = U₁(ABF)$ og $U₂(AF, ABCDEFG/AF⁺) = U₂(CDEG) = S₁₂$.

- $U₁(ABF)$: har funksjonelle avhengigheter II og III. Siden III bryter
  \textsc{bcnf}, dekomponerer jeg $U₁$ til $U₁₁(B⁺) = U₁₁(AB) = S₁₁$ og $U₁₂(B,
  ABF/B⁺) = U₁₂(BF)$. Begge er på \textsc{bcnf}.

- $U₂ = S₁₂$ så denne er allerede tatt hånd om.


#### $\mathbfit{B→ A}$

Bryter \textsc{bcnf}. Jeg dekomponerer $\mathcal R$ til $V₁(B⁺) = V₁(AB) = S₁₁$
og $V₂(B, ABCDEFG/B⁺) = V₂(BCDEFG)$.

- $V₁(AB) = S₁₁$ er allerede vurdert.

- $V₂(BCDEFG)$: har FDer I og V som bryter \textsc{bcnf} (og IV som ikke
  bryter). Jeg dekomponerer $V₂$ til $V₂₁(CDE⁺) = V₂₁(BCDEG)$ og $V₂₂(CDE,
  BCDEFG/CDE⁺) = V₂₂(CDEF) = S₂$.

  - $V₂₁$ har kun V som bryter med \textsc{bcnf}. Jeg dekomponerer derfor til
    $V₂₁$ til $V₂₁₁(D⁺)=V₂₁₁(DG)=S₁₂₁$ og $V₂₁₂(D, BCDEG/D⁺) = V₂₁₂(BCDE)
    = T₁₂₂$, som begge alt er vurdert.

  - $V₂₂ = S₂$ og er alt rekursert over.


#### $\mathbfit{D→ G}$

Bryter \textsc{bcnf}. Jeg dekomponerer derfor til $W₁(D⁺) = W₁(DG) = S₁₂₁$ og
$W₂(D, ABCDEFG/D⁺) = W₂(ABCDEF)$.

- $W₁ = S₁₂₁$ er alt vurdert.

- $W₂$ har FDer I, II, III og IV som alle bryter med \textsc{bcnf}.

  - Jeg dekomponerer $W₂$ til $W₂₁₁(CDE⁺) = W₂₁₁(ABCDE) = T₁₂$ og $W₂₁₂(CDE,
    ABCDEF/CDE⁺) = W₂₁₂(CDEF) = S₂$. Begge relasjonene er allerede vurdert.

  - Jeg dekomponerer $W₂$ til $W₂₂₁(AF⁺) = W₂₂₁(ABF) = U₁$ og $W₂₂₂(AF,
    ABCDEF/AF⁺) = W₂₂₁(ACDEF)$. Hvor $W₂₂₁ = U₁$ allerede er vurdert, $W₂₂₁$
    har ingen funksjonelle avhengigheter.


#### Oppsummering

Dette ble veldig rotete, men over dekomponerer jeg $\mathcal R(ABCDEFG)$ til følgende
relasjoner (med litt vilkårlige navn):

- $S₁₁(AB)$

- $S₁₂₂(CDE)$

- $S₁₂₁(DG)$

- $T₁₂₂(BCDE)$

- $U₁₂(BF)$

- $W₂₂₁(ACDEF)$
