/*
-- =========================================================================== A
-- 3.0.0_SSQA_Foreign-key-on-cascade.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Modification des contraintes de clés étrangères pour les mettre en cascade.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';


-- Capacite
begin transaction;
set transaction read write;
    alter table "SSQA".capacite
    drop constraint Capacite_cr0;

    alter table "SSQA".capacite
    add constraint Capacite_cr0 foreign key (station) references Station (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".capacite
    drop constraint Capacite_cr1;

    alter table "SSQA".capacite
    add constraint Capacite_cr1 foreign key (variable) references Variable (code) on delete cascade on update cascade;
commit transaction;


-- Distribution
begin transaction;
set transaction read write;
    alter table "SSQA".distribution
    drop constraint Distribution_cr0;

    alter table "SSQA".distribution
    add constraint Distribution_cr0 foreign key (station) references Station (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".distribution
    drop constraint Distribution_cr1;

    alter table "SSQA".distribution
    add constraint Distribution_cr1 foreign key (territoire) references Territoire (code) on delete cascade on update cascade;
commit transaction;


-- Mesure
begin transaction;
set transaction read write;
    alter table "SSQA".mesure
    drop constraint Mesure_cr0;

    alter table "SSQA".mesure
    add constraint Mesure_cr0 foreign key (station, variable) references Capacite on delete cascade on update cascade;
commit transaction;


-- Composition_unite
begin transaction;
set transaction read write;
    alter table "SSQA".composition_unite
    drop constraint Composition_unite_cr0;

    alter table "SSQA".composition_unite
    add constraint Composition_unite_cr0 foreign key (symbole_unite_composite) references Unite (sym) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".composition_unite
    drop constraint Composition_unite_cr1;

    alter table "SSQA".composition_unite
    add constraint Composition_unite_cr1 foreign key (symbole_unite_fondamentale) references Unite_fond (symbole) on delete cascade on update cascade;
commit transaction;


-- Variable
begin transaction;
set transaction read write;
    alter table "SSQA".variable
    drop constraint Variable_cr0;

    alter table "SSQA".variable
    add constraint Variable_cr0 foreign key (unite) references Unite (sym) on delete cascade on update cascade;
commit transaction;


-- Exigence
begin transaction;
set transaction read write;
    alter table "SSQA".exigence
    drop constraint Exigence_cr0;

    alter table "SSQA".exigence
    add constraint Exigence_cr0 foreign key (variable) references Variable (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".exigence
    drop constraint Exigence_cr1;

    alter table "SSQA".exigence
    add constraint Exigence_cr1 foreign key (norme) references Norme (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".exigence
    drop constraint Exigence_cr2;

    alter table "SSQA".exigence
    add constraint Exigence_cr2 foreign key (periode_unite) references Unite (sym) on delete cascade on update cascade;
commit transaction;


-- Validation
begin transaction;
set transaction read write;
    alter table "SSQA".validation
    drop constraint Validation_cr0;

    alter table "SSQA".validation
    add constraint Validation_cr0 foreign key (variable) references Variable (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".validation
    drop constraint Validation_cr1;

    alter table "SSQA".validation
    add constraint Validation_cr1 foreign key (norme) references Norme (code) on delete cascade on update cascade;
commit transaction;


-- Hors_service
begin transaction;
set transaction read write;
    alter table "SSQA".hors_service
    drop constraint Hors_service_cr0;

    alter table "SSQA".hors_service
    add constraint Hors_service_cr0 foreign key (station) references Station (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".hors_service
    drop constraint Hors_service_cr1;

    alter table "SSQA".hors_service
    add constraint Hors_service_cr1 foreign key (nature) references Nature_Hors_service (code) on delete cascade on update cascade;
commit transaction;


-- Position
begin transaction;
set transaction read write;
    alter table "SSQA".position
    drop constraint Position_cr0;

    alter table "SSQA".position
    add constraint Position_cr0 foreign key (station) references Station (code) on delete cascade on update cascade;
commit transaction;


-- Immatriculation
begin transaction;
set transaction read write;
    alter table "SSQA".immatriculation
    drop constraint immatriculation_cr0;

    alter table "SSQA".immatriculation
    add constraint immatriculation_cr0 foreign key (station) references Station (code) on delete cascade on update cascade;
commit transaction;


-- Nom_station
begin transaction;
set transaction read write;
    alter table "SSQA".nom_station
    drop constraint Nom_station_cr0;

    alter table "SSQA".nom_station
    add constraint Nom_station_cr0 foreign key (code) references Station (code) on delete cascade on update cascade;
commit transaction;


-- Erreur_mesure
begin transaction;
set transaction read write;
    alter table "SSQA".erreur_mesure
    drop constraint Erreur_mesure_cr0;

    alter table "SSQA".erreur_mesure
    add constraint Erreur_mesure_cr0 foreign key (station, moment, variable) references Mesure (station, moment, variable) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".erreur_mesure
    drop constraint Erreur_mesure_cr1;

    alter table "SSQA".erreur_mesure
    add constraint Erreur_mesure_cr1 foreign key (erreur_mesure_code) references Erreur_mesure_code (code) on delete cascade on update cascade;
commit transaction;

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Modification des contraintes de clés étrangères pour les mettre en cascade.

-- -----------------------------------------------------------------------------
-- 3.0.0_SSQA_Foreign-key-on-cascade.sql
-- =========================================================================== Z
*/
