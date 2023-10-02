/*
-- =========================================================================== A
-- SSQA_R04.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Différentes valeurs et intervalles de validité sont associés à la définition et l’exploitation des variables. Il est nécessaire de s’assurer que leur cohérence.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

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
    if (not exists (select 1 from validation v where v.variable = new.variable and new.min between v.min and v.max)) then
        raise exception 'La valeur minimale de l''exigence est invalide';
    end if;
    if (not exists (select 1 from validation v where v.variable = new.variable and new.max between v.min and v.max)) then
        raise exception 'La valeur maximale de l''exigence est invalide';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger valider_exigence_trigger before insert or update on exigence for each row execute function valider_exigence();

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Vérifier que la valeur de référence de la variable est comprise dans l’intervalle de validité.
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Vérifier que les min et max des exigences sont compris dans l’intervalle de validité.

-- -----------------------------------------------------------------------------
-- SSQA_RO4.sql
-- =========================================================================== Z
*/
