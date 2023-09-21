/*
-- =========================================================================== A
-- SSQA_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.2.0a (d’après AirEstrie de Christina Khnaisser)
Statut : en vigueur
Résumé : Tentatives d’insertion des données invalides pour les tables du schéma SSQA.
-- =========================================================================== A
*/

/*
Tentative d’insertion des données invalides à des fins de tests unitaires pour les tables
du schéma SSQA (système de surveillance de la qualité de l’air). Toutes les insertions
doivent entraîner une échec.

On suppose que les données valides du fichier SSQA_ins-val.sql ont été insérées
au préalable.

Un exemple est donné pour la table Unité.
Saurez-vous faire les tentatives d'insertion pour les autres tables ?
*/

-- Localisation du schéma
set schema 'SSQA';

-- Unite
-- symbole trop long
  insert into Unite (sym, nom) values
    ('symbole vraiment trop long pour être pratique', 'peu importe') ;
-- conflit de clé primaire (sym)
  insert into Unite (sym, nom) values
    ('s', 'semaine') ;
-- conflit de clé secondaire (nom)
  insert into Unite (sym, nom) values
    ('an', 'année') ;

-- Variable

-- Norme

-- Seuils

-- Station

-- Capacité

-- Territoire

-- Distribution

-- Exigence

-- Mesure

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

