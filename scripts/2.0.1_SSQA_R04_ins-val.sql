/*
-- =========================================================================== A
-- SSQA_R04_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Insertion des valeurs dans les tables Validation, Variable et Norme.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

insert into Variable(nom, unite, valref, methode, code) values ('test', 'test', 50, 'Moyenne horaire', 'test');

insert into Norme(titre, code) values ('test', 'test');

insert into Validation(min, max, variable, norme) values (25, 75, 'test', 'test');

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion des valeurs dans la table Validation.

-- -----------------------------------------------------------------------------
-- SSQA_R04_ins-val.sql
-- =========================================================================== Z
*/
