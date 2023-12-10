-- Unite
insert into Unite (sym, nom) values
  ('s', 'seconde'),
  ('h', 'heure'),
  ('a', 'année'),
  ('µg/m3', 'microgramme par mètre cube'),
  ('ppm', 'parties par million'),
  ('ppb', 'parties par milliard');

-- Variable
insert into Variable (code, nom, unite, valref, methode) values
  ('NO2', 'Dioxyde d’azote', 'ppb', 213, 'Moyenne horaire'),
  ('SO2', 'Dioxyde de soufre', 'ppb', 200, 'Moyenne des 3 dernières heures'),
  ('CO', 'Monoxyde de carbone', 'ppm', 30, 'Maximum sur quatre minutes'),
  ('PM25', 'Particules fines', 'µg/m3', 35, 'Moyenne horaire'),
  ('O3', 'Ozone', 'ppb', 82, 'Moyenne horaire');

-- Norme
insert into Norme (code, titre) values
  ('NQMAA_2014', 'Normes québécoises de mesure de l’air ambiant, édition 2014'),
  ('NCQAA_2015', 'Normes canadiennes de qualité de l’air ambiant, édition 2015'),
  ('NCQAA_2020', 'Normes canadiennes de qualité de l’air ambiant, édition 2020'),
  ('NCQAA_2025', 'Normes canadiennes de qualité de l’air ambiant, édition 2025');

-- Capacité
insert into Capacite (station, variable) values
  -- Territoire de Sherbrooke (données fictives)
  -- Noter que la station 16000 n'a pas la capcité de retourner des mesures de la variable O3.
    ('10000', 'NO2'), ('10000', 'SO2'), ('10000', 'CO'), ('10000', 'PM25'), ('10000', 'O3'),
    ('12000', 'NO2'), ('12000', 'SO2'), ('12000', 'CO'), ('12000', 'PM25'), ('12000', 'O3'),
    ('13000', 'NO2'), ('13000', 'SO2'), ('13000', 'CO'), ('13000', 'PM25'), ('13000', 'O3'),
    ('14000', 'NO2'), ('14000', 'SO2'), ('14000', 'CO'), ('14000', 'PM25'), ('14000', 'O3'),
    ('15000', 'NO2'), ('15000', 'SO2'), ('15000', 'CO'), ('15000', 'PM25'), ('15000', 'O3'),
    ('16000', 'NO2'), ('16000', 'SO2'), ('16000', 'CO'), ('16000', 'PM25');
  -- Territoire de Memprémagog (à venir)
  -- autres territoires (à venir)

-- Exigence
insert into Exigence (norme, code, variable, periode_valeur, periode_unite, min, max) values
  -- Diaoxyde d'azote
    ('NCQAA_2020', 'A1', 'NO2', 1, 'h', 0, 60),
    ('NCQAA_2025', 'A1', 'NO2', 1, 'h', 0, 42),
    ('NCQAA_2020', 'A2', 'NO2', 1, 'a', 0, 17.0),
    ('NCQAA_2025', 'A2', 'NO2', 1, 'a', 0, 12.0),
  -- Diaoxyde de soufre
    ('NCQAA_2020', 'B1', 'SO2', 1, 'h', 0, 70),
    ('NCQAA_2025', 'B1', 'SO2', 1, 'h', 0, 65),
    ('NCQAA_2020', 'B2', 'SO2', 1, 'a', 0, 5.0),
    ('NCQAA_2025', 'B2', 'SO2', 1, 'a', 0, 4.0),
  -- Particules fines
    ('NCQAA_2015', 'C1', 'PM25', 24, 'h', 0, 20),
    ('NCQAA_2020', 'C1', 'PM25', 24, 'h', 0, 27),
    ('NCQAA_2015', 'C2', 'PM25', 1, 'a', 0, 10.0),
    ('NCQAA_2020', 'C2', 'PM25', 1, 'a', 0, 8.8),
  -- Ozone
    ('NCQAA_2015', 'D1', 'O3', 8, 'h', 0, 63),
    ('NCQAA_2020', 'D1', 'O3', 8, 'h', 0, 62),
    ('NCQAA_2025', 'D1', 'O3', 8, 'h', 0, 60);

