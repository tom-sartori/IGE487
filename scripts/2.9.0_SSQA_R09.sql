/*
-- =========================================================================== A
-- SSQA_R09.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Rendre le nom de la station facultatif, dans la mesure où la station n’est pas mobile.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
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

-- Fonction d'insertion d'une station.
-- Si la station est mobile, le nom est obligatoire et est inséré dans la table nom_station.
-- Si la station n'est pas mobile, le nom est facultatif et n'est pas inséré dans la table nom_station.
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

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Nom de station facultatif.

-- -----------------------------------------------------------------------------
-- SSQA_R09.sql
-- =========================================================================== Z
*/
