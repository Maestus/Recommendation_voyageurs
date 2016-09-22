SET foreign_key_checks = 0;
DROP VIEW IF EXISTS QualiteHotel;
SET foreign_key_checks = 1;

CREATE VIEW QualiteHotel AS SELECT idEtab FROM Hotel WHERE idEtab NOT IN(SELECT a.idEtab FROM AvisVoy a NATURAL JOIN Hotel 
WHERE nbEtoileAvis<3 || etoileOfficielleHotel <2);

SELECT idEtab,nomEtab FROM QualiteHotel NATURAL JOIN Etablissement;