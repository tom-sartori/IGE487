/*
-- =========================================================================== A
-- SSQA_R01_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Insertion des valeurs de référence pour les unités de mesure.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

insert into Unite(sym, nom, mult, add) values
    ('s', 'seconde', 1, 0),
    ('m', 'mètre', 1, 0),
    ('kg', 'kilogramme', 1, 0),
    ('mol', 'mole', 1, 0),
    ('K', 'kelvin', 1, 0),
    ('A', 'ampere', 1, 0),
    ('cd', 'candela', 1, 0),
    ('bit', 'bit', 1, 0),
    ('h', 'heure', 3600, 0),
    ('a', 'année', 3600*24*365, 0),
    ('µg/m3', 'microgramme par mètre cube', 1/1000000000, 0);

insert into Unite_fond(symbole, nom) values
    ('s', 'seconde'),
    ('m', 'mètre'),
    ('kg', 'kilogramme'),
    ('mol', 'mole'),
    ('K', 'kelvin'),
    ('A', 'ampère'),
    ('cd', 'candela'),
    ('bit', 'bit'),
    ('rad', 'radian'),
    ('sr', 'stéradian');

insert into Composition_unite(symbole_unite_composite, symbole_unite_fondamentale, exposant) values
    ('h', 's', 1),
    ('a', 's', 1),
    ('µg/m3', 'kg', 1),
    ('µg/m3', 'm', -3);


/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion des valeurs de référence pour les unités de mesure.

-- -----------------------------------------------------------------------------
-- SSQA_R01_ins-val.sql
-- =========================================================================== Z
*/
