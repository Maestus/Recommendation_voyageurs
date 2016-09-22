SET foreign_key_checks = 0;
DROP VIEW IF EXISTS offh;
DROP VIEW IF EXISTS offr;
DROP VIEW IF EXISTS noff;
DROP VIEW IF EXISTS h;
DROP VIEW IF EXISTS r;
DROP VIEW IF EXISTS a;
DROP VIEW IF EXISTS b;
SET foreign_key_checks = 1;

create view offh as select e.idEtab,nomEtab,etoileOfficielleHotel as etoile from Etablissement e,Hotel h where h.idEtab=e.idEtab;

create view offr as select e.idEtab,nomEtab,etoileOfficielleRest as etoile from Etablissement e,Restaurant r where r.idEtab=e.idEtab;

create view noff as select idEtab,avg(nbEtoileAvis) as avis from AvisVoy group by idEtab;

create view h as select * from offh natural left join noff;

create view r as select * from offr natural left join noff;

create view a as select idEtab,nomEtab,max(abs(etoile-avis)) as difference from r;

create view b as select idEtab,nomEtab,max(abs(etoile-avis)) as difference from h;

select (select nomEtab from a where difference>(select difference from b)) as nomEtabRestaurant, (select nomEtab from b where difference> (select difference from a)) as nomEtabHotel from a,b;
