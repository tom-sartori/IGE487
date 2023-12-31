/*
-- =========================================================================== A
-- 3.1.0_SSQA_EMIR_Territoire.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Ajout des procédures et fonctions EMIR pour les territoires.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_PUB";
set schema 'SSQA_PUB';

-- territoire_eva_gen
--
-- Fonction d'évaluation de tous les territoires.
--
-- @return : tous les territoires.
--
create or replace function territoire_eva_gen()
    returns setof "SSQA".territoire
    language sql as
    $$
        select *
        from "SSQA".territoire;
    $$;

-- territoire_eva_one
--
-- Fonction d'évaluation d'un territoire.
--
-- @param i_code_territoire : code du territoire
--
-- @return : le territoire correspondant au code en paramètre.
--
create or replace function territoire_eva_unique(
        i_code_territoire "SSQA".territoire_code
    )
    returns "SSQA".territoire
    language sql as
    $$
        select *
        from "SSQA".territoire
        where code = i_code_territoire;
    $$;

-- territoire_mod_gen_sst_exs
--
-- Procédure de modification d'un territoire.
--
-- @param i_code_territoire : code du territoire (unique)
-- @param i_nouveau_code_territoire : nouveau code du territoire (optionnel)
-- @param i_nouveau_nom_territoire : nouveau nom du territoire (optionnel)
--
create or replace procedure territoire_mod_gen_sst_exs(
    i_code_territoire "SSQA".territoire_code,
    i_nouveau_code_territoire "SSQA".territoire_code = null,
    i_nouveau_nom_territoire "SSQA".territoire_nom = null
)
    language sql as
$$
update "SSQA".territoire
set
    code = coalesce(i_nouveau_code_territoire, code),
    nom = coalesce(i_nouveau_nom_territoire, nom)
where code = i_code_territoire;
$$;

-- territoire_ins_gen_sst_exs
--
-- Procédure d'insertion d'un territoire.
--
-- @param i_code_territoire : code du territoire (unique)
-- @param i_nom_territoire : nom du territoire
--
create or replace procedure territoire_ins_gen_sst_exs(
        i_code_territoire "SSQA".territoire_code,
        i_nom_territoire "SSQA".territoire_nom
    )
    language sql as
    $$
        insert into "SSQA".territoire(code, nom)
        values (i_code_territoire, i_nom_territoire);
    $$;

-- territoire_ret_gen_sst
--
-- Procédure de suppression d'un territoire.
--
-- @param i_code_territoire : code du territoire (unique)
--
create or replace procedure territoire_ret_gen_sst(
        i_code_territoire "SSQA".territoire_code
    )
    language sql as
    $$
        delete
        from "SSQA".territoire
        where code = i_code_territoire;
    $$;

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout des procédures et fonctions EMIR pour les territoires.

-- -----------------------------------------------------------------------------
-- 3.1.0_SSQA_EMIR_Territoire.sql
-- =========================================================================== Z
*/