-- Validation
insert into Validation (variable, norme, min, max) values
  ('NO2', 'NQMAA_2014', 0, 600),
  ('SO2', 'NQMAA_2014', 0, 700),
  ('CO', 'NQMAA_2014', 0, 100),
  ('PM25', 'NQMAA_2014', 0, 200),
  ('O3', 'NQMAA_2014', 0, 800);

-- Station
/* inserer ces valeurs dans la table station 
04019,Trois-Rivières - Ursulines,04,"Face au 678, rue Hart",Trois-Rivières,URBAIN,1975-06-18,2011-06-28,46.3464,-72.537554
04020,Trois-Rivières - Des Draveurs,04,Avenue des Draveurs,Trois-Rivières,URBAIN,2011-08-26,2014-06-25,46.35222222,-72.54
04021,Trois-Rivières - École MEES,04,Rue Whitehead,Trois-Rivières,URBAIN,2014-07-23,,46.357211,-72.54612
04048,Trois-Rivières - Cap-de-la-Madeleine,04,Inters. Roy et Dorval,Trois-Rivières,URBAIN,1975-08-12,,46.3625,-72.51
04049,Trois-Rivières - Éc. l'Assomption,04,275 Montplaisir,Trois-Rivières,URBAIN,1985-04-19,2014-10-14,46.369909,-72.514422
*/
insert into Station (code, debut, fin , mobilite) values
(04019, '1975-06-18', '2011-06-28', false),
(04020, '2011-08-26', '2014-06-25', false),
(04021, '2014-07-23', null, false),
(04048, '1975-08-12', null, false),
(04049, '1985-04-19', '2014-10-14', false);

insert into immatriculation (code , immatriculation) values
(04019, 'Trois-Rivières - Ursulines'),
(04020, 'Trois-Rivières - Des Draveurs'),
(04021, 'Trois-Rivières - École MEES'),
(04048, 'Trois-Rivières - Cap-de-la-Madeleine'),
(04049, 'Trois-Rivières - Éc. l''Assomption');

insert into position (code, latitude, longitude, altitude) values
(04019, 46.3464, -72.537554, null),
(04020, 46.35222222, -72.54, null),
(04021, 46.357211, -72.54612, null),
(04048, 46.3625, -72.51, null),
(04049, 46.369909, -72.514422, null);

insert into nom_station (code, nom) values
(04019, 'Face au 678, rue Hart'),
(04020, 'Avenue des Draveurs'),
(04021, 'Rue Whitehead'),
(04048, 'Inters. Roy et Dorval'),
(04049, '275 Montplaisir');

insert into territoire (code, nom) values
(04, 'Trois-Rivières');

insert into distribution (territoire, station) values
(04, 04019),
(04, 04020),
(04, 04021),
(04, 04048),
(04, 04049);

insert into capacite (station, variable) values
(04019, 'NO2'),
(04019, 'SO2'),
(04019, 'CO'),
(04019, 'PM25'),
(04019, 'O3'),
(04020, 'NO2'),
(04020, 'SO2'),
(04020, 'CO'),
(04020, 'PM25'),
(04020, 'O3'),
(04021, 'NO2'),
(04021, 'SO2'),
(04021, 'CO'),
(04021, 'PM25'),
(04021, 'O3'),
(04048, 'NO2'),
(04048, 'SO2'),
(04048, 'CO'),
(04048, 'PM25'),
(04048, 'O3'),
(04049, 'NO2'),
(04049, 'SO2'),
(04049, 'CO'),
(04049, 'PM25'),
(04049, 'O3');

