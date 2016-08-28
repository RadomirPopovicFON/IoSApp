DROP TABLE IF EXISTS "Kategorija";
CREATE TABLE `Kategorija` (
  `idKategorija` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  `nazivKategorije` varchar(50) NOT NULL,
  `nazivPodkategorije` varchar(50) NOT NULL
);
INSERT INTO "Kategorija" VALUES(1,'Glavna','Svet');
INSERT INTO "Kategorija" VALUES(2,'Glavna','Politika
');
INSERT INTO "Kategorija" VALUES(3,'Glavna','Kultura');
INSERT INTO "Kategorija" VALUES(4,'Glavna','IT');
INSERT INTO "Kategorija" VALUES(5,'Sport','Kosarka
');
INSERT INTO "Kategorija" VALUES(6,'Sport','Fudbal');
INSERT INTO "Kategorija" VALUES(7,'Sport','Odbojka');
INSERT INTO "Kategorija" VALUES(8,'Sport','Rukomet');
INSERT INTO "Kategorija" VALUES(9,'Sport','Vaterpolo
');
INSERT INTO "Kategorija" VALUES(10,'Zabava','Horoskop
');
INSERT INTO "Kategorija" VALUES(11,'Zabava','Zanimljivosti
');
INSERT INTO "Kategorija" VALUES(12,'Zabava','Putovanja
');
