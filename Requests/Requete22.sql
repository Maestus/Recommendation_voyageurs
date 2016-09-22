SET foreign_key_checks = 0;
DROP VIEW IF EXISTS VerifIP;
DROP VIEW IF EXISTS AvisTotal;
DROP VIEW IF EXISTS InfoIPTotal;
DROP VIEW IF EXISTS FraudeUtilisateur;
SET foreign_key_checks = 1;

CREATE VIEW VerifIP AS SELECT v.pseudoUser,IPTerminal FROM Terminal t,Voyageur v WHERE t.pseudoUser=v.pseudoUser;

CREATE VIEW AvisTotal AS SELECT idAvisVoy,pseudoUser FROM AvisVoy NATURAL JOIN Voyageur;

CREATE VIEW InfoIPTotal AS SELECT * FROM VerifIP NATURAL JOIN AvisTotal;

CREATE VIEW FraudeUtilisateur AS SELECT IPTerminal FROM VerifIP GROUP BY IPTerminal HAVING COUNT(pseudoUser)>=2;

SELECT pseudoUser FROM VerifIP WHERE IPTerminal IN(SELECT IPTerminal FROM FraudeUtilisateur);