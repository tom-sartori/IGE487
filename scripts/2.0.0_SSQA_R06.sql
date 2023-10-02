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

create table Nature_Hors_service (
    code Hors_service_code not null,
    description Description_hors_service not null,
    constraint Nature_hors_service_cc0 primary key (code)
);

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
