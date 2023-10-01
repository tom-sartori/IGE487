set schema 'SSQA';

--Ajout contraînte pour la table variable
alter table variable add constraint variable_cc0 check (idUnite is not null);
alter table variable add constraint variable_cc1 check (idVariable is not null);
alter table variable add constraint variable_cc2 check (nom is not null);
alter table variable add constraint variable_cc3 check (min<valref<max where min,max=(select min,max from validation where idVariable=variable.idVariable));


--Ajout contraînte pour la table exigence
alter table exigence add constraint exigence_cc0 check (code is not null);
alter table exigence add constraint exigence_cc1 check (min < max);

alter table exigence add constraint exigence_cc3 check ( min<exigence.min and exigence.max<max where min,max=(select min,max from validation where idVariable=exigence.idVariable));


