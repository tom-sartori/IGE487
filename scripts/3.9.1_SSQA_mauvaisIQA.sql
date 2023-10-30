/*
-- =========================================================================== A
-- mauvaisIQA.sql
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

CREATE FUNCTION ssqa.TerritoireMauvaisIQA(@debut ssqa.estampille, @fin ssqa.estampille)
RETURN @retTerritoireMauvaisIQA TABLE
(
	StationCode ssqa.station_code PRIMARY KEY NOT NULL,
	Moment ssqa.estampille PRIMARY KEY NOT NULL,
	VariableCode ssqa.variable_code PRIMARY KEY NOT NULL,
	Territoire ssqa.territoire_code NOT NULL,
	IQA DECIMAL NOT NULL
)
AS
RETURN
(
	SELECT Station, CAST(Moment AS DATE), VariableCode, Territoire,IQA
	FROM ssqa.IQARegion(@debut, @fin)
	WHERE IQA > 51
)


--public
CREATE FUNCTION ssqa.TerritoireMauvaisIQAParmoi(@debut ssqa.estampille, @fin ssqa.estampille, @limite int)
RETURN TABLE
AS 
RETURN 
(
	SELECT Territoire
	FROM (
		SELECT MONTH(DATE(Moment)) AS y, YEAR(DATE(Moment) AS m,Territoire, COUNT(*)AS Count
		FROM ssqa.TerritoireMauvaisIQA(@debut, @fin)
		GROUP BY y,m
		)
	WHERE Count>=3
)

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca
    
-- -----------------------------------------------------------------------------
-- mauvaisIQA.sql
-- =========================================================================== Z
*/
