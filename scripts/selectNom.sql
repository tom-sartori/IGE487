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

