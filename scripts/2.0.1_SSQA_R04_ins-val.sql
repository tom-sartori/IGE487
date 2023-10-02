set schema 'SSQA';

insert into Variable(nom, unite, valref, methode, code) values ('test', 'test', 50, 'test', 'test');

insert into Norme(titre, code) values ('test', 'test');

insert into Validation(min, max, variable, norme) values (25, 75, 'test', 'test');