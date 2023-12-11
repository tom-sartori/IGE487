/*
-- =========================================================================== A
-- 3.2.0_SQQA_2_EMIR_Station.sql
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
create schema if not exists "SQQA_2_PUB";
set schema 'SQQA_2_PUB';

-- station_eva_gen
--
-- Fonction d'évaluation de toutes les stations.
--
-- @return les identifiants de toutes les stations.
--
create or replace function station_eva_gen()
    returns setof "SQQA_2".station_code
    language sql as
    $$
        select code
        from "SQQA_2".station;
    $$;

-- station_eva_mobile
--
-- Fonction d'évaluation des stations mobiles.
--
-- @return les identifiants des stations mobiles.
--
create or replace function station_eva_mobile()
    returns setof "SQQA_2".station_code
    language sql as
    $$
        select code
        from "SQQA_2".station
        where mobilite = true;
    $$;

-- station_eva_fixe
--
-- Fonction d'évaluation des stations fixes.
--
-- @return les identifiants des stations fixes.
--
create or replace function station_eva_fixe()
    returns setof "SQQA_2".station_code
    language sql as
    $$
        select code
        from "SQQA_2".station
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
    i_station_code "SQQA_2".station_code
    )
    returns table (
        code "SQQA_2".station_code,
        debut_service "SQQA_2".estampille,
        fin_service   "SQQA_2".estampille,
        mobilite      "SQQA_2".station_mobilite,
        nom           "SQQA_2".station_nom,
        immatriculation "SQQA_2".immatriculation_code,
        latitude      "SQQA_2".latitude,
        longitude     "SQQA_2".longitude,
        altitude      "SQQA_2".altitude,
        territoire    "SQQA_2".territoire_code
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
        from "SQQA_2".station s
        left join "SQQA_2".nom_station ns on s.code = ns.code
        left join "SQQA_2".immatriculation i on s.code = i.station
        left join "SQQA_2".position p on s.code = p.station
        left join "SQQA_2".distribution d on s.code = d.station
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
    i_station_code "SQQA_2".station_code
    )
    returns table (
        station "SQQA_2".station_code,
        debut "SQQA_2".estampille,
        fin "SQQA_2".estampille,
        nature "SQQA_2".hors_service_code,
        description "SQQA_2".description_hors_service
    )
    language sql as
    $$
        select
            hs.station,
            hs.debut,
            hs.fin,
            nhs.code,
            nhs.description
        from "SQQA_2".hors_service hs
        join "SQQA_2".nature_hors_service nhs on nhs.code = hs.nature
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
    i_station_code "SQQA_2".station_code
    )
    returns "SQQA_2".capacite
    language sql as
    $$
        select *
        from "SQQA_2".capacite
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
    i_station_code "SQQA_2".station_code,
    i_station_latitude "SQQA_2".latitude,
    i_station_longitude "SQQA_2".longitude,
    i_station_altitude "SQQA_2".altitude
    )
    language sql as
    $$
        update "SQQA_2".position
        set fin = now()
        where station = i_station_code and position.fin is null;

        insert into "SQQA_2".position
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
    i_station_code "SQQA_2".station_code,
    i_station_immatriculation_code "SQQA_2".immatriculation_code,
    i_station_latitude "SQQA_2".latitude,
    i_station_longitude "SQQA_2".longitude,
    i_station_altitude "SQQA_2".altitude,
    i_station_nom "SQQA_2".station_nom,
    i_station_distribution "SQQA_2".distribution
    )
    language sql as
    $$
        insert into "SQQA_2".station
        values (i_station_code,
                now(),
                null,
                true);

        insert into "SQQA_2".immatriculation
        values (i_station_code,
                i_station_immatriculation_code);

        insert into "SQQA_2".position
        values (i_station_code,
                i_station_latitude,
                i_station_longitude,
                i_station_altitude,
                now(),
                null);

        insert into "SQQA_2".nom_station
        values (i_station_code,
                i_station_nom);

        insert into "SQQA_2".distribution
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
    i_station_code "SQQA_2".station_code,
    i_station_immatriculation_code "SQQA_2".immatriculation_code,
    i_station_distribution "SQQA_2".distribution,
    i_station_nom "SQQA_2".station_nom default null,
    i_station_latitude "SQQA_2".latitude default null,
    i_station_longitude "SQQA_2".longitude default null,
    i_station_altitude "SQQA_2".altitude default null
    )
    language sql as
    $$;
        insert into "SQQA_2".station
        values (i_station_code,
                now(),
                null,
                false);

        insert into "SQQA_2".immatriculation
        values (i_station_code,
                i_station_immatriculation_code);

        insert into "SQQA_2".nom_station
        values (i_station_code,
                i_station_nom);

        insert into "SQQA_2".distribution
        values (i_station_code,
                i_station_distribution);

        insert into "SQQA_2".position
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
    i_station_code "SQQA_2".station_code,
    i_variable_code "SQQA_2".variable_code
    )
    language sql as
    $$
        insert into "SQQA_2".capacite
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
    i_station_code "SQQA_2".station_code
    )
    language sql as
    $$
        delete
        from "SQQA_2".station
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
    i_station_code "SQQA_2".station_code,
    i_variable_code "SQQA_2".variable_code
    )
    language sql as
    $$
        delete
        from "SQQA_2".capacite
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
-- 3.2.0_SQQA_2_EMIR_Station.sql
-- =========================================================================== Z
*/
