/*
-- =========================================================================== A
-- SSQA_R01.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Modélisation adéquate des unités de mesure en termes des unités fondamentales du SI.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

-- Vide la table car les anciennes données ne sont plus valides
drop table if exists Unite cascade;

-- Unite
--
-- L'unité est modélisée par un symbole, un nom. Sa définition est complétée par une valeur de multiplication et une valeur d'addition par rapport à l'unité fondamentale associée.
-- Si l'unité est fondamentale, alors la valeur de multiplication est 1 et la valeur d'addition est 0.
--
create table Unite (
    sym Unite_Symbole not null,
    nom Unite_Nom not null unique,
    mult double precision not null,
    add double precision not null,
    constraint Unite_cc0 primary key (sym),
    constraint Unite_mult_positif check (mult >= 0)
);

-- Unite_fond
--
-- L'unité fondamentale est modélisée par un symbole et un nom.
--
create table Unite_fond (
    symbole Unite_Symbole not null,
    nom Unite_Nom not null unique,
    constraint Unite_fond_cc0 primary key (symbole)
);

-- Composition_unite
--
-- La composition d'une unité composite en termes d'unités fondamentales est modélisée par un symbole d'unité composite, un symbole d'unité fondamentale, et un exposant.
--
create table Composition_unite (
    symbole_unite_composite Unite_Symbole not null,
    symbole_unite_fondamentale Unite_Symbole not null,
    exposant integer not null,
    constraint Composition_unite_cc0 primary key (symbole_unite_composite, symbole_unite_fondamentale),
    constraint Composition_unite_cr0 foreign key (symbole_unite_composite) references Unite (sym),
    constraint Composition_unite_cr1 foreign key (symbole_unite_fondamentale) references Unite_fond (symbole)
);

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Modélisation adéquate des unités de mesure en termes des unités fondamentales du SI.
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Définition d’une fonction permettant d’ajouter de nouvelles unités composites.
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Permettre la définition d’unités fondamentales supplémentaires (par exemple, le bit).

-- -----------------------------------------------------------------------------
-- SSQA_R01.sql
-- =========================================================================== Z
*/
