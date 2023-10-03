/*
-- =========================================================================== A
-- SSQA_R06.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Ajout la date de mise en service des stations, notamment à des fins de validation des temps de mesure.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

-- Ajout attribut debut_service et fin_service dans la table station
alter table Station add column debut_service Estampille;
alter table Station add column fin_service Estampille;

-- Ajout contrainte de debut_service et fin_service
alter table Station add constraint Station_date_service check (debut_service is null or fin_service is null or fin_service >= debut_service);

create domain Hors_service_code 
as integer not null;

create domain Description_hors_service
as varchar(255) not null;

-- Nature_Hors_service
--
-- La nature d'un hors service est modélisée par un code et une description.
--
create table Nature_Hors_service (
    code Hors_service_code not null,
    description Description_hors_service not null,
    constraint Nature_hors_service_cc0 primary key (code)
);

-- Hors_service
--
-- Un hors service est modélisé par une station, une date de début, une date de fin et une nature.
create table Hors_service (
    station Station_Code not null,
    debut Estampille not null,
    fin Estampille not null,
    nature Hors_service_code not null,
   
    constraint Hors_service_cc0 primary key (station, debut, nature),
    constraint Hors_service_cr0 foreign key (station) references Station(code),
    constraint Hors_service_cr1 foreign key (nature) references Nature_Hors_service(code),
    constraint Hors_service_dates_valides check (fin >= debut)
);

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Ajouter les attributs de mise en exploitation et de fin d’exploitation de la station.
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Création des domaines Hors_service_code et Description_hors_service.

-- -----------------------------------------------------------------------------
-- SSQA_R01.sql
-- =========================================================================== Z
*/
