
/*
Tentative d’insertion des données invalides à des fins de tests unitaires pour les tables
du schéma SSQA (système de surveillance de la qualité de l’air). Toutes les insertions
doivent entraîner une échec.

On suppose que les données valides du fichier SSQA_ins-val.sql ont été insérées
au préalable.

Un exemple est donné pour la table Unité.
Saurez-vous faire les tentatives d'insertion pour les autres tables ?
*/

-- Localisation du schéma
set schema 'SSQA';

-- Hors service
-- conflit entre la date de fin et de début
    insert into HorsService (idStation, dateDebut, dateFin, motif) values
        (1, '2017-01-01', '2016-01-01', 404) ;
-- conflit avec le mauvais type pour motif
    insert into HorsService (idStation, dateDebut, dateFin, motif) values
        (1, '2017-01-01', '2017-01-01', 'catastrophe') ;

-- Validation
-- conflit avec un test qui utilise l'ancien nom de la table Seuils
    insert into Seuils (idNorme, idVariable, min, max) values
        (1, 1, 1, 10) ;
-- conflit avec le min et max 
    insert into validation (idNorme, idVariable, min, max) values
        (1, 1, 10, 0) ;
-- Mesure
-- insertion d'une mesure absentes
INSERT INTO mesure (valeur, station, moment, variable)
VALUES (NULL, 17, '2023-09-01', 43);

-- station
-- conflit entre le début de service et la fin du service
    insert into Station (idStation, dateDebutService, dateFinService, mobilité) values
        (1, '2017-01-01', '2016-01-01', False) ;

    insert into station_nom (idStation, nom ) values
    (1, 'Station 1') ;

-- conflit avec le nom de la station
    insert into Station (idStation, dateDebutService, dateFinService, mobilité) values
        (2, '2017-01-01', '2019-01-01', True) ;
    insert into station_nom (idStation, nom ) values
    (2, NULL) ;
--conflit idstation null
    insert into Station (idStation, dateDebutService, dateFinService, mobilité) values
        (NULL, '2017-01-01', '2019-01-01', True) ;
    insert into station_nom (idStation, nom ) values
    (NULL, 'Station 1') ;   

-- unité

-- Conflit dans la création d'une nouvelle unité
    insert into Unite (idUnite, nom, symbole) values
        (1, 'kilogramme', 'kg') ;

--territoire

-- conflit avec le nom du territoire
    insert into Territoire (idTerritoire, nom) values
        (1, 'Territoire 1') ;
    insert into territoire_nom (idTerritoire, nom) values
        (1, NULL) ;

-- erreur_mesure

-- conflit avec la date de la mesure
    insert into erreur_mesure (idMesure, date, valeur, station, variable, motif) values
        (1, '2017-01-01', 1, 1, 1, 404) ;
    insert into erreur_mesure (idMesure, date, valeur, station, variable, motif) values
        (1, '2017-01-01', 1, 1, 1, 'catastrophe') ;

-- conflit avec la valeur de la mesure  
    insert into erreur_mesure (idMesure, date, valeur, station, variable, motif) values
        (1, '2017-01-01', '1', 1, 1, 404) ;

--capacité

-- conflit mesure avec capcité null
    insert into mesure (idMesure, valeur, station, moment, variable) values
        (16, 1, 1, '2017-01-01', 1) ;
    insert into capacite (idStation, variable) values
        (1,  NULL) ;

--exigence

-- conflit avec le min et max 
    insert into exigence (idNorme,idUnite, periode_unité, idVariable, min, max) values
        (1, 1, 'jour', 1, 1, 0) ;

