DROP TABLE IF EXISTS Tog;
DROP TABLE IF EXISTS TogTabell;
DROP TABLE IF EXISTS Plass;

CREATE TABLE Tog (
  togNr int PRIMARY KEY,
  startStasjon text NOT NULL,
  endeStasjon text NOT NULL,
  ankomstTid timestamp NOT NULL,
);

CREATE TABLE TogTabell (
  togNr int REFERENCES Tog(togNr),
  adgangsTid timestamp
  stasjon text NOT NULL,
  PRIMARY KEY (togNr, adgangsTid)
);

CREATE TABLE Plass (
  dato date
  togNr int REFERENCES Tog(togNr),
  vognNr int
  plassNr int
  vindu boolean NOT NULL,
  ledig boolean NOT NULL,
  PRIMARY KEY (dato, togNr, vognNr, plassNr)
);

-- Eneste skranker jeg putter er å ikke tillate nullverdier.
-- Datatypene bør være ganske selvforklarende: heltall på alt som
-- har et «nummer», `timestamp` på alle «tider» (klokkeslett og
-- dato), `date` det ene stedet oppgaven spør om bare dato, og
-- boolske verdier på vindusplass og ledighet.
