/*
-- =========================================================================== A
-- selectNom.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_PUB";
set schema 'SSQA_PUB';

-- all public

CREATE FUNCTION ssqa.StationNom (@station_code ssqa.station_code)
RETURN @nom_station
AS
RETURN
(
	SELECT nom
	FROM nom_station
	WHERE code = @station_code
)

CREATE FUNCTION ssqa.territoireNom (@territoire_code ssqa.territoire_code)
RETURN @territoire_nom
AS
RETURN
(
	SELECT nom
	FROM territoire
	WHERE code = @territoire_code
)

CREATE FUNCTION ssqa.variableNom (@variable_code ssqa.variable_code)
RETURN @variable_nom
AS
RETURN
(
	SELECT nom
	FROM variable
	WHERE code = @variable_code
)

CREATE FUNCTION ssqa.normeTitre (@norme_code ssqa.norme_code)
RETURN @norme_titre
AS
RETURN
(
	SELECT titre
	FROM norme
	WHERE code = @norme_code
)

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

-- -----------------------------------------------------------------------------
-- selectNom.sql
-- =========================================================================== Z
*/
