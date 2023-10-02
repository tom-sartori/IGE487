set schema 'SSQA';

/*
Tentative d’insertion des données invalides à des fins de tests unitaires pour les tables
du schéma SSQA (système de surveillance de la qualité de l’air). Toutes les insertions
doivent entraîner une échec.

On suppose que les données valides du fichier SSQA_ins-val.sql correspondant ont été insérées
au préalable.
*/

-- type methode invalide
insert into Variable (code, nom, unite, valref, methode) values ('T2', 'Température2', 'Ktest', 273.15, 'test');