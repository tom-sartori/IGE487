/*
-- =========================================================================== A
-- 4.3.1_SSQA_2_del.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Suppression des données inutiles dans le schéma SSQA_2.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

delete from Mesure ;
delete from distribution ;                  --
delete from Territoire ;                    --
delete from Capacite ;                      --
delete from Station ;                       --
delete from nom_station ;                   --
delete from immatriculation ;               --
delete from position ;                      --


/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Suppression des données inutiles dans le schéma SSQA_2.

-- -----------------------------------------------------------------------------
-- 4.3.1_SSQA_2_del.sql
-- =========================================================================== Z
*/
