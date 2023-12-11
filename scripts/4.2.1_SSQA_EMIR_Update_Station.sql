/*
-- =========================================================================== A
-- 4.2.1_SSQA_EMIR_Update_Station.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Mise à jour de la procédure de modification de la position d'une station, afin qu'elle mette à jour l'entrepôt SSQA_DIM.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_PUB";
set schema 'SSQA_PUB';

-- station_mod_pos
--
-- Procédure de modification de la position d'une station.
--
-- @param i_station_code l'identifiant de la station.
-- @param i_station_latitude la latitude de la station.
-- @param i_station_longitude la longitude de la station.
-- @param i_station_altitude l'altitude de la station.
-- @param i_fin_ancienne_position la date de fin de l'ancienne position.
-- @param i_debut_nouvelle_position la date de début de la nouvelle position.
--
create or replace procedure station_mod_pos(
    i_station_code "SSQA".station_code,
    i_station_latitude "SSQA".latitude,
    i_station_longitude "SSQA".longitude,
    i_station_altitude "SSQA".altitude,
    i_fin_ancienne_position "SSQA".estampille,
    i_debut_nouvelle_position "SSQA".estampille
)
    language plpgsql as
$$
declare
    old_latitude "SSQA".latitude;
    old_longitude "SSQA".longitude;
    old_altitude "SSQA".altitude;
begin
    -- Modification de l'ancienne position dans la base relationnelle.
    update "SSQA".position
    set fin = i_fin_ancienne_position
    where station = i_station_code and position.fin is null
    returning latitude, longitude, altitude into old_latitude, old_longitude, old_altitude;

    -- Insertion de la nouvelle position dans la base relationnelle.
    insert into "SSQA".position
    values (i_station_code,
            i_station_latitude,
            i_station_longitude,
            i_station_altitude,
            i_debut_nouvelle_position,
            null);

    -- Si la station n'existe pas dans l'entrepot SSQA_DIM, on l'ajoute.
    INSERT into "SSQA_DIM".station
    select *
    from "SSQA".station
    where "SSQA".station.code = i_station_code
    ON CONFLICT DO NOTHING;

    -- Insertion du déplacement dans l'entrepot SSQA_DIM.
    insert into "SSQA_DIM".deplacement_fait
    values (i_station_code, -- station
            i_fin_ancienne_position, -- debut_deplacement
            i_debut_nouvelle_position - i_fin_ancienne_position, -- temps_deplacement
            old_latitude, -- latitude_debut
            old_longitude, -- longitude_debut
            old_altitude, -- altitude_debut
            i_station_latitude, -- latitude_fin
            i_station_longitude, -- longitude_fin
            i_station_altitude -- altitude_fin
           );
end;
$$;

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Mise à jour de la procédure de modification de la position d'une station, afin qu'elle mette à jour l'entrepôt SSQA_DIM.

-- -----------------------------------------------------------------------------
-- 4.2.1_SSQA_EMIR_Update_Station.sql
-- =========================================================================== Z
*/
