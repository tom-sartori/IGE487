/*
-- =========================================================================== A
-- SSQA_R06_ins-inv.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Tentatives erronées d'insertion de valeurs dans les tables Station, Nature_hors_service et Hors_service.
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

-- code hors-service null
insert into Nature_Hors_service (code, description) values
(null, 'Maintenance');

-- description hors-service null
insert into Nature_Hors_service (code, description) values
(1, null);

-- code hors-service invalide
insert into Nature_Hors_service (code, description) values
('test', 'peu importe');

-- description hors-service invalide
insert into Nature_Hors_service (code, description) values
(1, 'Une description beaucoup trop longue pour être valideeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');

-- date de fin de service antérieure à la date de début de service
insert into Station (code, nom, longitude, latitude, altitude, debut_service, fin_service) values
('000001', 'Station 1', 45.378, -71.925, 200, '2021-01-02', '2021-01-01');

-- station de référence inexistante
insert into Hors_service (station, debut, fin, nature) values
('000004', '2021-01-01', '2021-01-02', 1);

-- date de fin de hors-service antérieure à la date de début de hors-service
insert into Hors_service (station, debut, fin, nature) values
('000001', '2021-01-02', '2021-01-01', 1);

-- nature de hors-service inexistante
insert into Hors_service (station, debut, fin, nature) values
('000001', '2021-01-01', '2021-01-02', 5);

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
