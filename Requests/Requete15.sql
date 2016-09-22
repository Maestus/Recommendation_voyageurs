SET foreign_key_checks = 0;
DROP VIEW IF EXISTS NoteSup4;
DROP VIEW IF EXISTS VUE;
SET foreign_key_checks = 1;

create view NoteSup4 as select idVoyageur,idEtab as id,nbEtoileAvis from AvisVoy where nbEtoileAvis>=4;

CREATE VIEW VUE AS SELECT COUNT(id) AS nbAVisSup4,id,nomEtab FROM 	NoteSup4,Etablissement WHERE NoteSup4.id=Etablissement.idEtab GROUP BY id,nomEtab;

SELECT pseudoUser,VUE.nomEtab FROM VUE,Etablissement WHERE id=idEtab && nbAvisSup4>1 	&& pseudoUser="Stavefrid";