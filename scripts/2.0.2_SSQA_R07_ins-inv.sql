/*
-- =========================================================================== A
-- SSQA_R07_ins-inv.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Tentatives erronées d'insertion de valeurs dans les tables Station, Position et Immatriculation.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

/*
Tentative d’insertion des données invalides à des fins de tests unitaires pour les tables
du schéma SSQA (système de surveillance de la qualité de l’air). Toutes les insertions
doivent entraîner une échec.

On suppose que les données valides du fichier SSQA_ins-val.sql correspondant ont été insérées
au préalable.
*/

-- latitude null
insert into Position (station, latitude, longitude, altitude, debut, fin) values
('000004', null, -71.928, 200, '2021-01-01', null);

-- longitude null
insert into Position (station, latitude, longitude, altitude, debut, fin) values
('000004', 45.378, null, 200, '2021-01-01', null);

-- altitude null
insert into Position (station, latitude, longitude, altitude, debut, fin) values
('000004', 45.378, -71.928, null, '2021-01-01', null);

-- latitude invalide
insert into Position (station, latitude, longitude, altitude, debut, fin) values
('000004', 91, -71.928, 200, '2021-01-01', null);

-- longitude invalide
insert into Position (station, latitude, longitude, altitude, debut, fin) values
('000004', 45.378, 181, 200, '2021-01-01', null);

-- altitude invalide
insert into Position (station, latitude, longitude, altitude, debut, fin) values
('000004', 45.378, -71.928, -13000, '2021-01-01', null);

-- station inexistante
insert into Position (station, latitude, longitude, altitude, debut, fin) values
('000006', 45.378, -71.928, 200, '2021-01-01', null);

-- fin < debut
insert into Position (station, latitude, longitude, altitude, debut, fin) values
('000004', 45.378, -71.928, 200, '2021-01-01', '2020-01-01');

-- immatriculation null
insert into Immatriculation (station, immatriculation) values
('000004', null);

-- immatriculation invalide
insert into Immatriculation (station, immatriculation) values
('000004', '000004-1-1-a-a-a-a-a-a-a--a-a-a-a-a-a-a-a-aèazterèta');

-- station inexistante
insert into Immatriculation (station, immatriculation) values
('000006', '000006-1');

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
