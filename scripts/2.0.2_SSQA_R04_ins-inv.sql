set schema 'SSQA';

/*
Tentative d’insertion des données invalides à des fins de tests unitaires pour les tables
du schéma SSQA (système de surveillance de la qualité de l’air). Toutes les insertions
doivent entraîner une échec.

On suppose que les données valides du fichier SSQA_ins-val.sql correspondant ont été insérées
au préalable.
*/

-- valref invalide
insert into Variable (nom, unite, valref, methode, code) values ('test2', 'test', 0, 'test', 'test2');

-- min invalide
insert into Exigence (variable, periode_valeur, periode_unite, min, max, norme, code) values ('test', 1, 's', 0, 50, 'test', 'test');

-- max invalide
insert into Exigence (variable, periode_valeur, periode_unite, min, max, norme, code) values ('test2', 1, 's', 50, 10000, 'test', 'test2');