set schema 'SSQA';

create table Hors_service (
    idStation integer not null,
    dateDebut date not null,
    dateFin date not null,
    motif integer not null,
   constraint primary key (idStation, dateDebut, motif),
    foreign key (idStation) references Station(idStation),
    foreign key (motif) references nature_Hors_service(code)
);

create table Nature_Hors_service (
    code integer not null,
    nom varchar(50) not null,
    constraint Nature_hors_service_cc0 primary key (code)
);