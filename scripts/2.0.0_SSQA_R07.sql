set schema 'SSQA';

alter table Station add column mobile boolean not null;

create table Station_nom (
    idStation Station_Code not null,
    nom Station_Nom not null,
    constraint Station_nom_cc0 primary key (idStation),
    foreign key (idStation) references Station(idStation)
    constraint Station_nom_cc1 check (nom is not null where idStation=Station.idStation and Station.mobile=true) 
);

create table Position (
    idStation Station_Code not null,
    latitude Latitude not null,
    longitude Longitude not null,
    debut Estampille not null,
    fin Estampille not null,
    constraint Position_cc0 primary key (idStation, debut),
    foreign key (idStation) references Station(idStation)
);

create table Immatriculation (
    idStation Station_Code not null,
    immatriculation varchar(50) not null,
    constraint immatriculation_cc0 primary key (idStation),
    foreign key (idStation) references Station(idStation)
);

alter table Station drop column latitude;
alter table Station drop column longitude;
alter table Station drop column nom;

