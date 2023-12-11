/*
-- =========================================================================== A
-- 4.1.1_SSQA_EMIR_Update_Mesure.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Modification des procédures EMIR d'ajout de mesures, afin qu'elles insèrent également dans la base dimensionnelle.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_PUB";
set schema 'SSQA_PUB';


--mesure_ins_gen_sst_exs
--
-- Procédure d'insertion d'une mesure. Si la valeur de la variable n'est pas comprise dans l'intervalle de la table validation pour cette variable et la norme choisie, une entrée est ajoutée dans la table erreur_mesure avec le code d'erreur 1.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @param i_date date de la mesure
-- @param i_valeur valeur de la mesure
--
create or replace procedure mesure_ins_gen_sst_exs(i_station_id "SSQA".station_code, i_variable_id "SSQA".variable_code, i_date "SSQA".estampille, i_valeur "SSQA".mesure_valeur, i_norme "SSQA".norme_code)
    language plpgsql as
    $$
        begin
        -- Si la mesure ne respecte pas les normes, on l'insère avec mesure_ins_with_error.
        if not exists (
            select *
            from "SSQA".validation
            where variable = i_variable_id
            and norme = i_norme
            and min <= i_valeur
            and max >= i_valeur
        ) then
            call mesure_ins_with_error(i_station_id, i_variable_id, i_date, i_valeur, 1);
            return;
        end if;

        -- Sinon, on l'insère normalement.

        -- Insertion de la mesure dans la base relationnelle.
        insert into "SSQA".mesure (station, variable, moment, valeur)
        values (i_station_id, i_variable_id, i_date, i_valeur);

        -- Insertion de la variable dans la base dimensionnelle, si elle n'existe pas déjà.
        insert into "SSQA_DIM".variable
        select *
        from "SSQA".variable
        where "SSQA".variable.code = i_variable_id
        ON CONFLICT DO NOTHING;

        -- Insertion de la station dans la base dimensionnelle, si elle n'existe pas déjà.
        insert into "SSQA_DIM".station
        select *
        from "SSQA".station
        where "SSQA".station.code = i_station_id
        ON CONFLICT DO NOTHING;

        -- Insertion de la mesure invalide dans la base dimensionnelle.
        insert into "SSQA_DIM".mesure_valide_fait
        select m.station, m.moment, m.variable, m.valeur, p.latitude, p.longitude, p.altitude
        from "SSQA".mesure m
        join "SSQA".station s on m.station = s.code
        join "SSQA".position p on s.code = p.station and p.fin is null
        where m.station = i_station_id AND m.variable = i_variable_id AND m.moment = i_date;

        end;
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
create or replace procedure mesure_ins_with_error(i_station_id "SSQA".station_code, i_variable_id "SSQA".variable_code, i_date "SSQA".estampille, i_valeur "SSQA".mesure_valeur, i_erreur_mesure_code "SSQA".code_erreur_mesure)
    language plpgsql as
    $$
    begin
        -- Insertion de la mesure dans la base relationnelle.
        insert into "SSQA".mesure (station, variable, moment, valeur)
        values (i_station_id, i_variable_id, i_date, i_valeur);

        -- Insertion de l'erreur de mesure dans la base relationnelle.
        insert into "SSQA".erreur_mesure (station, variable, moment, erreur_mesure_code)
        values (i_station_id, i_variable_id, i_date, i_erreur_mesure_code);

        -- Insertion de la variable dans la base dimensionnelle, si elle n'existe pas déjà.
        insert into "SSQA_DIM".variable
        select *
        from "SSQA".variable
        where "SSQA".variable.code = i_variable_id
        ON CONFLICT DO NOTHING;

        -- Insertion de la station dans la base dimensionnelle, si elle n'existe pas déjà.
        insert into "SSQA_DIM".station
        select *
        from "SSQA".station
        where "SSQA".station.code = i_station_id
        ON CONFLICT DO NOTHING;

        -- Insertion de la mesure invalide dans la base dimensionnelle.
        insert into "SSQA_DIM".mesure_invalide_fait
        select m.station, m.moment, m.variable, m.valeur, p.latitude, p.longitude, p.altitude, e.code, e.nom
        from "SSQA".mesure m
        join "SSQA".station s on m.station = s.code
        join "SSQA".position p on s.code = p.station and p.fin is null
        join "SSQA".erreur_mesure_code e on i_erreur_mesure_code = e.code
        where m.station = i_station_id AND m.variable = i_variable_id AND m.moment = i_date;

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
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Modification des procédures EMIR d'ajout de mesures, afin qu'elles insèrent également dans la base dimensionnelle.

-- -----------------------------------------------------------------------------
-- 4.1.1_SSQA_EMIR_Update_Mesure.sql
-- =========================================================================== Z
*/
