set schema 'SSQA';

--Suppression de la colonne valides de la table mesure
Alter table mesure drop column valides;

-- Changements table seuils into validation
Alter table seuils rename to validation;



