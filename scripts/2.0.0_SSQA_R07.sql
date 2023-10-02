-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

-- Création attribut mobilité
alter table Station add column mobilite boolean;

-- Création table Position
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
