SET foreign_key_checks = 0;
DROP VIEW IF EXISTS noteNul;
DROP VIEW IF EXISTS noteBien;
DROP VIEW IF EXISTS nbNoteNul;
DROP VIEW IF EXISTS nbNoteBien;
DROP VIEW IF EXISTS nbNul;
SET foreign_key_checks = 1;

create view noteNul as select pseudoUser, note from NoteCommentUser where note<2;

create view noteBien as select pseudoUser, note from NoteCommentUser where note>=2;

create view nbNoteNul as select pseudoUser,count(*) as nbNoteNul from noteNul group by pseudoUser;

create view nbNoteBien as select pseudoUser,count(*) as nbNoteBien from noteBien group by pseudoUser;

Create view nbNul as select * from nbNoteNul natural left join nbNoteBien;

create view radier as select pseudoUser,nbNoteNul,nbNoteBien from nbNul having(nbNoteNul)>=((nbNoteBien+nbNoteNul)*0.30) || nbNoteBien is NULL;

delete from Voyageur where pseudoUser in(select pseudoUSer from radier);

