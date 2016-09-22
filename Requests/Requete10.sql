SET foreign_key_checks = 0;
DROP VIEW IF EXISTS MoisAnneeAvis;
DROP VIEW IF EXISTS AvisTotalParMois;
DROP VIEW IF EXISTS 10AvisTotalParMois;
DROP VIEW IF EXISTS DroitPotentiel2;
SET foreign_key_checks = 1;

CREATE VIEW MoisAnneeAvis AS SELECT idAvisVoy, idVoyageur, idEtab, MONTH(dateAvis) AS Mois, YEAR(dateAvis) AS Annee FROM AvisVoy;

CREATE VIEW AvisTotalParMois AS SELECT idVoyageur,Mois,Annee,COUNT(Mois) AS cpt FROM MoisAnneeAvis GROUP BY Mois,idVoyageur,Annee;

CREATE VIEW 10AvisTotalParMois AS SELECT idVoyageur AS VoyPot,Mois AS MoisPot,Annee AS 	AnneePot ,cpt AS cptPot FROM AvisTotalParMois WHERE cpt>=10;

CREATE VIEW DroitPotentiel2 AS SELECT VoyPot,COUNT(MoisPot) AS nbrMois FROM 10AvisTotalParMois GROUP BY VoyPot,AnneePot;

SELECT VoyPot FROM DroitPotentiel2 WHERE nbrMois=12;