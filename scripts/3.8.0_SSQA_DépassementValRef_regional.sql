/*
-- =========================================================================== A
-- DépassementValRef_regional.sql
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

CREATE FUNCTION ssqa.DepassementValRefRegion ( @territoire_code ssqa.territoire_code, @debut ssqa.estampille, @fin ssqa.estampille)
RETURN RETURN @retDepassementValRefRegion TABLE
(
	StationCode ssqa.station_code PRIMARY KEY NOT NULL,
	Moment ssqa.estampille PRIMARY KEY NOT NULL,
	VariableCode ssqa.variable_code PRIMARY KEY NOT NULL,
	Dif_valReg DECIMAL NOT NULL
)
AS 
BEGIN
WITH @mesure_reg(Station, Moment, Variable,valeur)
	AS(	
		SELECT *
		FROM ssqa.MesureRegional(@territoire_code,@debut, @fin)
	)
	
	INSERT @retDepassementValRefRegion
	SELECT 
		M.Station,
		M.Moment,
		M.Variable,
		valeur-valref AS int
	FROM @mesure_reg AS M
		LEFT JOIN variable ON M.Variable = code
	RETURN
END

CREATE FUNCTION ssqa.PoluantDepassantRef(@territoire_code ssqa.territoire_code, @debut ssqa.estampille, @fin ssqa.estampille)
RETURN TABLE
AS
RETURN
(
	SELECT DISTINCT VariableCode
	FROM ssqa.DepassementValRefRegion(@territoire_code, @debut, @fin)
	WHERE Dif_valReg > 1.1
)

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout fonctions régionales. 

-- -----------------------------------------------------------------------------
-- DépassementValRef_regional.sql
-- =========================================================================== Z
*/
