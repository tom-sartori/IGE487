set schema 'SSQA';

Alter table mesure drop column valides;

-- Changements table seuils into validation
Alter table seuils rename to validation;

