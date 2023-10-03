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
Résumé : Insertion de valeurs dans les tables Station, Nature_hors_service et Hors_service.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

-- Insertion de valeurs dans la table Station
insert into Station (code, nom, longitude, latitude, altitude, debut_service, fin_service) values
('000001', 'Station 1', 45.378, -71.925, 200, '2021-01-01', null),
('000002', 'Station 2', 45.378, -71.925, 200, '2021-01-01', null),
('000003', 'Station 3', 45.378, -71.925, 200, '2021-01-01', null);

-- Insertion de valeurs dans la table Nature_hors_service
insert into Nature_hors_service (code, description) values
(-1, 'Inconnu'),
(1, 'Maintenance'),
(2, 'Calibration'),
(3, 'Réparation'),
(4, 'Autre');

-- Insertion de valeurs dans la table Hors_service
insert into Hors_service (station, debut, fin, nature) values
('000001', '2021-01-01', '2021-01-02', 1),
('000002', '2021-01-01', '2021-01-02', 2),
('000003', '2021-01-01', '2021-01-02', 3);

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
