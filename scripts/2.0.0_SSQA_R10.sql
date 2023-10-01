set schema 'SSQA';

create table Erreur_mesure (
    station Station_Code not null,
    moment not null,
    variable integer not null,
    erreur_mesure_code integer not null,
    constraint Erreur_mesure_cc0 primary key (station, moment, variable, erreur_mesure_code),
    foreign key (station) references Station(idStation),
    
    foreign key (variable) references Variable(idVariable),
    foreign key (erreur_mesure_code) references erreur_mesure_code(code)    
);

create table Erreur_mesure_code (
    code integer not null,
    nom varchar(50) not null,
    constraint Erreur_mesure_code_cc0 primary key (code)
);

-- Faire le transfert des données (avec un code 'inconnu' ?)

alter table Mesure drop column valide;