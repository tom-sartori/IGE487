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
  -- autres territoires

-- Territoire
insert into Territoire (code, nom) values
  ('Magog', 'Canton de Memprémagog'),
  ('Sherbrooke', 'Ville de Sherbrooke');

-- Distribution
insert into Distribution (territoire, station) values
  ('Sherbrooke', '10000'),
  ('Sherbrooke', '12000'),
  ('Sherbrooke', '13000'),
  ('Sherbrooke', '14000'),
  ('Sherbrooke', '15000'),
  ('Sherbrooke', '16000');

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
