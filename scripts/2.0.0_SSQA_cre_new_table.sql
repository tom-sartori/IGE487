set schema 'SSQA';

-- Hors service
create table HorsService (
    idStation integer not null,
    dateDebut date not null,
    dateFin date not null,
    motif integer not null,
    primary key (idStation, dateDebut, motif),
    foreign key (idStation) references Station(idStation),
    foreign key (motif) references nature_Hors_service(idMotif)
);
-- Nature Hors service
create table nature_Hors_service (
    idMotif integer not null,
    nom varchar(50) not null,
    primary key (idMotif)
);
-- Station nom
create table Station_nom (
    idStation integer not null,
    nom varchar(50) not null,
    primary key (idStation),
    foreign key (idStation) references Station(idStation)
);
-- Erreur mesure
create table erreur_mesure (
    station integer not null,
    moment date not null,
    variable integer not null,
    erreur_mesure_code integer not null,
    primary key (station, moment, variable, erreur_mesure_code),
    foreign key (station) references Station(idStation),
    
    foreign key (variable) references Variable(idVariable),
    foreign key (erreur_mesure_code) references erreur_mesure_code(code)    
)
;
-- Erreur mesure code
create table erreur_mesure_code (
    code integer not null,
    nom varchar(50) not null,
    primary key (code)
);
-- immatriculation
create table immatriculation (
    idStation integer not null,
    immatriculation varchar(50) not null,
    primary key (idStation),
    foreign key (idStation) references Station(idStation)
);

--distribution
create table distribution (
    idStation integer not null,
    idTerritoire integer not null,
    primary key (idStation, idTerritoire),
    foreign key (idStation) references Station(idStation),
    foreign key (idTerritoire) references Territoire(idTerritoire)
);
