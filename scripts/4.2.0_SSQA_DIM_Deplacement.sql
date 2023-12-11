/*
-- =========================================================================== A
-- 4.2.0_SSQA_DIM_Deplacement.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Ajout de la table de fait Deplacement_fait, au schéma SSQA_DIM.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_DIM";
set schema 'SSQA_DIM';

CREATE TABLE Deplacement_fait
(
    "station"           "SSQA".station_code,
    "debut_deplacement" "SSQA".estampille,
    "temps_deplacement" interval,
    "latitude_depart"   "SSQA".latitude  NOT NULL,
    "longitude_depart"  "SSQA".longitude NOT NULL,
    "altitude_depart"   "SSQA".altitude  NOT NULL,
    "latitude_fin"      "SSQA".latitude,
    "longitude_fin"     "SSQA".longitude,
    "altitude_fin"      "SSQA".altitude,
    PRIMARY KEY ("station", "debut_deplacement")
);

ALTER TABLE Deplacement_fait
    ADD CONSTRAINT "Deplacement_fait_cr0" FOREIGN KEY ("station") REFERENCES Station ("code");

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout de la table de fait Deplacement_fait
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout de la table de dimension Position
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout de la table de dimension Station

-- -----------------------------------------------------------------------------
-- 4.2.0_SSQA_DIM_Deplacement.sql
-- =========================================================================== Z
*/
