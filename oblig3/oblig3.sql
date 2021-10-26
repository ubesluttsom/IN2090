DROP TABLE IF EXISTS Tog;
DROP TABLE IF EXISTS TogTabell;
DROP TABLE IF EXISTS Plass;

CREATE TABLE Tog (
  togNr int PRIMARY KEY,
  startStasjon text NOT NULL,
  endeStasjon text NOT NULL,
  ankomstTid timestamp NOT NULL,
  CHECK (endeStasjon != startStasjon)
);

CREATE TABLE TogTabell (
  togNr int REFERENCES Tog(togNr),
  adgangsTid timestamp NOT NULL,
  stasjon text NOT NULL UNIQUE,
  PRIMARY KEY (togNr, adgangsTid)
);

CREATE TABLE Plass (
  dato timestamp,
  togNr int REFERENCES Tog(togNr),
  vognNr int NOT NULL,
  plassNr int NOT NULL,
  vindu boolean,
  ledig boolean,
  PRIMARY KEY (dato, togNr, vognNr, plassNr)
);
