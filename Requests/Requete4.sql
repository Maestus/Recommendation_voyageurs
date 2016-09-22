SET foreign_key_checks = 0;
DROP VIEW IF EXISTS Avis;
DROP VIEW IF EXISTS brico3;
DROP VIEW IF EXISTS TermUser;
DROP VIEW IF EXISTS GPSEtab;
DROP VIEW IF EXISTS GPS;
SET foreign_key_checks = 1;

Create view Avis as select Etablissement.idEtab,nomEtab,avg(nbEtoileAvis) as moyenne,typeEtab from 	AvisVoy,Etablissement 
where AvisVoy.idEtab=Etablissement.idEtab group by nomEtab;

Create view brico3 as select * from Magasin natural join Avis where categorie="bricolage" && 	moyenne>3;

CREATE VIEW TermUser AS SELECT * FROM Terminal WHERE pseudoUser="Ailwenn" && 	typeTerminal="mobile";

Create view GPSEtab as select brico3.idEtab,brico3.nomEtab,longiGPSEtab,latiGPSEtab from brico3 natural join Etablissement 
where Etablissement.idEtab=brico3.idEtab;

CREATE VIEW GPS AS SELECT * FROM TermUser NATURAL JOIN GPSEtab ;

SELECT nomEtab,((sqrt((latiGPSEtab-latiGPSTerminal)*(latiGPSEtab- latiGPSTerminal)+(longiGPSEtab-longiGPSTerminal)*(longiGPSEtab-longiGPSTerminal)))*100) as "Distance en Km" 
FROM GPS WHERE ((sqrt((latiGPSEtab-latiGPSTerminal)*(latiGPSEtab-latiGPSTerminal)+(longiGPSEtab-longiGPSTerminal)*(longiGPSEtab-longiGPSTerminal)))*100)<=5;