set schema 'SSQA';

-- Ajout contrainte pour la table variable
alter table variable add constraint Variable_valref_valide check (exists (select 1 from validation v where v.variable=variable.code and variable.valref between v.min and v.max));

-- Ajout contrainte pour la table exigence
alter table exigence add constraint Exigence_min_valide check (exists (select 1 from validation v where v.variable=exigence.variable and exigence.min between v.min and v.max));
alter table exigence add constraint Exigence_max_valide check (exists (select 1 from validation v where v.variable=exigence.variable and exigence.max between v.min and v.max));
