Select nomEtab,AVG(nbEtoileAvis) as "Note Moyenne",AVG(evalPrixAvis) as "Moyenne des Prix" 
FROM AvisVoy a, Etablissement e WHERE a.idEtab=e.idEtab && nomEtab="BricoBazar";