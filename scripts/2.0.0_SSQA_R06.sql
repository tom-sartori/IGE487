set schema 'SSQA';
--Ajout attribut debut_service et fin_service dans la table station
alter table station add column debut_service date not null;
alter table station add column fin_service date ;
--ajout contrainte de debut_service et fin_service
alter table station add constraint Station_cc0 check (fin_service is null or fin_service > debut_service);
create domains Motif_code 
as integer not null;
create table Hors_service (
    station Station_Code not null,
    débutbut Estampille not null,
    fin Estampille not null,
    nature Motif_code not null,
   constraint Hors_service_cc0 primary key (station, début,nature),
    foreign key (idStation) references Station(code),
    foreign key (nature) references nature_Hors_service(code)
    constraint Hors_service_cc1 check (dateFin > dateDebut)

);

create table Nature_Hors_service (
    code Motif_code not null,
    description varchar(50) not null,
    constraint Nature_hors_service_cc0 primary key (code)

);