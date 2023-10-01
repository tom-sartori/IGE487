set schema 'SSQA';

--Ajout contraînte pour la table variable sur la colonne periode_unite 
alter table exigence add constraint exigence_cc2 check (periode_unite.type = 'durée' or periode_unite.type = 'instant');