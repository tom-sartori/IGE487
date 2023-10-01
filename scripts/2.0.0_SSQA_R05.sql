set schema 'SSQA';

--Changement de type de la colonne methode dans la table variable
alter table variable alter column methode type integer using methode::integer;