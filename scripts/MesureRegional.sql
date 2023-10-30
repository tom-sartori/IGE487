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