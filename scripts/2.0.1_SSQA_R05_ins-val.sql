set schema 'SSQA';

insert into Unite (nom, sym, mult, add) values ('Kelvin', 'Ktest', 1, 0);

insert into Variable (code, nom, unite, valref, methode) values ('T', 'Température', 'Ktest', 273.15, 1);