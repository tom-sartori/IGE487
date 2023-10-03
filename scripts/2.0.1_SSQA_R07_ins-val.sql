/*
-- =========================================================================== A
-- SSQA_R05_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Insertion de valeurs dans les tables Station et Position.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

-- Insertion de valeurs dans la table Station
insert into Station (code, nom, debut_service, fin_service, mobilite) values
('000004', 'Station 4', '2021-01-01', null, true),
('000005', 'Station 5', '2021-01-01', null, false);

-- Insertion de valeurs dans la table Position
insert into Position (station, latitude, longitude, altitude, debut, fin) values
('000004', 45.378, -71.928, 200, '2021-01-01', null),
('000005', 45.378, -71.928, 200, '2021-01-01', null);

-- Insertion de valeurs dans la table Immatriculation
insert into Immatriculation (station, immatriculation) values
('000004', '000004-1'),
('000005', '000005-1');


/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion de valeurs dans les tables Unite et Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05_ins-val.sql
-- =========================================================================== Z
*/
