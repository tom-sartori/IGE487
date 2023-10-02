set schema 'SSQA';

create domain Code_erreur_mesure as integer;
create domain Description_rreur_mesure as varchar(255);

create table Erreur_mesure_code (
    code Code_erreur_mesure not null,
    nom Description_rreur_mesure not null,
    constraint Erreur_mesure_code_cc0 primary key (code)
);

create table Erreur_mesure (
    station Station_Code not null,
    moment Estampille not null,
    variable Variable_code not null,
    erreur_mesure_code Code_erreur_mesure not null,
    constraint Erreur_mesure_cc0 primary key (station, moment, variable, erreur_mesure_code),
    constraint Erreur_mesure_cr0 foreign key (station, moment, variable) references Mesure(station, moment, variable),
    constraint Erreur_mesure_cr1 foreign key (erreur_mesure_code) references Erreur_mesure_code(code)
);

-- Transfert des erreurs de mesure de la table Mesure vers la table Erreur_mesure
insert into Erreur_mesure_code (code, nom) values (-1, 'Inconnu');
insert into Erreur_mesure (station, moment, variable, erreur_mesure_code)
    select station, moment, variable, -1 from Mesure where valide = false;

-- Suppression de la colonne 'valide' de la table Mesure
alter table Mesure drop column valide;