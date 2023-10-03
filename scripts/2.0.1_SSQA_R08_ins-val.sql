/*
-- =========================================================================== A
-- SSQA_R08_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Insertion de valeurs dans les tables Unite, Composition_Unite et Exigence.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

-- Création de deux unités composite de temps
insert into Unite (sym, nom, mult, add) values
  ('s2', 'seconde carrée', 1, 0),
  ('j', 'jour', 3600*24, 0);

insert into Composition_Unite (symbole_unite_composite, symbole_unite_fondamentale, exposant) values
  ('s2', 's', 2),
  ('j', 's', 1);

-- Insertion de deux exigences
insert into Exigence (norme, code, variable, periode_valeur, periode_unite, min, max) values
  ('NQMAA_2014', 'E1', 'CO', 1, 's2', 0, 100),
  ('NQMAA_2014', 'E2', 'CO', 1, 'j', 0, 100);


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
