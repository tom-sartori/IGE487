/*
-- =========================================================================== A
-- SSQA_R05.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Codification des méthodes d'échantillonnage.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

-- Creation de l'enum methode_enum.
create type methode_enum as enum('Moyenne horaire', 'Moyenne des 3 dernières heures', 'Maximum sur quatre minutes');

-- Suppression des variables qui ont une methode qui n'est pas dans l'enum.
delete from Variable where methode not in ('Moyenne horaire', 'Moyenne des 3 dernières heures', 'Maximum sur quatre minutes');

-- Modification du type de la colonne methode de la table Variable, par l'enum précédente.
alter table Variable
alter column methode TYPE methode_enum USING methode::methode_enum;


/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Création d'une enum pour la colonne methode de la table Variable.
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Modification du type de la colonne methode de la table Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05.sql
-- =========================================================================== Z
*/
