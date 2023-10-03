/*
-- =========================================================================== A
-- SSQA_R08.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Vérification de l'attribut représentant une période maximale.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

-- Vérification à l'ajout dans la table Exigence que periode_unite est bien une unité de temps
-- On vérifie que l'unite referencée dans periode_unite n'a qu'une correspondance dans la table composition_unite et que son symbole_unite_fondamentale est 's'
create function verifier_periode_unite() returns trigger as $$
begin
    if (not exists (select 1 from composition_unite join unite on unite.sym = composition_unite.symbole_unite_composite where unite.sym = new.periode_unite and composition_unite.symbole_unite_fondamentale = 's' group by composition_unite.symbole_unite_composite having count(*) = 1)) then
        raise exception 'L''unité de la période n''est pas une unité de temps';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger verifier_periode_unite_trigger before insert or update on exigence for each row execute function verifier_periode_unite();

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Vérifier que l'unité de la période est une unité de temps.

-- -----------------------------------------------------------------------------
-- SSQA_R08.sql
-- =========================================================================== Z
*/
