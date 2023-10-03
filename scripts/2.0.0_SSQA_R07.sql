/*
-- =========================================================================== A
-- SSQA_R07.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Modification du schéma afin de pouvoir consigner l’évolution des coordonnées des stations.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

-- Création attribut mobilité
alter table Station add column mobilite boolean;

-- Position
--
-- La position d'une station est modélisée par un code de station, une latitude, une longitude, une altitude, une date de début et une date de fin.
--
create table Position (
    station Station_Code not null,
    latitude Latitude not null,
    longitude Longitude not null,
    altitude Altitude not null,
    debut Estampille not null,
    fin Estampille,
    constraint Position_cc0 primary key (station, debut),
    constraint Position_cr0 foreign key (station) references Station(code),
    constraint Position_dates_valides check (fin > debut)
);

-- Ajout à Position des tuples de la table Station (avec la date de début à now())
insert into Position (station, latitude, longitude, altitude, debut)
select code, latitude, longitude, altitude, now() from Station;

comment on column Position.debut is 'Les dates de début n''ont pas été répertoriées avant le 2023/10/01 et sont donc toutes égales à cette date.';

-- Suppression des attributs de la table Station
alter table Station drop column latitude;
alter table Station drop column longitude;
alter table Station drop column altitude;

create domain Immatricumation_code as varchar(50);

create table Immatriculation (
    station Station_Code not null,
    immatriculation Immatricumation_code not null,
    constraint immatriculation_cc0 primary key (station),
    constraint immatriculation_cr0 foreign key (station) references Station(code)
);

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Ajout de l'attribut mobilité à la table Station.
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Ajout des tables Position et Immatriculation.
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Ajout des contraintes de Position et Immatriculation.

-- -----------------------------------------------------------------------------
-- SSQA_R07.sql
-- =========================================================================== Z
*/
