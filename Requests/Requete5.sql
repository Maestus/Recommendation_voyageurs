SET foreign_key_checks = 0;
DROP VIEW IF EXISTS MinNote;
SET foreign_key_checks = 1;

create view MinNote as Select pseudoUser,note,idCommentVoy from NoteCommentUser where note >= 3;

select distinct nomEtab from MinNote, Restaurant, CommentVoy, AvisVoy ,Etablissement 
where typeCuisine="Indien" && MinNote.idCommentVoy=CommentVoy.idCommentVoy && CommentVoy.idAvisVoy=AvisVoy.idAvisVoy && AvisVoy.idEtab=Etablissement.idEtab && nbEtoileAvis>4; 