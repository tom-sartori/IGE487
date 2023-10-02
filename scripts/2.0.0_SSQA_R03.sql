/*
-- =========================================================================== A
-- SSQA_R03.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Changer le nom de la table Seuils pour « Validation ».
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

-- Renommage de la table Seuils pour Validation.
alter table Seuils rename to Validation;

-- Renommage des contraintes.
alter table Validation drop constraint Seuils_cc0;
alter table Validation drop constraint Seuils_cr0;
alter table Validation drop constraint Seuils_cr1;
alter table Validation drop constraint Seuils_min_max;

alter table Validation add constraint Validation_cc0 primary key (variable, norme);
alter table Validation add constraint Validation_cr0 foreign key (variable) references Variable(code);
alter table Validation add constraint Validation_cr1 foreign key (norme) references Norme(code);
alter table Validation add constraint Validation_min_max check (min <= max);

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Changer le nom de la table Seuils pour « Validation ».
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Faire percoler les conséquences de ce changement.

-- -----------------------------------------------------------------------------
-- SSQA_RO3.sql
-- =========================================================================== Z
*/
