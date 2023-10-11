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

create domain Unite_coef as decimal;

create table Unite (
    sym Unite_Symbole not null,
    nom Unite_Nom not null unique,
    mult Unite_coef not null,
    add Unite_coef not null,
    constraint Unite_cc0 primary key (sym),
    constraint Unite_mult_positif check (mult > 0)
);

-- Insertion dans Unite due à la suppression de la table.
insert into Unite(sym, nom, mult, add) values
('s', 'seconde', 1, 0);
insert into Unite(sym, nom, mult, add) values
('m', 'mètre', 1, 0);
insert into Unite(sym, nom, mult, add) values
('kg', 'kilogramme', 1, 0);
insert into Unite(sym, nom, mult, add) values
('mol', 'mole', 1, 0);
insert into Unite(sym, nom, mult, add) values
('K', 'kelvin', 1, 0);
insert into Unite(sym, nom, mult, add) values
('A', 'ampere', 1, 0);
insert into Unite(sym, nom, mult, add) values
('cd', 'candela', 1, 0);
insert into Unite(sym, nom, mult, add) values
('bit', 'bit', 1, 0);
insert into Unite(sym, nom, mult, add) values
('h', 'heure', 3600, 0);
insert into Unite(sym, nom, mult, add) values
('a', 'année', 3600*24*365, 0);
insert into Unite(sym, nom, mult, add) values
('µg/m3', 'microgramme par mètre cube', 1/1000000000.0, 0);
insert into Unite(sym, nom, mult, add) values
('ppb', 'parties par milliard', 1/1000000000.0, 0);
insert into Unite(sym, nom, mult, add) values
('ppm', 'parties par million', 1/1000000.0, 0);

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

create domain Composition_unite_exposant as integer;

create table Composition_unite (
    symbole_unite_composite Unite_Symbole not null,
    symbole_unite_fondamentale Unite_Symbole not null,
    exposant Composition_unite_exposant not null,
    constraint Composition_unite_cc0 primary key (symbole_unite_composite, symbole_unite_fondamentale),
    constraint Composition_unite_cr0 foreign key (symbole_unite_composite) references Unite (sym),
    constraint Composition_unite_cr1 foreign key (symbole_unite_fondamentale) references Unite_fond (symbole)
);

-- -- Création des références vers la nouvelle table Unite
alter table Variable add constraint Variable_cr0 foreign key (unite) references Unite (sym);
alter table Exigence add constraint Exigence_cr2 foreign key (periode_unite) references Unite (sym);


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
