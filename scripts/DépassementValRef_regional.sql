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