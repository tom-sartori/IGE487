/*Statut : en vigueur
Résumé : Création des tables du schéma SSQA (système de surveillance de la qualité de l’air).
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

-- Unité
--
-- L’unité de mesure définie en termes des unités fondamentales du SI est identifiée
-- par le symbole «sym» et porte le nom «nom».
--
-- TODO 2022-11-24 (LL01) Ajouter les attributs requis par la définition en termes des unités fondamentales du SI.
-- TODO 2022-11-24 (LL01) Contraindre plus strictement les symboles.
create domain Unite_Symbole
  Text
  check (length(value) between 1 and 7);
--ou de façon équivalente
--  Text
--  check ((1 <= length(value)) and (length(value) <= 7));
--ou de façon équivalente :
--  varchar(7)
--  check (length(value) <> 0);

create domain Unite_Nom
  Text
  check (length(value) between 1 and 63);
create table Unite (
  sym Unite_Symbole not null,
  nom Unite_Nom not null,
  constraint Unite_cc0 primary key (sym),
  constraint Unite_cc1 unique (nom)
  );

-- Variable
--
-- La variable associée à un phénomène mesurable par une station est identifiée
-- par le code «code», se nomme «nom»; l’unité de mesure utilisée est «unite»,
-- la valeur de référence est «valref» et la méthode d’échantillonnage est
-- décrite par «methode».
--
-- DONE 2022-11-24 (LL01) Prendre en compte la valeur de référence et la méthode d’échantillonnage.
-- TODO 2022-11-24 (LL01) Afin de mieux valider les données, les méthodes devraient être codifiées.
--
create domain Variable_Code
  Text
  check (length(value) between 1 and 15);
create domain Variable_Nom
  Text
  check (length(value) between 1 and 63);
create domain Mesure_Valeur
  Double precision;
create table Variable (
  code Variable_Code not null,
  nom Variable_nom not null,
  unite Unite_Symbole not null,
  valref Mesure_valeur not null,
  methode Text not null,
  constraint Variable_cc0 primary key (code),
  constraint Variable_cc1 unique (nom),
  constraint Variable_cr0 foreign key (unite) references Unite(sym)
  );


-- Capacité
--
-- La station «station» a la capacité de mesurer la variable «variable».
--
create table Capacite (
  station Station_Code not null,
  variable Variable_Code not null,
  constraint Capacite_cc0 primary key (station, variable),
  constraint Capacite_cr0 foreign key (station) references Station (code),
  constraint Capacite_cr1 foreign key (variable) references Variable (code)
  );
--
create domain Territoire_Code
  Text
  check (length(value) between 1 and 15);
create domain Territoire_Nom
  Text
  check (length(value) between 1 and 63);
create table Territoire (
  code Territoire_Code not null,
  nom Territoire_Nom not null,
  constraint Territoire_cc0 primary key (code),
  constraint Territoire_cc1 unique (nom)
  );
-- Distribution
--
-- La station «station» se rapporte au territoire «territoire».
--
create table Distribution (
  territoire Territoire_Code not null,
  station Station_Code not null,
  constraint Distribution_cc0 primary key (territoire, station),
  constraint Distribution_cr1 foreign key (territoire) references Territoire (code),
  constraint Distribution_cr0 foreign key (station) references Station (code)
  );

-- Mesure
create table Mesure (
  station Station_Code not null,
  moment Estampille not null,
  variable Variable_Code not null,
  valeur Mesure_Valeur not null,
  constraint Mesure_cc0 primary key (station, moment, variable),
  constraint Mesure_cr0 foreign key (station, variable) references Capacite
  );
  create domain unite_coef
    Double precision;
-- Unite
create domain Unite_coef as decimal;

create table Unite (
    sym Unite_Symbole not null,
    nom Unite_Nom not null unique,
    mult Unite_coef not null,
    add Unite_coef not null,
    constraint Unite_cc0 primary key (sym),
    constraint Unite_mult_positif check (mult > 0)
);

-- Composition_unite
create table Composition_unite(
    exposant unite_coef not null,
    sym Unite_Symbole not null,
    sym_unite Unite_Symbole not null,
    
    );

-- Unite_fond
--
-- L'unité fondamentale est modélisée par un symbole et un nom.
--
create table Unite_fond (
    symbole Unite_Symbole not null,
    nom Unite_Nom not null unique,
    constraint Unite_fond_cc0 primary key (symbole)
);

create domain Composition_unite_exposant as integer;

create table Composition_unite (
    symbole_unite_composite Unite_Symbole not null,
    symbole_unite_fondamentale Unite_Symbole not null,
    exposant Composition_unite_exposant not null,
    constraint Composition_unite_cc0 primary key (symbole_unite_composite, symbole_unite_fondamentale),
    constraint Composition_unite_cr0 foreign key (symbole_unite_composite) references Unite (sym),
    constraint Composition_unite_cr1 foreign key (symbole_unite_fondamentale) references Unite_fond (symbole)
);

-- -- Création des références vers la nouvelle table Unite
alter table Variable add constraint Variable_cr0 foreign key (unite) references Unite (sym);
alter table Exigence add constraint Exigence_cr2 foreign key (periode_unite) references Unite (sym);

-- Norme
--
-- La norme identifiée par le code «code» est décrite dans le document portant le titre «titre».
--
create domain Norme_Code
  Text
  check (length(value) between 1 and 15);
create domain Norme_Titre
  Text
  check (length(value) between 1 and 255);
create table Norme (
  code Norme_Code not null,
  titre Norme_Titre not null,
  constraint Norme_cc0 primary key (code),
  constraint Norme_cc1 unique (titre)
  );

-- Validation

create table validation (
  variable Variable_Code not null,
  norme Norme_code not null,
  min Mesure_Valeur not null,
  max Mesure_Valeur not null,
  constraint Validation_cc0 primary key (variable, norme),
  constraint Validation_cr0 foreign key (variable) references Variable(code),
  constraint Validation_cr1 foreign key (norme) references Norme(code),
  constraint Validation_min_max check (min <= max)
  );

-- Exigence
--
create table Exigence (
  variable Variable_Code not null,
  norme Norme_Code not null,
  min Mesure_Valeur not null,
  max Mesure_Valeur not null,
  periode Mesure_Valeur not null,
  periode_unite Unite_Symbole not null,
  constraint Exigence_cc0 primary key (variable, norme),
  constraint Exigence_cr0 foreign key (variable) references Variable(code),
  constraint Exigence_cr1 foreign key (norme) references Norme(code),
  constraint Exigence_cr2 foreign key (periode_unite) references Unite(sym),
  constraint Exigence_min_max check (min <= max)
  );

 -- Territoire

 create domain Territoire_Nom
  Text
  check (length(value) between 1 and 63);
create domain Territoire_Code
    Text
    check (length(value) between 1 and 15);
create table Territoire (
    nom Territoire_Nom not null,
    code Territoire_Code not null,
    constraint Territoire_cc0 primary key (code)
    ); 

-- Station

create domain Station_Nom
  Text
  check (length(value) between 1 and 63);
create domain Station_Immatriculation
    Text
    check (length(value) between 1 and 15);
create domain station_code
    Text
    check (length(value) between 1 and 15); 
create domain estampille as
timestamp

-- Création attribut mobilité
create domain Station_mobilite as boolean;
create table Station (
    code station_code not null,
    debut_service estampille not null,
    fin_service estampille,
    mobile Station_mobilite not null,
    constraint Station_cc0 primary key (code)
    constraint Station_cc1 unique (debut_service, fin_service)
    
    );
-- Position
--
-- La position d'une station est modélisée par un code de station, une latitude, une longitude, une altitude, une date de début et une date de fin.
--
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
-- immatriculation
create table immatriculation(
    station station_code not null,
    immatriculation Station_Immatriculation not null,
    constraint immatriculation_cc0 primary key (station, immatriculation),
    constraint immatriculation_cr0 foreign key (station) references Station(code)
    );

--station_nom
create table station_nom(
    code station_code not null,
    nom Station_Nom not null,
    constraint station_nom_cc0 primary key (code, nom),
    constraint station_nom_cr0 foreign key (code) references Station(code)
    );

create domain Hors_service_code 
as integer not null;

create domain Description_hors_service
as varchar(255) not null;

-- Nature_Hors_service
--
-- La nature d'un hors service est modélisée par un code et une description.
--
create table Nature_Hors_service (
    code Hors_service_code not null,
    description Description_hors_service not null,
    constraint Nature_hors_service_cc0 primary key (code)
);

-- Hors_service
--
-- Un hors service est modélisé par une station, une date de début, une date de fin et une nature.
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

create domain Code_erreur_mesure as integer;
create domain Description_erreur_mesure as varchar(255);
-- Erreur_mesure_code
create table Erreur_mesure_code (
    code Code_erreur_mesure not null,
    nom Description_erreur_mesure not null,
    constraint Erreur_mesure_code_cc0 primary key (code)
);
-- Erreur_mesure
create table Erreur_mesure (
    station Station_Code not null,
    moment Estampille not null,
    variable Variable_code not null,
    erreur_mesure_code Code_erreur_mesure not null,
    constraint Erreur_mesure_cc0 primary key (station, moment, variable, erreur_mesure_code),
    constraint Erreur_mesure_cr0 foreign key (station, moment, variable) references Mesure(station, moment, variable),
    constraint Erreur_mesure_cr1 foreign key (erreur_mesure_code) references Erreur_mesure_code(code)
);
-- Creation de l'enum methode_enum.
create type methode_enum as enum('Moyenne horaire', 'Moyenne des 3 dernières heures', 'Maximum sur quatre minutes');



-- Capacite
begin transaction;
set transaction read write;
    alter table "SSQA".capacite
    drop constraint Capacite_cr0;

    alter table "SSQA".capacite
    add constraint Capacite_cr0 foreign key (station) references Station (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".capacite
    drop constraint Capacite_cr1;

    alter table "SSQA".capacite
    add constraint Capacite_cr1 foreign key (variable) references Variable (code) on delete cascade on update cascade;
commit transaction;



-- Distribution
begin transaction;
set transaction read write;
    alter table "SSQA".distribution
    drop constraint Distribution_cr0;

    alter table "SSQA".distribution
    add constraint Distribution_cr0 foreign key (station) references Station (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".distribution
    drop constraint Distribution_cr1;

    alter table "SSQA".distribution
    add constraint Distribution_cr1 foreign key (territoire) references Territoire (code) on delete cascade on update cascade;
commit transaction;


-- Mesure
begin transaction;
set transaction read write;
    alter table "SSQA".mesure
    drop constraint Mesure_cr0;

    alter table "SSQA".mesure
    add constraint Mesure_cr0 foreign key (station, variable) references Capacite on delete cascade on update cascade;
commit transaction;


-- Composition_unite
begin transaction;
set transaction read write;
    alter table "SSQA".composition_unite
    drop constraint Composition_unite_cr0;

    alter table "SSQA".composition_unite
    add constraint Composition_unite_cr0 foreign key (symbole_unite_composite) references Unite (sym) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".composition_unite
    drop constraint Composition_unite_cr1;

    alter table "SSQA".composition_unite
    add constraint Composition_unite_cr1 foreign key (symbole_unite_fondamentale) references Unite_fond (symbole) on delete cascade on update cascade;
commit transaction;


-- Variable
begin transaction;
set transaction read write;
    alter table "SSQA".variable
    drop constraint Variable_cr0;

    alter table "SSQA".variable
    add constraint Variable_cr0 foreign key (unite) references Unite (sym) on delete cascade on update cascade;
commit transaction;


-- Exigence
begin transaction;
set transaction read write;
    alter table "SSQA".exigence
    drop constraint Exigence_cr0;

    alter table "SSQA".exigence
    add constraint Exigence_cr0 foreign key (variable) references Variable (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".exigence
    drop constraint Exigence_cr1;

    alter table "SSQA".exigence
    add constraint Exigence_cr1 foreign key (norme) references Norme (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".exigence
    drop constraint Exigence_cr2;

    alter table "SSQA".exigence
    add constraint Exigence_cr2 foreign key (periode_unite) references Unite (sym) on delete cascade on update cascade;
commit transaction;


-- Validation
begin transaction;
set transaction read write;
    alter table "SSQA".validation
    drop constraint Validation_cr0;

    alter table "SSQA".validation
    add constraint Validation_cr0 foreign key (variable) references Variable (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".validation
    drop constraint Validation_cr1;

    alter table "SSQA".validation
    add constraint Validation_cr1 foreign key (norme) references Norme (code) on delete cascade on update cascade;
commit transaction;


-- Hors_service
begin transaction;
set transaction read write;
    alter table "SSQA".hors_service
    drop constraint Hors_service_cr0;

    alter table "SSQA".hors_service
    add constraint Hors_service_cr0 foreign key (station) references Station (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".hors_service
    drop constraint Hors_service_cr1;

    alter table "SSQA".hors_service
    add constraint Hors_service_cr1 foreign key (nature) references Nature_Hors_service (code) on delete cascade on update cascade;
commit transaction;


-- Position
begin transaction;
set transaction read write;
    alter table "SSQA".position
    drop constraint Position_cr0;

    alter table "SSQA".position
    add constraint Position_cr0 foreign key (station) references Station (code) on delete cascade on update cascade;
commit transaction;


-- Immatriculation
begin transaction;
set transaction read write;
    alter table "SSQA".immatriculation
    drop constraint immatriculation_cr0;

    alter table "SSQA".immatriculation
    add constraint immatriculation_cr0 foreign key (station) references Station (code) on delete cascade on update cascade;
commit transaction;


-- Nom_station
begin transaction;
set transaction read write;
    alter table "SSQA".nom_station
    drop constraint Nom_station_cr0;

    alter table "SSQA".nom_station
    add constraint Nom_station_cr0 foreign key (code) references Station (code) on delete cascade on update cascade;
commit transaction;


-- Erreur_mesure
begin transaction;
set transaction read write;
    alter table "SSQA".erreur_mesure
    drop constraint Erreur_mesure_cr0;

    alter table "SSQA".erreur_mesure
    add constraint Erreur_mesure_cr0 foreign key (station, moment, variable) references Mesure (station, moment, variable) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA".erreur_mesure
    drop constraint Erreur_mesure_cr1;

    alter table "SSQA".erreur_mesure
    add constraint Erreur_mesure_cr1 foreign key (erreur_mesure_code) references Erreur_mesure_code (code) on delete cascade on update cascade;
commit transaction;
-- Ajout contrainte pour la table variable
create function verifier_validation() returns trigger as $$
begin
    if (not exists (select 1 from variable where variable.code = new.variable and variable.valref between new.min and new.max)) then
        raise exception 'L''intervalle de validation est invalide';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger verifier_validation_trigger before insert or update on validation for each row execute function verifier_validation();

-- Ajout contrainte pour la table exigence
create function valider_exigence() returns trigger as $$
begin
    if (exists (select 1 from validation v where v.variable = new.variable and v.norme = new.norme and new.min not between v.min and v.max)) then
        raise exception 'La valeur minimale de l''exigence est invalide';
    end if;
    if (exists (select 1 from validation v where v.variable = new.variable and v.norme = new.norme and new.max not between v.min and v.max)) then
        raise exception 'La valeur maximale de l''exigence est invalide';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger valider_exigence_trigger before insert or update on exigence for each row execute function valider_exigence();


create function verifier_periode_unite() returns trigger as $$
begin
    if (exists (select from composition_unite where composition_unite.symbole_unite_composite = new.periode_unite and composition_unite.symbole_unite_fondamentale != 's')) then
        raise exception 'L''unité de la période n''est pas une unité de temps';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger verifier_periode_unite_trigger before insert or update on exigence for each row execute function verifier_periode_unite();

create function inserer_station(code Station_Code, nom Station_Nom, debut_service Estampille, fin_service Estampille, mobilite boolean) returns void as $$
begin
    if mobilite then
        insert into station(code, debut_service, fin_service, mobilite)
        values (code, debut_service, fin_service, mobilite);
        insert into nom_station(code, nom) 
        values (code, nom);
    else
        insert into station(code, debut_service, fin_service, mobilite)
        values (code, debut_service, fin_service, mobilite);
    end if;
end;
$$ language plpgsql;

