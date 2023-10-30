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
