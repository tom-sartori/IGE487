CREATE FUNCTION ssqa.IQA (@station_code ssqa.station_code, @estampille ssqa.estampille, @variable_code ssqa.variable_code)
RETURN int 
AS
BEGIN
	SET @valeur_mesure = (
		SELECT valeur  
		FROM mesure
		WHERE station = @station_code AND moment = @estampille AND variable = @variable_code
	)
	SET @val_ref = (
		SELECT valref FROM variable WHERE code = @variable_code 
	)
	RETURN ((@valeur_mesure / @val_ref) *50)
END
GO

CREATE FUNCTION ssqa.IQARegion (@debut ssqa.estampille, @fin ssqa.estampille)
RETURN RETURN @retIQARegion TABLE
(
	StationCode ssqa.station_code PRIMARY KEY NOT NULL,
	Moment ssqa.estampille PRIMARY KEY NOT NULL,
	VariableCode ssqa.variable_code PRIMARY KEY NOT NULL,
	Territoire ssqa.territoire_code NOT NULL
	IQA DECIMAL NOT NULL
)
AS 
BEGIN
WITH @mesure_reg(Station, Moment, Variable,valeur,Territoire)
	AS(	
		SELECT ssqa.MesureRegional(code,@debut, @fin),Territoire.code
		FROM territoire 
	)
	
	INSERT @retIQARegion
	SELECT 
		Station,
		Moment,
		Variable,
		Territoire,
		ssqa.IQA(Station,Moment,Variable)
	FROM @mesure_reg
		LEFT JOIN variable ON Variable = code
	RETURN
END
