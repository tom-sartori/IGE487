set schema 'SSQA';

insert into Unite(sym, nom, mult, add) values
    ('s', 'seconde', 1, 0),
    ('m', 'mètre', 1, 0),
    ('kg', 'kilogramme', 1, 0),
    ('mol', 'mole', 1, 0),
    ('K', 'kelvin', 1, 0),
    ('A', 'ampere', 1, 0),
    ('cd', 'candela', 1, 0),
    ('bit', 'bit', 1, 0),
    ('h', 'heure', 3600, 0),
    ('a', 'année', 3600*24*365, 0),
    ('µg/m3', 'microgramme par mètre cube', 1/1000000000, 0);

insert into Unite_fond(sym, nom) values
    ('s', 'seconde'),
    ('m', 'mètre'),
    ('kg', 'kilogramme'),
    ('mol', 'mole'),
    ('K', 'kelvin'),
    ('A', 'ampère'),
    ('cd', 'candela'),
    ('bit', 'bit'),
    ('rad', 'radian'),
    ('sr', 'stéradian');

insert into Composition_unite(symbole_unite_composite, symbole_unite_fondamentale, exposant) values
    ('h', 's', 1),
    ('a', 's', 1),
    ('µg/m3', 'kg', 1),
    ('µg/m3', 'm', -3);