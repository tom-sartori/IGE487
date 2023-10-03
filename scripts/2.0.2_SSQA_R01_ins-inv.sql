/*
-- =========================================================================== A
-- SSQA_R01_ins-inv.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Tentatives erronées d'insertion de valeurs dans la table Unite.
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

-- Unite
-- symbole trop long
insert into Unite (sym, nom, mult, add) values
    ('symbole vraiment trop long pour être pratique', 'peu importe', 1, 0);
-- symbole null
insert into Unite (sym, nom, mult, add) values
    (null, 'peu importe', 1, 0);
-- nom null
insert into Unite (sym, nom, mult, add) values
    ('sym', null, 1, 0);
-- mult null
insert into Unite (sym, nom, mult, add) values
    ('sym', 'peu importe', null, 0);
-- add null
insert into Unite (sym, nom, mult, add) values
    ('sym', 'peu importe', 1, null);
-- mult négatif
insert into Unite (sym, nom, mult, add) values
    ('sym', 'peu importe', -1, 0);
-- conflit de clé primaire
insert into Unite (sym, nom, mult, add) values
    ('s', 'peu importe', 1, 0);


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
