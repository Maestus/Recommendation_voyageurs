SET foreign_key_checks = 0;
DROP VIEW IF EXISTS ToutAvis;
DROP VIEW IF EXISTS MaxAvis;
SET foreign_key_checks = 1;

create view ToutAvis as select idVoyageur,nbEtoileAvis as note,idEtab,dateAvis from AvisVoy; 

Create view MaxAvis as select idVoyageur,max(nbEtoileAvis) as note,idEtab,dateAvis from AvisVoy group by idEtab; 

select * from ToutAvis ta,MaxAvis ma where ta.idVoyageur=ma.idVoyageur && ta.note+2<=ma.note && (year(ta.dateAvis)-year(ma.dateAvis)<2 || year(ma.dateAvis)-year(ta.dateAvis)<2) group by ta.idVoyageur;