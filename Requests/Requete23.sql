SET foreign_key_checks = 0;
DROP VIEW IF EXISTS RestTotal;
DROP VIEW IF EXISTS MoyNoteRest;
DROP VIEW IF EXISTS MaxEtoileVilleRest;

DROP VIEW IF EXISTS MagTotal;
DROP VIEW IF EXISTS MoyNoteMag;
DROP VIEW IF EXISTS MaxEtoileVilleMag;

DROP VIEW IF EXISTS HotelTotal;
DROP VIEW IF EXISTS MoyNoteHotel;
DROP VIEW IF EXISTS MaxEtoileVille;
SET foreign_key_checks = 1;

-- Restaurant

CREATE VIEW RestTotal AS SELECT idEtab,nomEtab,villeEtab FROM Etablissement NATURAL JOIN Restaurant;

CREATE VIEW MoyNoteRest AS SELECT a.idEtab, AVG(nbEtoileAvis) AS Moyenne,villeEtab FROM AvisVoy a,RestTotal r WHERE a.idEtab=r.idEtab GROUP BY idEtab;

CREATE VIEW MaxEtoileVilleRest AS SELECT villeEtab,MAX(Moyenne) AS 	MaxMoyenne 	FROM MoyNoteRest GROUP BY villeEtab;

SELECT idEtab,villeEtab FROM MoyNoteRest WHERE Moyenne IN(SELECT MaxMoyenne FROM MaxEtoileVilleRest) && villeEtab IN(SELECT villeEtab FROM MaxEtoileVilleRest);

-- Magasin

CREATE VIEW MagTotal AS SELECT idEtab,nomEtab,villeEtab FROM Etablissement NATURAL JOIN Magasin;

CREATE VIEW MoyNoteMag AS SELECT a.idEtab, AVG(nbEtoileAvis) AS Moyenne,villeEtab FROM AvisVoy a,MagTotal m WHERE a.idEtab=m.idEtab GROUP BY idEtab;

CREATE VIEW MaxEtoileVilleMag AS SELECT villeEtab,MAX(Moyenne) AS MaxMoyenne 	FROM MoyNoteMag GROUP BY villeEtab;

SELECT idEtab,villeEtab FROM MoyNoteMag WHERE Moyenne IN(SELECT MaxMoyenne FROM MaxEtoileVilleMag) && villeEtab IN(SELECT villeEtab FROM MaxEtoileVilleMag);

-- Hotel

CREATE VIEW HotelTotal AS SELECT idEtab,nomEtab,villeEtab FROM Etablissement NATURAL JOIN Hotel;

CREATE VIEW MoyNoteHotel AS SELECT a.idEtab,AVG(nbEtoileAvis) AS Moyenne,villeEtab FROM AvisVoy a,HotelTotal h WHERE a.idEtab=h.idEtab GROUP BY nomEtab;

CREATE VIEW MaxEtoileVille AS SELECT villeEtab,MAX(Moyenne) AS MaxMoyenne FROM 	MoyNoteHotel GROUP BY villeEtab;

SELECT idEtab,villeEtab FROM MoyNoteHotel WHERE Moyenne IN(SELECT MaxMoyenne FROM 	MaxEtoileVille) && villeEtab IN(SELECT villeEtab FROM MaxEtoileVille) GROUP BY villeEtab;