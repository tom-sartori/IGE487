/*
-- =========================================================================== A
-- MesureRegional.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Calcul de mesure régionale. 
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_PUB";
set schema 'SSQA_PUB';

CREATE FUNCTION ssqa.MesureRegional ( @territoire_code ssqa.territoire_code)
RETURN TABLE
AS
RETURN
(
	SELECT *
	FROM mesure
	WHERE station EXISTS IN (SELECT station FROM distribution WHERE territoire = @territoire_code)
)

CREATE FUNCTION ssqa.MesureRegional ( @territoire_code ssqa.territoire_code, @debut ssqa.estampille, @fin ssqa.estampille)
RETURN TABLE
AS
RETURN
(
	SELECT *
	FROM mesure
	WHERE station EXISTS IN (SELECT station FROM distribution WHERE territoire = @territoire_code)
		AND moment.annee = @annee --valider struct estampille
)

CREATE FUNCTION ssqa.MesureStation ( @station_code ssqa.station_code)
RETURN TABLE
AS
RETURN
(
	SELECT *
	FROM mesure
	WHERE station = @station_code
)

CREATE FUNCTION ssqa.MesureStation ( @station_code ssqa.station_code, @debut ssqa.estampille, @fin ssqa.estampille)
RETURN TABLE
AS
RETURN
(
	SELECT *
	FROM mesure
	WHERE station = @station_code
		AND moment.annee = @annee --valider struct estampille
)

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Calcul de mesure régionale. 

-- -----------------------------------------------------------------------------
-- MesureRegional.sql
-- =========================================================================== Z
*/
