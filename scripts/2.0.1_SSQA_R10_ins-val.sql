/*
-- =========================================================================== A
-- SSQA_R10_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Insertion de valeurs dans les tables Erreur_mesure_code et Erreur_mesure et Mesure.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

-- Insertion de valeurs dans la table Erreur_mesure_code.
insert into Erreur_mesure_code (code, nom) values 
  (1, 'Capteur défectueux'),
  (2, 'Mesure hors échelle');

-- Insertion de valeurs dans la table Mesure.
insert into Mesure (station, moment, variable, valeur) values
  ('10000', '2021-01-01 00:00:01', 'CO', 50),
  ('10000', '2021-01-01 00:00:02', 'CO', 55);

-- Insertion de valeurs dans la table Erreur_mesure.
insert into Erreur_mesure (station, moment, variable, erreur_mesure_code) values
  ('10000', '2021-01-01 00:00:01', 'CO', 1),
  ('10000', '2021-01-01 00:00:02', 'CO', 2);

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
