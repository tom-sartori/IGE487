/*
-- =========================================================================== A
-- SSQA_R05_ins-inv.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Tentatives erronées d'insertion de valeurs dans les tables Validation et Exigence.
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

-- valref invalide
insert into Validation (min, max, variable, norme) values (0, 45, 'test', 'test');

-- min invalide
insert into Exigence (variable, periode_valeur, periode_unite, min, max, norme, code) values ('test', 1, 's', 0, 50, 'test', 'test');

-- max invalide
insert into Exigence (variable, periode_valeur, periode_unite, min, max, norme, code) values ('test', 1, 's', 50, 10000, 'test', 'test2');


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
