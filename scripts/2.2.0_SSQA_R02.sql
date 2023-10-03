/*
-- =========================================================================== A
-- SSQA_R02.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Contraindre plus strictement les symboles.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

-- Selon moi, rien à mettre ici, les seules règles que j'ai trouvé sont des règles d'utilisation plutôt que de création
-- en plus, il est possible que l'uutilisateur ait à créer son propre symbole d'unité,
-- par exemple kg/m3, donc je ne vois pas comment on pourrait mettre des règles ici

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Etude du problème. Solution réalisée par la R01.


-- -----------------------------------------------------------------------------
-- SSQA_R01.sql
-- =========================================================================== Z
*/
