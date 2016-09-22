SELECT e.idEtab,e.nomEtab FROM Etablissement e,Proprietaire p 
WHERE e.idVoyageur=p.idVoyageur && p.idVoyageur!=0004 && typeEtab="Restaurant" && villeEtab="Paris" GROUP BY idEtab;