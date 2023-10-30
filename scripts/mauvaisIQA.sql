
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