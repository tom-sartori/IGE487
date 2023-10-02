set schema 'SSQA';

--Ajout contrainte pour la table variable
alter table variable add constraint Variable_valref_valide check (min<=valref<=max where min,max=(select min,max from validation where variable=variable.code));


--Ajout contrainte pour la table exigence
alter table exigence add constraint exigence_min_valide check (val_min<=min<=val_max where val_min,val_max=(select min,max from validation where variable=exigence.variable));
alter table exigence add constraint exigence_max_valide check (val_min<=max<=val_max where val_min,val_max=(select min,max from validation where variable=exigence.variable));
