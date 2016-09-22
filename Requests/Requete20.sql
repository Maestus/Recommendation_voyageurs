SET foreign_key_checks = 0;
DROP VIEW IF EXISTS ComUtile;
SET foreign_key_checks = 1;

CREATE VIEW ComUtile AS SELECT idVoyageur,AVG(note) AS Utile FROM  NoteCommentUser n, CommentVoy c WHERE n.idCommentVoy=c.idCommentVoy GROUP BY idVoyageur;

SELECT idVoyageur FROM ComUtile WHERE Utile >= 4;