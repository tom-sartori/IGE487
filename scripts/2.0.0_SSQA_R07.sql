set schema 'SSQA';

create table Station_nom (
    idStation integer not null,
    nom varchar(50) not null,
    constraint Station_nom_cc0 primary key (idStation),
    foreign key (idStation) references Station(idStation)
);

create table Position (
    idStation integer not null,
    latitude float not null,
    longitude float not null,
    debut date not null,
    fin date not null,
    constraint Position_cc0 primary key (idStation, debut),
    foreign key (idStation) references Station(idStation)
);

create table Immatriculation (
    idStation integer not null,
    immatriculation varchar(50) not null,
    constraint immatriculation_cc0 primary key (idStation),
    foreign key (idStation) references Station(idStation)
);

alter table Station drop column latitude;
alter table Station drop column longitude;
