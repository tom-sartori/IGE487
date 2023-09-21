/*
-- =========================================================================== A
-- SSQA_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.2.0b (d'après AirEstrie de Christina Khnaisser)
Statut : en vigueur
Résumé : Insertion des données de test pour les tables du schéma SSQA.
-- =========================================================================== A
*/

/*
Insertion des données valides à des fins de tests unitaires pour les tables
du schéma SSQA (système de surveillance de la qualité de l'air). Les données
ne sont pas nécessairement conforme à la réalité, bien que représentatives.
*/

-- Localisation du schéma
set schema 'SSQA';

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

-- Seuils
insert into Seuils (variable, norme, min, max) values
  ('NO2', 'NQMAA_2014', 0, 600),
  ('SO2', 'NQMAA_2014', 0, 700),
  ('CO', 'NQMAA_2014', 0, 100),
  ('PM25', 'NQMAA_2014', 0, 200),
  ('O3', 'NQMAA_2014', 0, 800);

-- Station
insert into Station (code, nom, longitude, latitude, altitude) values
  -- Territoire de Sherbrooke (données fictives)
      ('10000', 'Arr. Brompton', '45.4738', '-71.9437', '170'),
      ('12000', 'Arr. Fleurimont', '45.4037', '-71.8678', '180'),
      ('13000', 'Arr. Lennoxville', '45.3675', '-71.8564', '160'),
      ('14000', 'Arr. Mont-Bellevue', '45.3787', '-71.9054', '200'),
      ('15000', 'Arr. de Rock-Forest-Saint-Élie-Deauville', '45.3703', '-71.9900', '151'),
      ('16000', 'Arr. de Jacques-Cartier', '45.4018', '-71.9248', '130');
  -- Territoire de Memprémagog (à venir)
  -- autres territoires...

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

-- Mesure
--
-- Les mesures peuvent être importées séparément, à raison d'un fichier par
-- territoire, par exemple : SSQ_ins_mesure_Sherbrooke.sql pour le territoire
-- de Sherbrooke.

/*
-- =========================================================================== Z
Contributeurs :
  (LL01) Luc.Lavoie@USherbrooke.ca
  (CK01) Christina.Khnaisser@USherbrooke.ca

Adresse, droits d'auteur et copyright :
  Groupe Metis
  Département d'informatique
  Faculté des sciences
  Université de Sherbrooke
  Sherbrooke (Québec)  J1K 2R1
  Canada
  http://info.usherbrooke.ca/llavoie/
  [CC-BY-NC-4.0 (http://creativecommons.org/licenses/by-nc/4.0)]

Tâches projetées :
  NIL

Tâches réalisées :
  2022-11-24 (LL01) : Adaptation au problème SSQA.
  2020-01-31 (CK01) : Données complètes.
  2020-01-26 (CK01) : Création initiale.

Références (consultées le 2022-11-24) :
  [IMEI] https://fr.wikipedia.org/wiki/International_Mobile_Equipment_Identity
  [WGS84] http://spatialreference.org/ref/epsg/wgs-84/
  [Maps.ie] https://www.maps.ie/coordinates.html
  [Gouv-ca]
  Mesures polluants
    Programme de surveillance national de la pollution atmosphérique (SNPA)
	  http://data.ec.gc.ca/data/air/monitor/national-air-pollution-surveillance-naps-program/Data-Donnees/?lang=fr
  Mesure Météo
    Conditions météorologiques et climatiques passées - Données historiques
    https://climat.meteo.gc.ca/historical_data/search_historic_data_f.html
-- =========================================================================== Z
*/

