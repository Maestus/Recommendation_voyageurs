SET foreign_key_checks = 0;
DROP VIEW IF EXISTS AvisAnnee;
DROP VIEW IF EXISTS NbrAvis;
DROP VIEW IF EXISTS AvisNonConforme;
DROP VIEW IF EXISTS AvisSup;
SET foreign_key_checks = 1;

CREATE VIEW AvisAnnee AS SELECT idVoyageur,idEtab,YEAR(dateAvis) AS Annee FROM AvisVoy;

CREATE VIEW NbrAvis AS SELECT idVoyageur,idEtab,Annee,COUNT(Annee) AS cptAvis FROM AvisAnnee GROUP BY idVoyageur,idEtab,Annee;

CREATE VIEW AvisNonConforme AS SELECT * FROM NbrAvis WHERE cptAvis >= 2;

CREATE VIEW AvisSup AS SELECT * FROM AvisVoy NATURAL JOIN AvisNonConforme ORDER BY dateAvis;

SELECT * FROM AvisSup;

SELECT * FROM AvisSup WHERE dateAvis NOT IN(SELECT MIN(dateAvis) FROM AvisSup);

-- DELETE FROM AvisVoy WHERE idAvisVoy = 42;

