/*
-- =========================================================================== A
-- 4.1.0_SSQA_DIM_Mesure.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Ajout des tables de fait et de dimension pour le schéma SSQA_DIM en rapport aux mesures valides et invalides.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_DIM";
set schema 'SSQA_DIM';

CREATE TABLE Mesure_valide_fait
(
    "station"   "SSQA".station_code,
    "moment"    "SSQA".estampille,
    "variable"  "SSQA".variable_code,
    "valeur"    "SSQA".mesure_valeur NOT NULL,
    "latitude"  "SSQA".latitude      NOT NULL,
    "longitude" "SSQA".longitude     NOT NULL,
    "altitude"  "SSQA".altitude      NOT NULL,
    PRIMARY KEY ("station", "moment", "variable")
);

CREATE TABLE Mesure_invalide_fait
(
    "station"                   "SSQA".station_code,
    "moment"                    "SSQA".estampille,
    "variable"                  "SSQA".variable_code,
    "valeur"                    "SSQA".mesure_valeur             NOT NULL,
    "latitude"                  "SSQA".latitude                  NOT NULL,
    "longitude"                 "SSQA".longitude                 NOT NULL,
    "altitude"                  "SSQA".altitude                  NOT NULL,
    "erreur_mesure_code"        "SSQA".Code_erreur_mesure        NOT NULL,
    "erreur_mesure_description" "SSQA".description_erreur_mesure NOT NULL,
    PRIMARY KEY ("station", "moment", "variable")
);

CREATE TABLE Variable
(
    "code"    "SSQA".variable_code,
    "nom"     "SSQA".variable_nom,
    "unite"   "SSQA".unite_symbole,
    "valref"  "SSQA".mesure_valeur,
    "methode" Text,
    PRIMARY KEY ("code")
);
CREATE UNIQUE INDEX "Variable_cc1" ON "variable" ("nom");

CREATE TABLE Station
(
    "code"          "SSQA".station_code     NOT NULL,
    "debut_service" "SSQA".estampille,
    "fin_service"   "SSQA".estampille,
    "mobilite"      "SSQA".station_mobilite,
    PRIMARY KEY ("code")
);

ALTER TABLE Mesure_valide_fait
    ADD CONSTRAINT "Mesure_valide_fait_cr0" FOREIGN KEY ("variable") REFERENCES Variable ("code")
    ON DELETE CASCADE;

ALTER TABLE Mesure_valide_fait
    ADD CONSTRAINT "Mesure_valide_fait_cr1" FOREIGN KEY ("station") REFERENCES Station ("code")
    ON DELETE CASCADE;

ALTER TABLE Mesure_invalide_fait
    ADD CONSTRAINT "Mesure_invalide_fait_cr0" FOREIGN KEY ("variable") REFERENCES Variable ("code")
    ON DELETE CASCADE;

ALTER TABLE Mesure_invalide_fait
    ADD CONSTRAINT "Mesure_invalide_fait_cr1" FOREIGN KEY ("station") REFERENCES Station ("code")
    ON DELETE CASCADE;


/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout de la table de fait Mesure_valide_fait.
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout de la table de fait Mesure_invalide_fait.
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout de la table de dimension Variable.
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout de la table de dimension Station.

-- -----------------------------------------------------------------------------
-- 4.1.0_SSQA_DIM_Mesure.sql
-- =========================================================================== Z
*/
