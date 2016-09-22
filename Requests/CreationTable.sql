-- Suppression des tables que l'on souhaite créer si déjà existante

SET foreign_key_checks = 0;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS NoteCommentUser;
DROP TABLE IF EXISTS Terminal;
DROP TABLE IF EXISTS Bonconseil;
DROP TABLE IF EXISTS MasterChef;
DROP TABLE IF EXISTS DreamLand;

DROP TABLE IF EXISTS Voyageur;
DROP TABLE IF EXISTS AvisVoy;
DROP TABLE IF EXISTS CommentVoy;

DROP TABLE IF EXISTS Proprietaire;
DROP TABLE IF EXISTS ReponseProp;
DROP TABLE IF EXISTS Signaler;
DROP TABLE IF EXISTS Promotion;

DROP TABLE IF EXISTS Etablissement;
DROP TABLE IF EXISTS Hotel;
DROP TABLE IF EXISTS Magasin;
DROP TABLE IF EXISTS Restaurant;
DROP TABLE IF EXISTS Prix;

DROP TABLE IF EXISTS Gerante;
SET foreign_key_checks = 1;


-- CREATION DES TABLES


CREATE TABLE User (
	pseudoUser varchar(20), nomUser varchar(30), prenomUser varchar(30), paysUser varChar(30), ageUser integer check (ageUser > 0), 
	PRIMARY KEY (pseudoUser),
	INDEX (pseudoUser)
) ENGINE=INNODB ;

