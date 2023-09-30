
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
    insert into Seuils (idNorme, idUnite, valeur) values
        (1, 1, 1) ;

-- Mesure
-- insertion d'une mesure absentes
INSERT INTO mesure (valeur, station, moment, variable)
VALUES (NULL, 17, '2023-09-01', 43);


