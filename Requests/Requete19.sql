select * from Signaler;
delete from CommentVoy where idCommentVoy IN(SELECT idCommentVoy from Signaler);

