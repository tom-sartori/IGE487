/*
-- =========================================================================== A
-- SSQA_R10_ins-inv.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Tentatives erronées d'insertion de valeurs dans les tables Erreur_mesure_code et Erreur_mesure et Mesure.
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

-- code null
insert into Erreur_mesure_code (code, nom) values 
  (null, 'Capteur défectueux');

-- code non-unique
insert into Erreur_mesure_code (code, nom) values 
  (1, 'Capteur défectueux');

-- nom null
insert into Erreur_mesure_code (code, nom) values 
  (3, null);

-- code mauvais type
insert into Erreur_mesure_code (code, nom) values 
  ('test', 'osef');

-- nom trop long
insert into Erreur_mesure_code (code, nom) values 
  (3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec auctor, nisl nec tincidunt ultricies, nunc nisl aliquam nunc, sit amet aliquam nisl nunc vitae nisl. Donec auctor, nisl nec tincidunt ultricies, nunc nisl aliquam nunc, sit amet aliquam nisl nunc vitae nisl. Donec auctor, nisl nec tincidunt ultricies, nunc nisl aliquam nunc, sit amet aliquam nisl nunc vitae nisl. Donec auctor, nisl nec tincidunt ultricies, nunc nisl aliquam nunc, sit amet aliquam nisl nunc vitae nisl. Donec auctor, nisl nec tincidunt ultricies, nunc nisl aliquam nunc, sit amet aliquam nisl nunc vitae nisl. Donec auctor, nisl nec tincidunt ultricies, nunc nisl aliquam nunc, sit amet aliquam nisl nunc vitae nisl.');

-- code non-existant
insert into Erreur_mesure (station, moment, variable, erreur_mesure_code) values
  ('10000', '2021-01-01 00:00:01', 'CO', 3);

-- mesure non-existante
insert into Erreur_mesure (station, moment, variable, erreur_mesure_code) values
  ('10000', '2021-01-01 00:00:03', 'CO', 1);

-- colonne valide n'exsite plus
insert into Mesure (station, moment, variable, valeur, valide) values
  ('10000', '2021-01-01 00:00:03', 'CO', 50, true);

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
