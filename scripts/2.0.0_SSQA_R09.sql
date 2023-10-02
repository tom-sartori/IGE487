set schema 'SSQA';

create table Nom_station (
    code Station_Code not null,
    nom Station_Nom not null,
    constraint Nom_station_cc0 primary key (code),
    constraint Nom_station_cr0 foreign key (code) references Station(code)
);

-- Insertion des données dans la table Nom_station, à partir de la table station.
insert into nom_station(code, nom)
select code, nom from Station;

-- Suppression de la colonne nom de la table station.
alter table Station
drop column nom;