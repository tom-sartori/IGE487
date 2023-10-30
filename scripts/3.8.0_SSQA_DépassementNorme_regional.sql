/*
-- =========================================================================== A
-- DepassementNorme_regional.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Fonctions en rapport aux normes régionales. 
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_PUB";
set schema 'SSQA_PUB';

CREATE FUNCTION ssqa.DepassementNormeRegion ( @territoire_code ssqa.territoire_code)
RETURN @retDepassementNormeRegion TABLE
(
	StationCode ssqa.station_code PRIMARY KEY NOT NULL,
	Moment ssqa.estampille PRIMARY KEY NOT NULL,
	Variable ssqa.variable_code PRIMARY KEY NOT NULL,
	Dif_min int NOT NULL,
	Dif_max int NOT NULL
)
AS
BEGIN
WITH @mesure_reg(Station, Moment, Variable,valeur)
	AS(	
		SELECT *
		FROM ssqa.MesureRegional(@territoire_code)
	)

	INSERT @retDepassementNormeRegion
	SELECT 
		Station,
		Moment,
		Variable,
		valeur-min AS int,
		max-valeur AS int
	FROM @mesure_reg
		LEFT JOIN exigence
	RETURN
END

CREATE FUNCTION ssqa.nbrStationNormeDepaser(@territoire_code ssqa.territoire_code, @limite int)
RETURN TABLE
AS
BEGIN
WITH @nbrstationPoluer(Station, nbr)
	AS(
		SELECT StationCode, COUNT(*)AS nbr
		FROM ssqa.DepassementNormeRegion(@territoire_code)
		GROUP BY StationCode
		WHERE Dif_min > 0
			AND Dif_max > 0
	)
	
	RETURN 
		SELECT StationCode
		FROM @nbrstationPoluer
		WHERE nbr > @limite
END
GO 

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Fonctions en rapport aux normes régionales. 

-- -----------------------------------------------------------------------------
-- DepassementNorme_regional.sql
-- =========================================================================== Z
*/
