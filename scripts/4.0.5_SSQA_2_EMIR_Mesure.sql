/*
-- =========================================================================== A
-- 3.3.0_SQQA_2_EMIR_Mesure.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Ajout des procédures et fonctions EMIR pour les mesures.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SQQA_2_PUB";
set schema 'SQQA_2_PUB';

-- mesure_eva_gen
--
-- Fonction d'évaluation de toutes les mesures.
--
-- @return toutes les mesures
--
create or replace function mesure_eva_gen()
    returns setof "SQQA_2".mesure
    language sql as
    $$
        select *
        from "SQQA_2".mesure;
    $$;

-- mesure_eva_stat
--
-- Fonction d'évaluation de toutes les mesures d'une station.
--
-- @param i_station_id code de la station
-- @return toutes les mesures d'une station
--
create or replace function mesure_eva_stat(i_station_id "SQQA_2".station_code)
    returns setof "SQQA_2".mesure
    language sql as
    $$
        select *
        from "SQQA_2".mesure
        where station = i_station_id;
    $$;

-- mesure_eva_var
--
-- Fonction d'évaluation de toutes les mesures d'une variable.
--
-- @param i_variable_id code de la variable
-- @return toutes les mesures d'une variable
--
create or replace function mesure_eva_var(i_variable_id "SQQA_2".variable_code)
    returns setof "SQQA_2".mesure
    language sql as
    $$
        select *
        from "SQQA_2".mesure
        where variable = i_variable_id;
    $$;

-- mesure_eva_date
--
-- Fonction d'évaluation de toutes les mesures pour une date.
--
-- @param i_date date de la mesure
-- @return toutes les mesures pour une date
--
create or replace function mesure_eva_date(i_date "SQQA_2".estampille)
    returns setof "SQQA_2".mesure
    language sql as
    $$
        select *
        from "SQQA_2".mesure
        where moment = i_date;
    $$;

-- mesure_eva_stat_date
--
-- Fonction d'évaluation de toutes les mesures d'une station pour une date.
--
-- @param i_station_id code de la station
-- @param i_date date de la mesure
-- @return toutes les mesures d'une station pour une date
--
create or replace function mesure_eva_stat_date(i_station_id "SQQA_2".station_code, i_date "SQQA_2".estampille)
    returns setof "SQQA_2".mesure
    language sql as
    $$
        select *
        from "SQQA_2".mesure
        where station = i_station_id
        and moment = i_date;
    $$;

-- mesure_eva_stat_var
--
-- Fonction d'évaluation de toutes les mesures d'une station pour une variable.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @return toutes les mesures d'une station pour une variable
--
create or replace function mesure_eva_stat_var(i_station_id "SQQA_2".station_code, i_variable_id "SQQA_2".variable_code)
    returns setof "SQQA_2".mesure
    language sql as
    $$
        select *
        from "SQQA_2".mesure
        where station = i_station_id
        and variable = i_variable_id;
    $$;

-- mesure_eva_stat_var_date
--
-- Fonction d'évaluation de la mesure d'une station pour une variable et une date.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @param i_date date de la mesure
-- @return la mesure d'une station pour une variable et une date
--
create or replace function mesure_eva_stat_var_date(i_station_id "SQQA_2".station_code, i_variable_id "SQQA_2".variable_code, i_date "SQQA_2".estampille)
    returns setof "SQQA_2".mesure
    language sql as
    $$
        select *
        from "SQQA_2".mesure
        where station = i_station_id
        and variable = i_variable_id
        and moment = i_date;
    $$;

-- mesure_eva_stat_var_after_date
--
-- Fonction d'évaluation de toutes les mesures d'une station pour une variable et après une date.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @param i_date date minimale des mesures
-- @return toutes les mesures d'une station pour une variable et après une date
--
create or replace function mesure_eva_stat_var_after_date(i_station_id "SQQA_2".station_code, i_variable_id "SQQA_2".variable_code, i_date "SQQA_2".estampille)
    returns setof "SQQA_2".mesure
    language sql as
    $$
        select *
        from "SQQA_2".mesure
        where station = i_station_id
        and variable = i_variable_id
        and moment >= i_date;
    $$;

-- mesure_eva_stat_var_between_date
--
-- Fonction d'évaluation de toutes les mesures d'une station pour une variable et entre deux dates.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @param i_date_min date minimale des mesures
-- @param i_date_max date maximale des mesures
-- @return toutes les mesures d'une station pour une variable et entre deux dates
--
create or replace function mesure_eva_stat_var_between_date(i_station_id "SQQA_2".station_code, i_variable_id "SQQA_2".variable_code, i_date_min "SQQA_2".estampille, i_date_max "SQQA_2".estampille)
    returns setof "SQQA_2".mesure
    language sql as
    $$
        select *
        from "SQQA_2".mesure
        where station = i_station_id
        and variable = i_variable_id
        and moment >= i_date_min
        and moment <= i_date_max;
    $$;

-- mesure_mod_gen_sst_exs
--
-- Procédure de modification de la valeur d'une mesure.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @param i_date date de la mesure
-- @param i_valeur nouvelle valeur de la mesure
--
create or replace procedure mesure_mod_gen_sst_exs(i_station_id "SQQA_2".station_code, i_variable_id "SQQA_2".variable_code, i_date "SQQA_2".estampille, i_valeur "SQQA_2".mesure_valeur)
    language sql as
    $$
        update "SQQA_2".mesure
        set valeur = i_valeur
        where station = i_station_id
        and variable = i_variable_id
        and moment = i_date;
    $$;

--mesure_ins_gen_sst_exs
--
-- Procédure d'insertion d'une mesure. Si la valeur de la variable n'est pas comprise dans l'intervalle de la table validation pour cette variable et la norme choisie, une entrée est ajoutée dans la table erreur_mesure avec le code d'erreur 1.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @param i_date date de la mesure
-- @param i_valeur valeur de la mesure
--
create or replace procedure mesure_ins_gen_sst_exs(i_station_id "SQQA_2".station_code, i_variable_id "SQQA_2".variable_code, i_date "SQQA_2".estampille, i_valeur "SQQA_2".mesure_valeur, i_norme "SQQA_2".norme_code)
    language sql as
    $$
        insert into "SQQA_2".mesure (station, variable, moment, valeur)
        values (i_station_id, i_variable_id, i_date, i_valeur);

        insert into "SQQA_2".erreur_mesure (station, variable, moment, erreur_mesure_code)
        select i_station_id, i_variable_id, i_date, 1
        where not exists (
            select *
            from "SQQA_2".validation
            where variable = i_variable_id
            and norme = i_norme
            and min <= i_valeur
            and max >= i_valeur
        );
    $$;

-- mesure_ins_with_error
--
-- Procédure d'insertion d'une mesure avec une erreur de mesure.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @param i_date date de la mesure
-- @param i_valeur valeur de la mesure
-- @param i_erreur_mesure_code code de l'erreur de mesure
--
create or replace procedure mesure_ins_with_error(i_station_id "SQQA_2".station_code, i_variable_id "SQQA_2".variable_code, i_date "SQQA_2".estampille, i_valeur "SQQA_2".mesure_valeur, i_erreur_mesure_code "SQQA_2".code_erreur_mesure)
    language sql as
    $$
        insert into "SQQA_2".mesure (station, variable, moment, valeur)
        values (i_station_id, i_variable_id, i_date, i_valeur);

        insert into "SQQA_2".erreur_mesure (station, variable, moment, erreur_mesure_code)
        values (i_station_id, i_variable_id, i_date, i_erreur_mesure_code);
    $$;

-- mesure_ret_gen_sst_exs
--
-- Procédure de suppression d'une mesure.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @param i_date date de la mesure
--
create or replace procedure mesure_ret_gen_sst_exs(i_station_id "SQQA_2".station_code, i_variable_id "SQQA_2".variable_code, i_date "SQQA_2".estampille)
    language sql as
    $$
        delete from "SQQA_2".mesure
        where station = i_station_id
        and variable = i_variable_id
        and moment = i_date;
    $$;

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout des procédures et fonctions EMIR pour les mesures.

-- -----------------------------------------------------------------------------
-- 3.3.0_SQQA_2_EMIR_Mesure.sql
-- =========================================================================== Z
*/
