/*
-- =========================================================================== A
-- 3.4.0_SQQA_2_EMIR_Variable.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Ajout des procédures et fonctions EMIR pour les variables.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SQQA_2_PUB";
set schema 'SQQA_2_PUB';

-- variable_eva_gen
--
-- Fonction d'évaluation de toutes les variables.
--
-- @return toutes les variables.
--
create or replace function variable_eva_gen()
    returns setof "SQQA_2".variable
    language sql
    as $$
        select *
        from "SQQA_2".variable
    $$;

-- variable_eva_one
--
-- Fonction d'évaluation d'une variable.
--
-- @param i_variable_id le code de la variable.
-- @return la variable.
--
create or replace function variable_eva_one(i_variable_id "SQQA_2".variable_code)
    returns "SQQA_2".variable
    language sql
    as $$
        select *
        from "SQQA_2".variable
        where code = i_variable_id
    $$;

-- variable_eva_unite
--
-- Fonction d'évaluation de toutes les variables d'une unité.
--
-- @param i_unite_symbole le symbole de l'unité.
-- @return toutes les variables de l'unité.
--
create or replace function variable_eva_unite(i_unite_symbole "SQQA_2".unite_symbole)
    returns setof "SQQA_2".variable
    language sql
    as $$
        select *
        from "SQQA_2".variable
        where unite = i_unite_symbole
    $$;

--variable_mod_gen_sst_exs
--
-- Fonction de modification d'une variable.
--
-- @param i_variable_id le code de la variable.
-- @param i_variable_nom le nouveau nom de la variable (optionnel).
-- @param i_unite_symbole le symbole de la nouvelle unité (optionnel).
-- @param i_variable_valref la nouvelle valeur de référence (optionnel).
-- @param i_variable_methode la nouvelle méthode (optionnel).
--
create or replace function variable_mod_gen_sst_exs(i_variable_id "SQQA_2".variable_code, i_variable_nom "SQQA_2".variable_nom, i_unite_symbole "SQQA_2".unite_symbole, i_variable_valref "SQQA_2".mesure_valeur, i_variable_methode "SQQA_2".methode_enum)
    returns void
    language sql
    as $$
        update "SQQA_2".variable
        set nom = coalesce(i_variable_nom, nom),
            unite = coalesce(i_unite_symbole, unite),
            valref = coalesce(i_variable_valref, valref),
            methode = coalesce(i_variable_methode, methode)
        where code = i_variable_id
    $$;

-- variable_ins_gen_sst_exs
--
-- Procédure d'insertion d'une variable.
--
-- @param i_variable_id le code de la variable. (unique)
-- @param i_variable_nom le nom de la variable.
-- @param i_unite_symbole le symbole de l'unité.
-- @param i_variable_valref la valeur de référence.
-- @param i_variable_methode la méthode.
--
create or replace procedure variable_ins_gen_sst_exs(i_variable_id "SQQA_2".variable_code, i_variable_nom "SQQA_2".variable_nom, i_unite_symbole "SQQA_2".unite_symbole, i_variable_valref "SQQA_2".mesure, i_variable_methode "SQQA_2".methode_enum)
    language sql
    as $$
        insert into "SQQA_2".variable
        values (i_variable_id, i_variable_nom, i_unite_symbole, i_variable_valref, i_variable_methode)
    $$;

-- variable_ret_gen_sst_exs
--
-- Procédure de retrait d'une variable.
--
-- @param i_variable_id le code de la variable.
--
create or replace procedure variable_ret_gen_sst_exs(i_variable_id "SQQA_2".variable_code)
    language sql
    as $$
        delete from "SQQA_2".variable
        where code = i_variable_id
    $$;

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout des procédures et fonctions EMIR pour les variables.

-- -----------------------------------------------------------------------------
-- 3.4.0_SQQA_2_EMIR_Variable.sql
-- =========================================================================== Z
*/