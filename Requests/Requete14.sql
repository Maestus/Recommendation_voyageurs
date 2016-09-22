SET foreign_key_checks = 0;
DROP VIEW IF EXISTS EtabProp;
SET foreign_key_checks = 1;

CREATE VIEW EtabProp AS SELECT idAvisVoy,nomEtab,a.idEtab,e.idVoyageur,a.nbEtoileAvis FROM AvisVoy a, Etablissement e WHERE a.idEtab=e.idEtab;

SELECT nomEtab,idAvisVoy,MAX(nbEtoileAvis) FROM EtabProp WHERE idVoyageur=4 GROUP BY nomEtab;