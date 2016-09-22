SET foreign_key_checks = 0;
DROP VIEW IF EXISTS AvisHotel;
DROP VIEW IF EXISTS AvisRest;
DROP VIEW IF EXISTS AvisHotelRest;
SET foreign_key_checks = 1;

CREATE VIEW AvisHotel AS SELECT idAvisVoy,idVoyageur,etoileOfficielleHotel FROM AvisVoy a,Hotel h WHERE a.idEtab=h.idEtab;

CREATE VIEW AvisRest AS SELECT idAvisVoy,idVoyageur,etoileOfficielleRest FROM AvisVoy a,Restaurant r WHERE a.idEtab=r.idEtab;

CREATE VIEW AvisHotelRest AS SELECT * FROM AvisHotel UNION SELECT * FROM AvisRest;

SELECT idVoyageur FROM AvisHotelRest WHERE idVoyageur NOT IN(SELECT idVoyageur FROM AvisHotelRest WHERE etoileOfficielleHotel<=4) GROUP BY idVoyageur;