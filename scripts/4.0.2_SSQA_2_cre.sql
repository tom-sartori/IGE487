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
  constraint validation_cc0 primary key (variable, norme),
  constraint validation_cr0 foreign key (variable) references Variable(code),
  constraint validation_cr1 foreign key (norme) references Norme(code),
  constraint validation_min_max check (min <= max)
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
create domain estampille
timestamp
create table Station (
    code station_code not null,
    debut_service estampille not null,
    fin_service estampille,
    mobile boolean not null,
    constraint Station_cc0 primary key (code)
    constraint Station_cc1 unique (debut_service, fin_service)
    
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