CREATE TABLE MasterChef (
	userMC INT NOT NULL AUTO_INCREMENT,pseudoUser varchar(20), nivCulinaire varchar(10),
	PRIMARY KEY (userMC),
	INDEX (userMC),
	FOREIGN KEY (pseudoUser) REFERENCES User(pseudoUser) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;

CREATE TABLE DreamLand (
	userDL INT NOT NULL AUTO_INCREMENT,pseudoUser varchar(20), lieuFavoris varchar(50),
	PRIMARY KEY (userDL),
	INDEX (userDL),
	FOREIGN KEY (pseudoUser) REFERENCES User(pseudoUser) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;

CREATE TABLE Bonconseil (
	idBonconseil varchar(6),pseudoUser varchar(20), adresseBonconseil varchar(100),
	PRIMARY KEY (idBonconseil),
	INDEX (idBonconseil),
	FOREIGN KEY (pseudoUser) REFERENCES User(pseudoUser) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;


CREATE TABLE Voyageur (
	idVoyageur INT NOT NULL AUTO_INCREMENT, pseudoUser varchar(10), statut varchar(10),
	PRIMARY KEY (idVoyageur),
	INDEX(idVoyageur),
	FOREIGN KEY (pseudoUser) REFERENCES User(pseudoUser) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;

CREATE TABLE Etablissement (
	idEtab INT NOT NULL AUTO_INCREMENT, pseudoUser varChar(10), idVoyageur int not null, nomEtab varchar(30), adresseEtab varchar(50),
	villeEtab varchar(50), typeEtab varchar(20),latiGPSEtab float(50), longiGPSEtab float(50), tailleEtab integer, prioriteConsult integer check (prioriteConsult>=0 && prioriteConsult<=1),
	PRIMARY KEY (idEtab),
	INDEX (idEtab),
	FOREIGN KEY (idVoyageur) REFERENCES Voyageur(idVoyageur) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (pseudoUser) REFERENCES User(pseudoUser) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;

CREATE TABLE Prix (
	idPrix INT NOT NULL AUTO_INCREMENT, idEtab int not null, description varchar(100), prix integer check (prix >= 0),
	PRIMARY KEY (idPrix),
	FOREIGN KEY (idEtab) REFERENCES Etablissement (idEtab) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;

CREATE TABLE AvisVoy (
	idAvisVoy INT NOT NULL AUTO_INCREMENT, idVoyageur int not null, idEtab int not null, 
	nbEtoileAvis integer check (nbEtoileAvis >= 0 && nbEtoileAvis <= 5), evalPrixAvis integer check (evalPrixAvis >= 0), dateAvis date,
	PRIMARY KEY (idAvisVoy),
	INDEX (idAvisVoy),
	FOREIGN KEY (idVoyageur) REFERENCES Voyageur(idVoyageur) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (idEtab) REFERENCES Etablissement(idEtab) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;

CREATE TABLE CommentVoy (
	idCommentVoy INT NOT NULL AUTO_INCREMENT, pseudoUser varchar(10), idVoyageur int not null, idAvisVoy int not null, commentaireVoy varchar(300),
	PRIMARY KEY (idCommentVoy),
	INDEX (idCommentVoy),
	FOREIGN KEY (idAvisVoy) REFERENCES AvisVoy(idAvisVoy) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (idVoyageur) REFERENCES Voyageur(idVoyageur) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (pseudoUser) REFERENCES User(pseudoUser) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;

CREATE TABLE NoteCommentUser (
	idNoteCommentUser INT NOT NULL AUTO_INCREMENT, pseudoUser varchar(10), idCommentVoy int not null, note integer check (note >= 0 && note <= 5),
	PRIMARY KEY (idNoteCommentUser),
	INDEX (idNoteCommentUser),
	FOREIGN KEY (pseudoUser) REFERENCES User(pseudoUser) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (idCommentVoy) REFERENCES CommentVoy(idCommentVoy) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;

CREATE TABLE Terminal (
	idTerminal INT NOT NULL AUTO_INCREMENT, pseudoUser varchar(10), typeTerminal text not null, IPTerminal varchar(15),
	latiGPSTerminal float(50), longiGPSTerminal float(50),
	PRIMARY KEY (idTerminal),
	INDEX (idTerminal),
	FOREIGN KEY (pseudoUser) REFERENCES User(pseudoUser) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;

CREATE TABLE Proprietaire (
	pseudoUser varchar(10), idVoyageur int not null, inscriptionMail
enum('FALSE','TRUE'),
	PRIMARY KEY (pseudoUser, idVoyageur),
	INDEX (pseudoUser),
	INDEX (idVoyageur),
	FOREIGN KEY (idVoyageur) REFERENCES Voyageur(idVoyageur) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (pseudoUser) REFERENCES User(pseudoUser) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;

CREATE TABLE ReponseProp (
	idRepProp INT NOT NULL AUTO_INCREMENT, pseudoUser varchar(10), idVoyageur int not null, idCommentVoy int not null, commentRepProp text not null,
	PRIMARY KEY (idRepProp),
	INDEX (idRepProp),
	FOREIGN KEY (idCommentVoy) REFERENCES CommentVoy(idCommentVoy) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (idVoyageur) REFERENCES Voyageur(idVoyageur) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (pseudoUser) REFERENCES User(pseudoUser) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;

CREATE TABLE Gerante (
	idGerante varchar(6), requetesGerante text not null,
	PRIMARY KEY (idGerante),
	INDEX (idGerante)
) ENGINE=INNODB ;

CREATE TABLE Signaler (
	idSignaler INT NOT NULL AUTO_INCREMENT, pseudoUser varchar(10), idVoyageur int not null, idGerante varchar(6), 
	idCommentVoy int not null, signale varchar(500),
	PRIMARY KEY (idSignaler),
	INDEX (idSignaler),
	FOREIGN KEY (idCommentVoy) REFERENCES CommentVoy(idCommentVoy) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (idVoyageur) REFERENCES Voyageur(idVoyageur) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (pseudoUser) REFERENCES User(pseudoUser) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (idGerante) REFERENCES Gerante(idGerante) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;

CREATE TABLE Promotion (
	idPromo INT NOT NULL AUTO_INCREMENT, pseudoUser varChar(10), idVoyageur int not null, idEtab int not null, infoPromo text not null,
	PRIMARY KEY (idPromo),
	INDEX (idPromo),
	FOREIGN KEY (idVoyageur) REFERENCES Voyageur(idVoyageur) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (pseudoUser) REFERENCES User(pseudoUser) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (idEtab) REFERENCES Etablissement(idEtab) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;

CREATE TABLE Hotel (
	idEtab int not null, etoileOfficielleHotel integer check (etoileOfficielleHotel >= 0 && etoileOfficielleHotel <= 5),
	nbChambreTotal integer check (nbChambreTotal > 0), 
	nbChambreDispo integer check (nbChambreDispo <= nbChambreTotal),
	PRIMARY KEY (idEtab),
	INDEX (idEtab),
	FOREIGN KEY (idEtab) REFERENCES Etablissement(idEtab) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;

CREATE TABLE Magasin (
	idEtab int not null, categorie text not null,
	PRIMARY KEY (idEtab),
	INDEX (idEtab),
	FOREIGN KEY (idEtab) REFERENCES Etablissement(idEtab) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;

CREATE TABLE Restaurant (
	idEtab int not null, typeCuisine text not null,
	etoileOfficielleRest integer check (etoileOfficielleRest >= 0 && etoileOfficielleRest <= 5),
	PRIMARY KEY (idEtab),
	INDEX (idEtab),
	FOREIGN KEY (idEtab) REFERENCES Etablissement(idEtab) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB ;


-- INSERTION DES INFORMATIONS DANS LES TABLES

SET foreign_key_checks = 0;
LOAD DATA LOCAL INFILE 'Bonconseil.dat' INTO TABLE Bonconseil FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'MasterChef.dat' INTO TABLE MasterChef FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'DreamLand.dat' INTO TABLE DreamLand FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'User.dat' INTO TABLE User FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'NoteCommentUser.dat' INTO TABLE NoteCommentUser FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'Terminal.dat' INTO TABLE Terminal FIELDS TERMINATED BY '-';
LOAD DATA LOCAL INFILE 'Voyageur.dat' INTO TABLE Voyageur FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'AvisVoy.dat' INTO TABLE AvisVoy FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'CommentVoy.dat' INTO TABLE CommentVoy FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'Proprietaire.dat' INTO TABLE Proprietaire FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'ReponseProp.dat' INTO TABLE ReponseProp FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'Signaler.dat' INTO TABLE Signaler FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'Promotion.dat' INTO TABLE Promotion FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'Etablissement.dat' INTO TABLE Etablissement FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'Prix.dat' INTO TABLE Prix FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'Hotel.dat' INTO TABLE Hotel FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'Magasin.dat' INTO TABLE Magasin FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'Restaurant.dat' INTO TABLE Restaurant FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'Gerante.dat' INTO TABLE Gerante FIELDS TERMINATED BY ',';
SET foreign_key_checks = 1;
