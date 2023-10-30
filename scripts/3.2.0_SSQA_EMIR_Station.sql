/*
-- =========================================================================== A
-- 3.2.0_SSQA_EMIR_Station.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Ajout des procédures et fonctions EMIR pour les stations.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_PUB";
set schema 'SSQA_PUB';

-- station_eva_gen
--
-- Fonction d'évaluation de toutes les stations.
--
-- @return les identifiants de toutes les stations.
--
create or replace function station_eva_gen()
    returns setof "SSQA".station_code
    language sql as
    $$
        select code
        from "SSQA".station;
    $$;

-- station_eva_mobile
--
-- Fonction d'évaluation des stations mobiles.
--
-- @return les identifiants des stations mobiles.
--
create or replace function station_eva_mobile()
    returns setof "SSQA".station_code
    language sql as
    $$
        select code
        from "SSQA".station
        where mobilite = true;
    $$;

-- station_eva_fixe
--
-- Fonction d'évaluation des stations fixes.
--
-- @return les identifiants des stations fixes.
--
create or replace function station_eva_fixe()
    returns setof "SSQA".station_code
    language sql as
    $$
        select code
        from "SSQA".station
        where mobilite = false;
    $$;

-- station_eva_unique
--
-- Fonction d'évaluation d'une station.
--
-- @param i_station_code l'identifiant de la station.
--
-- @return tous les attributs concernant la station.
--
create or replace function station_eva_unique(
    i_station_code "SSQA".station_code
    )
    returns table (
        code "SSQA".station_code,
        debut_service "SSQA".estampille,
        fin_service   "SSQA".estampille,
        mobilite      "SSQA".station_mobilite,
        nom           "SSQA".station_nom,
        immatriculation "SSQA".immatriculation_code,
        latitude      "SSQA".latitude,
        longitude     "SSQA".longitude,
        altitude      "SSQA".altitude,
        territoire    "SSQA".territoire_code
    )
    language sql as
    $$
        select
            s.code,
            s.debut_service,
            s.fin_service,
            s.mobilite,
            ns.nom,
            i.immatriculation,
            p.latitude,
            p.longitude,
            p.altitude,
            d.territoire
        from "SSQA".station s
        left join "SSQA".nom_station ns on s.code = ns.code
        left join "SSQA".immatriculation i on s.code = i.station
        left join "SSQA".position p on s.code = p.station
        left join "SSQA".distribution d on s.code = d.station
        where s.code = i_station_code and p.fin is null;
    $$;

-- station_eva_hs
--
-- Fonction d'évaluation des périodes d'indisponibilité d'une station.
--
-- @param i_station_code l'identifiant de la station.
--
-- @return les périodes d'indisponibilité de la station.
--
create or replace function station_eva_hs(
    i_station_code "SSQA".station_code
    )
    returns table (
        station "SSQA".station_code,
        debut "SSQA".estampille,
        fin "SSQA".estampille,
        nature "SSQA".hors_service_code,
        description "SSQA".description_hors_service
    )
    language sql as
    $$
        select
            hs.station,
            hs.debut,
            hs.fin,
            nhs.code,
            nhs.description
        from "SSQA".hors_service hs
        join "SSQA".nature_hors_service nhs on nhs.code = hs.nature
        where station = i_station_code;
    $$;

-- station_eva_capacite
--
-- Fonction d'évaluation des capacités d'une station.
--
-- @param i_station_code l'identifiant de la station.
--
-- @return les capacités de la station.
--
create or replace function station_eva_capacite(
    i_station_code "SSQA".station_code
    )
    returns "SSQA".capacite
    language sql as
    $$
        select *
        from "SSQA".capacite
        where station = i_station_code;
    $$;

-- station_mod_pos
--
-- Procédure de modification de la position d'une station.
--
-- @param i_station_code l'identifiant de la station.
-- @param i_station_latitude la latitude de la station.
-- @param i_station_longitude la longitude de la station.
-- @param i_station_altitude l'altitude de la station.
--
create or replace procedure station_mod_pos(
    i_station_code "SSQA".station_code,
    i_station_latitude "SSQA".latitude,
    i_station_longitude "SSQA".longitude,
    i_station_altitude "SSQA".altitude
    )
    language sql as
    $$
        update "SSQA".position
        set fin = now()
        where station = i_station_code and position.fin is null;

        insert into "SSQA".position
        values (
            i_station_code,
            i_station_latitude,
            i_station_longitude,
            i_station_altitude,
            now(),
            null
        );
    $$;

-- station_ins_mobile_sst
--
-- Procédure d'insertion d'une station mobile.
--
-- @param i_station_code l'identifiant de la station.
-- @param i_station_immatriculation_code l'immatriculation de la station.
-- @param i_station_latitude la latitude de la station.
-- @param i_station_longitude la longitude de la station.
-- @param i_station_altitude l'altitude de la station.
-- @param i_station_nom le nom de la station.
-- @param i_station_distribution la distribution de la station.
--
create or replace procedure station_ins_mobile_sst(
    i_station_code "SSQA".station_code,
    i_station_immatriculation_code "SSQA".immatriculation_code,
    i_station_latitude "SSQA".latitude,
    i_station_longitude "SSQA".longitude,
    i_station_altitude "SSQA".altitude,
    i_station_nom "SSQA".station_nom,
    i_station_distribution "SSQA".distribution
    )
    language sql as
    $$
        insert into "SSQA".station
        values (i_station_code,
                now(),
                null,
                true);

        insert into "SSQA".immatriculation
        values (i_station_code,
                i_station_immatriculation_code);

        insert into "SSQA".position
        values (i_station_code,
                i_station_latitude,
                i_station_longitude,
                i_station_altitude,
                now(),
                null);

        insert into "SSQA".nom_station
        values (i_station_code,
                i_station_nom);

        insert into "SSQA".distribution
        values (i_station_code,
                i_station_distribution);
    $$;

-- station_ins_fixe_sst
--
-- Procédure d'insertion d'une station fixe.
--
-- @param i_station_code l'identifiant de la station.
-- @param i_station_immatriculation_code l'immatriculation de la station.
-- @param i_station_distribution la distribution de la station.
-- @param i_station_nom le nom de la station (optionnel).
-- @param i_station_latitude la latitude de la station (optionnel).
-- @param i_station_longitude la longitude de la station (optionnel).
-- @param i_station_altitude l'altitude de la station (optionnel).
--
create or replace procedure station_ins_fixe_sst(
    i_station_code "SSQA".station_code,
    i_station_immatriculation_code "SSQA".immatriculation_code,
    i_station_distribution "SSQA".distribution,
    i_station_nom "SSQA".station_nom default null,
    i_station_latitude "SSQA".latitude default null,
    i_station_longitude "SSQA".longitude default null,
    i_station_altitude "SSQA".altitude default null
    )
    language sql as
    $$;
        insert into "SSQA".station
        values (i_station_code,
                now(),
                null,
                false);

        insert into "SSQA".immatriculation
        values (i_station_code,
                i_station_immatriculation_code);

        insert into "SSQA".nom_station
        values (i_station_code,
                i_station_nom);

        insert into "SSQA".distribution
        values (i_station_code,
                i_station_distribution);

        insert into "SSQA".position
        values (i_station_code,
                i_station_latitude,
                i_station_longitude,
                i_station_altitude,
                now(),
                null);
    $$;

-- station_ins_capacite
--
-- Procédure d'ajout d'une capacité à une station.
--
-- @param i_station_code l'identifiant de la station.
-- @param i_variable_code le code de la variable.
--
create or replace procedure station_ins_capacite(
    i_station_code "SSQA".station_code,
    i_variable_code "SSQA".variable_code
    )
    language sql as
    $$
        insert into "SSQA".capacite
        values (
            i_station_code,
            i_variable_code
        );
    $$;

-- station_ret_gen_sst
--
-- Procédure de suppression d'une station.
--
-- @param i_station_code l'identifiant de la station.
--
create or replace procedure station_ret_gen_sst(
    i_station_code "SSQA".station_code
    )
    language sql as
    $$
        delete
        from "SSQA".station
        where code = i_station_code;
    $$;

-- station_ret_capacite
--
-- Procédure de suppression d'une capacité d'une station.
--
-- @param i_station_code l'identifiant de la station.
-- @param i_variable_code le code de la variable.
--
create or replace procedure station_ret_capacite(
    i_station_code "SSQA".station_code,
    i_variable_code "SSQA".variable_code
    )
    language sql as
    $$
        delete
        from "SSQA".capacite
        where station = i_station_code
        and variable = i_variable_code;
    $$;

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout des procédures et fonctions EMIR pour les stations.

-- -----------------------------------------------------------------------------
-- 3.2.0_SSQA_EMIR_Station.sql
-- =========================================================================== Z
*/
