SET foreign_key_checks = 0;
DROP VIEW IF EXISTS AnneeAvis;
SET foreign_key_checks = 1;

CREATE VIEW AnneeAvis AS SELECT idAvisVoy,idVoyageur,idEtab,YEAR(dateAvis) AS Annee FROM AvisVoy;

SELECT AnneeAvis.idVoyageur,pseudoUser FROM AnneeAvis,Voyageur 
where AnneeAvis.idVoyageur=Voyageur.idVoyageur GROUP BY idVoyageur,Annee,idEtab HAVING COUNT(*)>=2;