/*
-- =========================================================================== A
-- 4.3.0_SSQA_Clone_SSQA_2-SSQA_2_PUB.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Clonage des schémas SSQA et SSQA_PUB en SSQA_2 et SSQA_2_PUB.
-- =========================================================================== A
*/


/*
-- =========================================================================== A
-- SSQA_drop.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.2.0b
Statut : en vigueur
Résumé : Destruction des tables du schéma SSQA_2.
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Destruction du schéma SSQA_2 et de tout ce qu'il contient.
Pour plus d'information, voir SSQA_cre.sql
-- =========================================================================== B
*/

drop schema if exists "SSQA_2" cascade;

/*
-- =========================================================================== Z
Contributeurs :
  (CK01) Christina.Khnaisser@USherbrooke.ca,
  (LL01) Luc.Lavoie@USherbrooke.ca

Adresse, droits d’auteur et copyright :
  Groupe Metis
  Département d’informatique
  Faculté des sciences
  Université de Sherbrooke
  Sherbrooke (Québec)  J1K 2R1
  Canada
  http://info.usherbrooke.ca/llavoie/
  [CC-BY-NC-4.0 (http://creativecommons.org/licenses/by-nc/4.0)]

Tâches projetées :
  NIL

Tâches réalisées :
  2022-11-24 (LL01) : Création initiale.

Références :
  [epp] http://info.usherbrooke.ca/llavoie/enseignement/Modules/SSQA_EPP_2022.pdf
-- -----------------------------------------------------------------------------
-- SSQA_drop.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_del.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.2.0b
Statut : en vigueur
Résumé : Retrait des données des tables du schéma SSQA_2.
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Destruction des données des tables du schéma SQA.
Pour plus d'information, voir SSQA_cre.sql

Notes de mise en oeuvre
(a) aucune.
-- =========================================================================== B
*/

-- Localisation du schéma
set schema 'SSQA_2';

-- Vidage des tables
delete from Mesure ;
delete from Exigence ;
delete from Distribution ;
delete from Territoire ;
delete from Capacite ;
delete from Station ;
delete from Seuils ;
delete from Norme ;
delete from Variable ;
delete from Unite ;

/*
-- =========================================================================== Z
Contributeurs :
  (CK01) Christina.Khnaisser@USherbrooke.ca,
  (LL01) Luc.Lavoie@USherbrooke.ca

Adresse, droits d’auteur et copyright :
  Groupe Metis
  Département d’informatique
  Faculté des sciences
  Université de Sherbrooke
  Sherbrooke (Québec)  J1K 2R1
  Canada
  http://info.usherbrooke.ca/llavoie/
  [CC-BY-NC-4.0 (http://creativecommons.org/licenses/by-nc/4.0)]

Tâches projetées :
  NIL

Tâches réalisées :
  2022-11-24 (LL01) : Création initiale.

Références :
  [epp] http://info.usherbrooke.ca/llavoie/enseignement/Modules/SSQA_EPP_2022.pdf
-- -----------------------------------------------------------------------------
-- SSQA_del.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_cre.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.2.1b (d’après AirEstrie de Christina Khnaisser)
Statut : en vigueur
Résumé : Création des tables du schéma SSQA_2 (système de surveillance de la qualité de l’air).
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

-- Unité
--
-- L’unité de mesure définie en termes des unités fondamentales du SI est identifiée
-- par le symbole «sym» et porte le nom «nom».
--
-- TODO 2022-11-24 (LL01) Ajouter les attributs requis par la définition en termes des unités fondamentales du SI.
-- TODO 2022-11-24 (LL01) Contraindre plus strictement les symboles.
--
create domain Unite_Symbole
  Text
  check (length(value) between 1 and 7);
--ou de façon équivalente
--  Text
--  check ((1 <= length(value)) and (length(value) <= 7));
--ou de façon équivalente :
--  varchar(7)
--  check (length(value) <> 0);

create domain Unite_Nom
  Text
  check (length(value) between 1 and 63);
create table Unite (
  sym Unite_Symbole not null,
  nom Unite_Nom not null,
  constraint Unite_cc0 primary key (sym),
  constraint Unite_cc1 unique (nom)
  );

-- Variable
--
-- La variable associée à un phénomène mesurable par une station est identifiée
-- par le code «code», se nomme «nom»; l’unité de mesure utilisée est «unite»,
-- la valeur de référence est «valref» et la méthode d’échantillonnage est
-- décrite par «methode».
--
-- DONE 2022-11-24 (LL01) Prendre en compte la valeur de référence et la méthode d’échantillonnage.
-- TODO 2022-11-24 (LL01) Afin de mieux valider les données, les méthodes devraient être codifiées.
--
create domain Variable_Code
  Text
  check (length(value) between 1 and 15);
create domain Variable_Nom
  Text
  check (length(value) between 1 and 63);
create domain Mesure_Valeur
  Double precision;
create table Variable (
  code Variable_Code not null,
  nom Variable_nom not null,
  unite Unite_Symbole not null,
  valref Mesure_valeur not null,
  methode Text not null,
  constraint Variable_cc0 primary key (code),
  constraint Variable_cc1 unique (nom),
  constraint Variable_cr0 foreign key (unite) references Unite(sym)
  );

-- Norme
--
-- La norme identifiée par le code «code» est décrite dans le document portant le titre «titre».
--
create domain Norme_Code
  Text
  check (length(value) between 1 and 15);
create domain Norme_Titre
  Text
  check (length(value) between 1 and 255);
create table Norme (
  code Norme_Code not null,
  titre Norme_Titre not null,
  constraint Norme_cc0 primary key (code),
  constraint Norme_cc1 unique (titre)
  );

-- Seuils
--
-- L’intervalle de validité [«min»..«max»] de la variable «variable» est établi par la norme «norme».
--
-- DONE 2022-11-24 (LL01) Corriger le prédicat de la table Seuils en le définissant en terme d'intervalle.
-- TODO 2022-11-24 (LL01) Changer le nom de la table Seuils afin de refléter le concept d’intervalle de validité.
-- TODO 2022-11-24 (LL01) Vérifier que la valeur de référence de la variable est comprise dans l'intervalle de validité.
-- TODO 2022-11-24 (LL01) Vérifier que les min et max des exigences sont compris dans l'intervalle de validité.
--
create table Seuils (
  variable Variable_Code not null,
  norme Norme_code not null,
  min Mesure_Valeur not null,
  max Mesure_Valeur not null,
  constraint Seuils_cc0 primary key (variable, norme),
  constraint Seuils_cr0 foreign key (variable) references Variable(code),
  constraint Seuils_cr1 foreign key (norme) references Norme(code),
  constraint Seuils_min_max check (min <= max)
  );

-- Station
--
-- La station identifiée par «code» est située à la latitude «latitude»,
-- à la longitude «longitude» et à l’altitude «altitude»; elle se nomme «nom».
--
-- TODO 2022-11-20 (LL01) Ajout la date de mise en service, notamment à des fins de validation des temps de mesure.
-- TODO 2022-11-20 (LL01) Modéliser la mobilité de certaines stations.
--
create domain Longitude -- en degrés angulaires
  Mesure_Valeur
  check (value between -180.0 and +180.0);
create domain Latitude -- en degrés angulaires
  Mesure_Valeur
  check (value between -90.0 and +90.0);
create domain Altitude -- en mètres, relativement au «niveau de la mer»
  -- Les bornes sont issues de données expérimentales relativement à la planète Terre.
  -- Mont Everest et Fosses des Mariannes.
  Mesure_Valeur
  check (value between -12000.0 and +9000.0);
create domain Station_Code
  Text
  check (length(value) between 1 and 15);
create domain Station_Nom
  Text
  check (length(value) between 1 and 63);
create table Station (
  code Station_Code not null,
  nom Station_Nom not null,
  longitude Longitude not null,
  latitude Latitude not null,
  altitude Altitude not null,
  constraint Station_cc0 primary key (code),
  constraint Station_cc1 unique (nom)
  );

-- Capacité
--
-- La station «station» a la capacité de mesurer la variable «variable».
--
create table Capacite (
  station Station_Code not null,
  variable Variable_Code not null,
  constraint Capacite_cc0 primary key (station, variable),
  constraint Capacite_cr0 foreign key (station) references Station (code),
  constraint Capacite_cr1 foreign key (variable) references Variable (code)
  );

-- Territoire
--
-- Le territoire identifié par «code» est connu sous le nom «nom».
--
-- TODO 2022-11-24 (LL01) Ajouter la description de l'organisation hiérarchique des territoires.
--
create domain Territoire_Code
  Text
  check (length(value) between 1 and 15);
create domain Territoire_Nom
  Text
  check (length(value) between 1 and 63);
create table Territoire (
  code Territoire_Code not null,
  nom Territoire_Nom not null,
  constraint Territoire_cc0 primary key (code),
  constraint Territoire_cc1 unique (nom)
  );

-- Distribution
--
-- La station «station» se rapporte au territoire «territoire».
--
create table Distribution (
  territoire Territoire_Code not null,
  station Station_Code not null,
  constraint Distribution_cc0 primary key (territoire, station),
  constraint Distribution_cr1 foreign key (territoire) references Territoire (code),
  constraint Distribution_cr0 foreign key (station) references Station (code)
  );

-- Mesure
--
-- La valeur «valeur» de la mesure de la variable «variable» a été prise par la
-- station «station», au temps «moment»; sa validité est «valide».
--
-- QUESTION 2022-11-24 (LL01) La validité est-elle vraiment pertinente ? Si oui, sa représentation est-elle adéquate ?
--
create domain Estampille
  TIMESTAMP
  check (value >= '1970-01-01T00:00:00.000000');
create table Mesure (
  station Station_Code not null,
  moment Estampille not null,
  variable Variable_Code not null,
  valeur Mesure_Valeur not null,
  valide Boolean not null,
  constraint Mesure_cc0 primary key (station, moment, variable),
  constraint Mesure_cr0 foreign key (station, variable) references Capacite
  );

--
-- Le modèle des Seuils est insuffisant en regard de la NCQAA, puisque les seuils
-- doivent être appliqués sur des périodes variables.
-- Bien que le «min» soit toujours égal à 0 dans les exigences actuelles de la NCQAA,
-- cela pourrait changer en regard de futures variables.
-- Le modèle de Seuils est cependant approprié pour vérifier les seuils de validité
-- des mesures elles-mêmes; en conséquence, il sera conservé également.
--
-- DONE 2022-11-24 (LL01) Les exigences normatives sont différentes des intervalles de validité.
--  * Ajouter une relation décrivant les exigences.
--

-- Exigence
--
-- L’exigence identifiée par le code «code» au sein de la norme «norme» est applicable à la variable «variable».
-- L’exigence est respectée si toutes les mesures de la variable «variable» sont
-- comprises dans l’intervalle de validité [«min»..«max»] durant toute période
-- de «periode_valeur» «periode_unite».
--
-- TODO 2022-11-24 (LL01) Valider que «periode_unite» est une unité de temps.
--  * Ne peut être réalisé que si la définition des unités (en terme des unités SI)
--    est ajoutée à la table Unite.
--
create domain Exigence_Code
  Text
  check (length(value) between 1 and 15);
create table Exigence (
  norme Norme_code not null,
  code Exigence_Code not null,
  variable Variable_Code not null,
  periode_valeur Mesure_Valeur not null,
  periode_unite Unite_Symbole not null,
  min Mesure_Valeur not null,
  max Mesure_Valeur not null,
  constraint Exigence_cc0 primary key (norme, code),
  constraint Exigence_cc1 unique (norme, variable, periode_unite, periode_valeur),
  constraint Exigence_cr0 foreign key (variable) references Variable (code),
  constraint Exigence_cr1 foreign key (norme) references Norme (code),
  constraint Exigence_cr2 foreign key (periode_unite) references Unite (sym),
  constraint Exigence_min_max check (min <= max)
  );

/*
-- =========================================================================== Z
Contributeurs :
  (CK01) Christina.Khnaisser@USherbrooke.ca,
  (LL01) Luc.Lavoie@USherbrooke.ca

Adresse, droits d’auteur et copyright :
  Groupe Metis
  Département d’informatique
  Faculté des sciences
  Université de Sherbrooke
  Sherbrooke (Québec)  J1K 2R1
  Canada
  http://info.usherbrooke.ca/llavoie/
  [CC-BY-NC-4.0 (http://creativecommons.org/licenses/by-nc/4.0)]

Tâches projetées :
  NIL

Tâches réalisées :
  2022-11-24 (LL01) : Ajouter de la table Exigence.
  2022-11-20 (LL01) : AirEstrie -> SSQA_2.
  2019-12-17 (CK01) : Création initiale de AirEstrie (version minimaliste).

Références (consultées le 2022-11-24) :
  [epp] https://usherbrooke.sharepoint.com/.../Cours-IFT187-01-H23/General/SSQA_EPP_v2023-1.pdf
  [alth] https://fr.wikipedia.org/wiki/Everest
  [altb] https://fr.wikipedia.org/wiki/Fosse_des_Mariannes

-- -----------------------------------------------------------------------------
-- SSQA_cre.sql
-- =========================================================================== Z
*/
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
Résumé : Insertion des données de test pour les tables du schéma SSQA_2.
-- =========================================================================== A
*/

/*
Insertion des données valides à des fins de tests unitaires pour les tables
du schéma SSQA_2 (système de surveillance de la qualité de l'air). Les données
ne sont pas nécessairement conforme à la réalité, bien que représentatives.
*/

-- Localisation du schéma
set schema 'SSQA_2';

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
  2022-11-24 (LL01) : Adaptation au problème SSQA_2.
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
Résumé : Tentatives d’insertion des données invalides pour les tables du schéma SSQA_2.
-- =========================================================================== A
*/

/*
Tentative d’insertion des données invalides à des fins de tests unitaires pour les tables
du schéma SSQA_2 (système de surveillance de la qualité de l’air). Toutes les insertions
doivent entraîner une échec.

On suppose que les données valides du fichier SSQA_ins-val.sql ont été insérées
au préalable.

Un exemple est donné pour la table Unité.
Saurez-vous faire les tentatives d'insertion pour les autres tables ?
*/

-- Localisation du schéma
set schema 'SSQA_2';

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
-- conflit de clé primaire (idVariable)
  insert into Variable (idVariable, nom, idUnite) values
    (1, 'température', 1) ;
-- conflit de clé secondaire (nom)
  insert into Variable (idVariable, nom, idUnite) values
    (2, 'température', 2) ;
-- conflit de clé secondaire (idUnite)
  insert into Variable (idVariable, nom, idUnite) values
    (3, 'humidité', 1) ;

-- Norme

-- Seuils

-- conflit min max
  insert into Seuils (idNorme, idVariable, min, max) values
    (1, 1, 10, 0) ;
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
  2022-11-24 (LL01) : Adaptation au problème SSQA_2.
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

/*
-- =========================================================================== A
-- SSQA_R01.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Modélisation adéquate des unités de mesure en termes des unités fondamentales du SI.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

-- Vide la table car les anciennes données ne sont plus valides
drop table if exists Unite cascade;

-- Unite
--
-- L'unité est modélisée par un symbole, un nom. Sa définition est complétée par une valeur de multiplication et une valeur d'addition par rapport à l'unité fondamentale associée.
-- Si l'unité est fondamentale, alors la valeur de multiplication est 1 et la valeur d'addition est 0.
--

create domain Unite_coef as decimal;

create table Unite (
    sym Unite_Symbole not null,
    nom Unite_Nom not null unique,
    mult Unite_coef not null,
    add Unite_coef not null,
    constraint Unite_cc0 primary key (sym),
    constraint Unite_mult_positif check (mult > 0)
);

-- Insertion dans Unite due à la suppression de la table.
insert into Unite(sym, nom, mult, add) values
('s', 'seconde', 1, 0);
insert into Unite(sym, nom, mult, add) values
('m', 'mètre', 1, 0);
insert into Unite(sym, nom, mult, add) values
('kg', 'kilogramme', 1, 0);
insert into Unite(sym, nom, mult, add) values
('mol', 'mole', 1, 0);
insert into Unite(sym, nom, mult, add) values
('K', 'kelvin', 1, 0);
insert into Unite(sym, nom, mult, add) values
('A', 'ampere', 1, 0);
insert into Unite(sym, nom, mult, add) values
('cd', 'candela', 1, 0);
insert into Unite(sym, nom, mult, add) values
('bit', 'bit', 1, 0);
insert into Unite(sym, nom, mult, add) values
('h', 'heure', 3600, 0);
insert into Unite(sym, nom, mult, add) values
('a', 'année', 3600*24*365, 0);
insert into Unite(sym, nom, mult, add) values
('µg/m3', 'microgramme par mètre cube', 1/1000000000.0, 0);
insert into Unite(sym, nom, mult, add) values
('ppb', 'parties par milliard', 1/1000000000.0, 0);
insert into Unite(sym, nom, mult, add) values
('ppm', 'parties par million', 1/1000000.0, 0);

-- Unite_fond
--
-- L'unité fondamentale est modélisée par un symbole et un nom.
--
create table Unite_fond (
    symbole Unite_Symbole not null,
    nom Unite_Nom not null unique,
    constraint Unite_fond_cc0 primary key (symbole)
);

-- Composition_unite
--
-- La composition d'une unité composite en termes d'unités fondamentales est modélisée par un symbole d'unité composite, un symbole d'unité fondamentale, et un exposant.
--

create domain Composition_unite_exposant as integer;

create table Composition_unite (
    symbole_unite_composite Unite_Symbole not null,
    symbole_unite_fondamentale Unite_Symbole not null,
    exposant Composition_unite_exposant not null,
    constraint Composition_unite_cc0 primary key (symbole_unite_composite, symbole_unite_fondamentale),
    constraint Composition_unite_cr0 foreign key (symbole_unite_composite) references Unite (sym),
    constraint Composition_unite_cr1 foreign key (symbole_unite_fondamentale) references Unite_fond (symbole)
);

-- -- Création des références vers la nouvelle table Unite
alter table Variable add constraint Variable_cr0 foreign key (unite) references Unite (sym);
alter table Exigence add constraint Exigence_cr2 foreign key (periode_unite) references Unite (sym);


/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Modélisation adéquate des unités de mesure en termes des unités fondamentales du SI.
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Définition d’une fonction permettant d’ajouter de nouvelles unités composites.
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Permettre la définition d’unités fondamentales supplémentaires (par exemple, le bit).

-- -----------------------------------------------------------------------------
-- SSQA_R01.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R01_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Insertion des valeurs de référence pour les unités de mesure.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

insert into Unite_fond(symbole, nom) values
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


/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion des valeurs de référence pour les unités de mesure.

-- -----------------------------------------------------------------------------
-- SSQA_R01_ins-val.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R01_ins-inv.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Tentatives erronées d'insertion de valeurs dans la table Unite.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

/*
Tentative d’insertion des données invalides à des fins de tests unitaires pour les tables
du schéma SSQA_2 (système de surveillance de la qualité de l’air). Toutes les insertions
doivent entraîner une échec.

On suppose que les données valides du fichier SSQA_ins-val.sql correspondant ont été insérées
au préalable.
*/

-- Unite
-- symbole trop long
insert into Unite (sym, nom, mult, add) values
    ('symbole vraiment trop long pour être pratique', 'peu importe', 1, 0);
-- symbole null
insert into Unite (sym, nom, mult, add) values
    (null, 'peu importe', 1, 0);
-- nom null
insert into Unite (sym, nom, mult, add) values
    ('sym', null, 1, 0);
-- mult null
insert into Unite (sym, nom, mult, add) values
    ('sym', 'peu importe', null, 0);
-- add null
insert into Unite (sym, nom, mult, add) values
    ('sym', 'peu importe', 1, null);
-- mult négatif
insert into Unite (sym, nom, mult, add) values
    ('sym', 'peu importe', -1, 0);
-- conflit de clé primaire
insert into Unite (sym, nom, mult, add) values
    ('s', 'peu importe', 1, 0);


/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion de valeurs dans les tables Unite et Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05_ins-val.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R02.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Contraindre plus strictement les symboles.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

-- Selon moi, rien à mettre ici, les seules règles que j'ai trouvé sont des règles d'utilisation plutôt que de création
-- en plus, il est possible que l'uutilisateur ait à créer son propre symbole d'unité,
-- par exemple kg/m3, donc je ne vois pas comment on pourrait mettre des règles ici

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Etude du problème. Solution réalisée par la R01.


-- -----------------------------------------------------------------------------
-- SSQA_R01.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R02_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Nil.
-- =========================================================================== A
*/



/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  Nil.

-- -----------------------------------------------------------------------------
-- SSQA_R01.sql
-- =========================================================================== Z
*//*
-- =========================================================================== A
-- SSQA_R02_ins-inv.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Nil.
-- =========================================================================== A
*/



/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion de valeurs dans les tables Unite et Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05_ins-val.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R03.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Changer le nom de la table Seuils pour « Validation ».
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

-- Renommage de la table Seuils pour Validation.
alter table Seuils rename to Validation;

-- Renommage des contraintes.
alter table Validation drop constraint Seuils_cc0;
alter table Validation drop constraint Seuils_cr0;
alter table Validation drop constraint Seuils_cr1;
alter table Validation drop constraint Seuils_min_max;

alter table Validation add constraint Validation_cc0 primary key (variable, norme);
alter table Validation add constraint Validation_cr0 foreign key (variable) references Variable(code);
alter table Validation add constraint Validation_cr1 foreign key (norme) references Norme(code);
alter table Validation add constraint Validation_min_max check (min <= max);

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Changer le nom de la table Seuils pour « Validation ».
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Faire percoler les conséquences de ce changement.

-- -----------------------------------------------------------------------------
-- SSQA_R03.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R03_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Insertion des valeurs dans la table Validation.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

insert into Validation(variable, norme, min, max) values ('CO', 'NCQAA_2025', 0, 50);

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion des valeurs dans la table Validation.

-- -----------------------------------------------------------------------------
-- SSQA_R03.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R03_ins-inv.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Tentatives erronées d'insertion de valeurs dans la table Seuils.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

/*
Tentative d’insertion des données invalides à des fins de tests unitaires pour les tables
du schéma SSQA_2 (système de surveillance de la qualité de l’air). Toutes les insertions
doivent entraîner une échec.

On suppose que les données valides du fichier SSQA_ins-val.sql correspondant ont été insérées
au préalable.
*/

insert into Seuils(variable, norme, min, max) values ('CO2', 'PM10', 0, 50);


/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion de valeurs dans les tables Unite et Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05_ins-val.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R04.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Différentes valeurs et intervalles de validité sont associés à la définition et l’exploitation des variables. Il est nécessaire de s’assurer que leur cohérence.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

-- Ajout contrainte pour la table variable
create function verifier_validation() returns trigger as $$
begin
    if (not exists (select 1 from variable where variable.code = new.variable and variable.valref between new.min and new.max)) then
        raise exception 'L''intervalle de validation est invalide';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger verifier_validation_trigger before insert or update on validation for each row execute function verifier_validation();

-- Ajout contrainte pour la table exigence
create function valider_exigence() returns trigger as $$
begin
    if (exists (select 1 from validation v where v.variable = new.variable and v.norme = new.norme and new.min not between v.min and v.max)) then
        raise exception 'La valeur minimale de l''exigence est invalide';
    end if;
    if (exists (select 1 from validation v where v.variable = new.variable and v.norme = new.norme and new.max not between v.min and v.max)) then
        raise exception 'La valeur maximale de l''exigence est invalide';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger valider_exigence_trigger before insert or update on exigence for each row execute function valider_exigence();

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Vérifier que la valeur de référence de la variable est comprise dans l’intervalle de validité.
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Vérifier que les min et max des exigences sont compris dans l’intervalle de validité.

-- -----------------------------------------------------------------------------
-- SSQA_R04.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R04_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Insertion des valeurs dans les tables Validation, Variable et Norme.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

insert into Unite(sym, nom, mult, add)
values ('test', 'Test', 1, 0);

insert into Variable(nom, unite, valref, methode, code) values ('test', 'test', 50, 'Moyenne horaire', 'test');

insert into Norme(titre, code) values ('test', 'test');

insert into Validation(min, max, variable, norme) values (25, 75, 'test', 'test');

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion des valeurs dans la table Validation.

-- -----------------------------------------------------------------------------
-- SSQA_R04_ins-val.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R04_ins-inv.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Tentatives erronées d'insertion de valeurs dans les tables Validation et Exigence.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

/*
Tentative d’insertion des données invalides à des fins de tests unitaires pour les tables
du schéma SSQA_2 (système de surveillance de la qualité de l’air). Toutes les insertions
doivent entraîner une échec.

On suppose que les données valides du fichier SSQA_ins-val.sql correspondant ont été insérées
au préalable.
*/

-- valref invalide
insert into Validation (min, max, variable, norme) values (0, 45, 'test', 'test');

-- min invalide
insert into Exigence (variable, periode_valeur, periode_unite, min, max, norme, code) values ('test', 1, 's', 0, 50, 'test', 'test');

-- max invalide
insert into Exigence (variable, periode_valeur, periode_unite, min, max, norme, code) values ('test', 1, 's', 50, 10000, 'test', 'test2');


/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion de valeurs dans les tables Unite et Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05_ins-val.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R05.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Codification des méthodes d'échantillonnage.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

-- Creation de l'enum methode_enum.
create type methode_enum as enum('Moyenne horaire', 'Moyenne des 3 dernières heures', 'Maximum sur quatre minutes');

-- Suppression des variables qui ont une methode qui n'est pas dans l'enum.
delete from Variable where methode not in ('Moyenne horaire', 'Moyenne des 3 dernières heures', 'Maximum sur quatre minutes');

-- Modification du type de la colonne methode de la table Variable, par l'enum précédente.
alter table Variable
alter column methode TYPE methode_enum USING methode::methode_enum;


/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Création d'une enum pour la colonne methode de la table Variable.
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Modification du type de la colonne methode de la table Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R05_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Insertion de valeurs dans les tables Unite et Variable.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

insert into Unite (nom, sym, mult, add) values ('Kelvin', 'Ktest', 1, 0);

insert into Variable (code, nom, unite, valref, methode) values ('T', 'Température', 'Ktest', 273.15, 'Moyenne horaire');

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion de valeurs dans les tables Unite et Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05_ins-val.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R05_ins-inv.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Tentatives erronées d'insertion de valeurs dans la table Variable.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

/*
Tentative d’insertion des données invalides à des fins de tests unitaires pour les tables
du schéma SSQA_2 (système de surveillance de la qualité de l’air). Toutes les insertions
doivent entraîner une échec.

On suppose que les données valides du fichier SSQA_ins-val.sql correspondant ont été insérées
au préalable.
*/

-- type methode invalide
insert into Variable (code, nom, unite, valref, methode) values ('T2', 'Température2', 'Ktest', 273.15, 'test');



/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion de valeurs dans les tables Unite et Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05_ins-val.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R06.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Ajout la date de mise en service des stations, notamment à des fins de validation des temps de mesure.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

-- Ajout attribut debut_service et fin_service dans la table station
alter table Station add column debut_service Estampille;
alter table Station add column fin_service Estampille;

-- Ajout contrainte de debut_service et fin_service
alter table Station add constraint Station_date_service check (debut_service is null or fin_service is null or fin_service >= debut_service);

create domain Hors_service_code
as integer not null;

create domain Description_hors_service
as varchar(255) not null;

-- Nature_Hors_service
--
-- La nature d'un hors service est modélisée par un code et une description.
--
create table Nature_Hors_service (
    code Hors_service_code not null,
    description Description_hors_service not null,
    constraint Nature_hors_service_cc0 primary key (code)
);

-- Hors_service
--
-- Un hors service est modélisé par une station, une date de début, une date de fin et une nature.
create table Hors_service (
    station Station_Code not null,
    debut Estampille not null,
    fin Estampille not null,
    nature Hors_service_code not null,

    constraint Hors_service_cc0 primary key (station, debut, nature),
    constraint Hors_service_cr0 foreign key (station) references Station(code),
    constraint Hors_service_cr1 foreign key (nature) references Nature_Hors_service(code),
    constraint Hors_service_dates_valides check (fin >= debut)
);

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Ajouter les attributs de mise en exploitation et de fin d’exploitation de la station.
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Création des domaines Hors_service_code et Description_hors_service.

-- -----------------------------------------------------------------------------
-- SSQA_R01.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R06_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Insertion de valeurs dans les tables Station, Nature_hors_service et Hors_service.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

-- Insertion de valeurs dans la table Nature_hors_service
insert into Nature_hors_service (code, description) values
(-1, 'Inconnu'),
(1, 'Maintenance'),
(2, 'Calibration'),
(3, 'Réparation'),
(4, 'Autre');

-- Insertion de valeurs dans la table Hors_service
insert into Hors_service (station, debut, fin, nature) values
('000001', '2021-01-01', '2021-01-02', 1),
('000002', '2021-01-01', '2021-01-02', 2),
('000003', '2021-01-01', '2021-01-02', 3);

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion de valeurs dans les tables Unite et Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05_ins-val.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R06_ins-inv.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Tentatives erronées d'insertion de valeurs dans les tables Station, Nature_hors_service et Hors_service.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

/*
Tentative d’insertion des données invalides à des fins de tests unitaires pour les tables
du schéma SSQA_2 (système de surveillance de la qualité de l’air). Toutes les insertions
doivent entraîner une échec.

On suppose que les données valides du fichier SSQA_ins-val.sql correspondant ont été insérées
au préalable.
*/

-- code hors-service null
insert into Nature_Hors_service (code, description) values
(null, 'Maintenance');

-- description hors-service null
insert into Nature_Hors_service (code, description) values
(1, null);

-- code hors-service invalide
insert into Nature_Hors_service (code, description) values
('test', 'peu importe');

-- description hors-service invalide
insert into Nature_Hors_service (code, description) values
(1, 'Une description beaucoup trop longue pour être valideeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');

-- station de référence inexistante
insert into Hors_service (station, debut, fin, nature) values
('000004', '2021-01-01', '2021-01-02', 1);

-- date de fin de hors-service antérieure à la date de début de hors-service
insert into Hors_service (station, debut, fin, nature) values
('000001', '2021-01-02', '2021-01-01', 1);

-- nature de hors-service inexistante
insert into Hors_service (station, debut, fin, nature) values
('000001', '2021-01-01', '2021-01-02', 5);

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion de valeurs dans les tables Unite et Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05_ins-val.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R07.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Modification du schéma afin de pouvoir consigner l’évolution des coordonnées des stations.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

-- Création attribut mobilité
create domain Station_mobilite as boolean;

alter table Station add column mobilite Station_mobilite;

-- Position
--
-- La position d'une station est modélisée par un code de station, une latitude, une longitude, une altitude, une date de début et une date de fin.
--
create table Position (
    station Station_Code not null,
    latitude Latitude not null,
    longitude Longitude not null,
    altitude Altitude not null,
    debut Estampille not null,
    fin Estampille,
    constraint Position_cc0 primary key (station, debut),
    constraint Position_cr0 foreign key (station) references Station(code),
    constraint Position_dates_valides check (fin > debut)
);

comment on column Position.debut is 'Les dates de début n''ont pas été répertoriées avant la date de création de la table et sont donc toutes égales à cette date.';

-- Suppression des attributs de la table Station
alter table Station drop column latitude;
alter table Station drop column longitude;
alter table Station drop column altitude;

create domain Immatriculation_code as varchar(50);

create table Immatriculation (
    station Station_Code not null,
    immatriculation Immatriculation_code not null,
    constraint immatriculation_cc0 primary key (station),
    constraint immatriculation_cr0 foreign key (station) references Station(code)
);

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Ajout de l'attribut mobilité à la table Station.
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Ajout des tables Position et Immatriculation.
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Ajout des contraintes de Position et Immatriculation.

-- -----------------------------------------------------------------------------
-- SSQA_R07.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R08.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Vérification de l'unité de la période.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

-- Vérification à l'ajout dans la table Exigence que periode_unite est bien une unité de temps
-- On vérifie que l'unite referencée dans periode_unite n'a pas de correspondance dans la table composition_unite dont l'unite fondamentale n'est pas 's'
create function verifier_periode_unite() returns trigger as $$
begin
    if (exists (select from composition_unite where composition_unite.symbole_unite_composite = new.periode_unite and composition_unite.symbole_unite_fondamentale != 's')) then
        raise exception 'L''unité de la période n''est pas une unité de temps';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger verifier_periode_unite_trigger before insert or update on exigence for each row execute function verifier_periode_unite();

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Vérifier que l'unité de la période est une unité de temps.

-- -----------------------------------------------------------------------------
-- SSQA_R08.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R08_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Insertion de valeurs dans les tables Unite, Composition_Unite et Exigence.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

-- Création de deux unités composite de temps
insert into Unite (sym, nom, mult, add) values
  ('s2', 'seconde carrée', 1, 0),
  ('j', 'jour', 3600*24, 0);

insert into Composition_Unite (symbole_unite_composite, symbole_unite_fondamentale, exposant) values
  ('s2', 's', 2),
  ('j', 's', 1);

-- Insertion de deux exigences
insert into Exigence (norme, code, variable, periode_valeur, periode_unite, min, max) values
  ('NQMAA_2014', 'E1', 'CO', 1, 's2', 0, 100),
  ('NQMAA_2014', 'E2', 'CO', 1, 'j', 0, 100);


/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion de valeurs dans les tables Unite et Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05_ins-val.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R08_ins-inv.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Tentatives erronées d'insertion de valeurs dans les tables Unite, Composition_Unite et Exigence.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

/*
Tentative d’insertion des données invalides à des fins de tests unitaires pour les tables
du schéma SSQA_2 (système de surveillance de la qualité de l’air). Toutes les insertions
doivent entraîner une échec.

On suppose que les données valides du fichier SSQA_ins-val.sql correspondant ont été insérées
au préalable.
*/

-- l'unité de la periode n'est pas une unité de temps
insert into Exigence (norme, code, variable, periode_valeur, periode_unite, min, max) values
  ('NQMAA_2014', 'E3', 'CO', 1, 'µg/m3', 0, 100);


/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion de valeurs dans les tables Unite et Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05_ins-val.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R09.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Rendre le nom de la station facultatif, dans la mesure où la station n’est pas mobile.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

create table Nom_station (
    code Station_Code not null,
    nom Station_Nom not null,
    constraint Nom_station_cc0 primary key (code),
    constraint Nom_station_cr0 foreign key (code) references Station(code)
);

-- Suppression de la colonne nom de la table station.
alter table Station
drop column nom;

-- Fonction d'insertion d'une station.
-- Si la station est mobile, le nom est obligatoire et est inséré dans la table nom_station.
-- Si la station n'est pas mobile, le nom est facultatif et n'est pas inséré dans la table nom_station.
create function inserer_station(code Station_Code, nom Station_Nom, debut_service Estampille, fin_service Estampille, mobilite boolean) returns void as $$
begin
    if mobilite then
        insert into station(code, debut_service, fin_service, mobilite)
        values (code, debut_service, fin_service, mobilite);
        insert into nom_station(code, nom)
        values (code, nom);
    else
        insert into station(code, debut_service, fin_service, mobilite)
        values (code, debut_service, fin_service, mobilite);
    end if;
end;
$$ language plpgsql;

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Nom de station facultatif.

-- -----------------------------------------------------------------------------
-- SSQA_R09.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R09_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Insertion de valeurs dans les tables Station et Nom_station.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

-- Insertion d'une station mobile (nom obligatoire).
select inserer_station('0000006', 'Station 6', '2023-01-01 00:00:00', '2023-12-31 23:59:59', true);

-- Insertion d'une station non mobile (nom facultatif).
select inserer_station('0000007', null, '2023-01-01 00:00:00', '2023-12-31 23:59:59', false);

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion de valeurs dans les tables Unite et Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05_ins-val.sql
-- =========================================================================== Z
*/

/*
-- =========================================================================== A
-- SSQA_R10.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Rendre la valeur d’une mesure facultative, en cas d’absence s’assurer d’en conserver la cause.
-- =========================================================================== A
*/

set schema 'SSQA_2';

create domain Code_erreur_mesure as integer;
create domain Description_erreur_mesure as varchar(255);

create table Erreur_mesure_code (
    code Code_erreur_mesure not null,
    nom Description_erreur_mesure not null,
    constraint Erreur_mesure_code_cc0 primary key (code)
);

create table Erreur_mesure (
    station Station_Code not null,
    moment Estampille not null,
    variable Variable_code not null,
    erreur_mesure_code Code_erreur_mesure not null,
    constraint Erreur_mesure_cc0 primary key (station, moment, variable, erreur_mesure_code),
    constraint Erreur_mesure_cr0 foreign key (station, moment, variable) references Mesure(station, moment, variable),
    constraint Erreur_mesure_cr1 foreign key (erreur_mesure_code) references Erreur_mesure_code(code)
);

-- Transfert des erreurs de mesure de la table Mesure vers la table Erreur_mesure
insert into Erreur_mesure_code (code, nom) values (-1, 'Inconnu');
insert into Erreur_mesure (station, moment, variable, erreur_mesure_code)
    select station, moment, variable, -1 from Mesure where valide = false;

-- Suppression de la colonne 'valide' de la table Mesure
alter table Mesure drop column valide;

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Rendre la valeur d’une mesure facultative, en cas d’absence s’assurer d’en conserver la cause.

-- -----------------------------------------------------------------------------
-- SSQA_R10.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R10_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Insertion de valeurs dans les tables Erreur_mesure_code et Erreur_mesure et Mesure.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

-- Insertion de valeurs dans la table Erreur_mesure_code.
insert into Erreur_mesure_code (code, nom) values
  (1, 'Capteur défectueux'),
  (2, 'Mesure hors échelle');

-- Insertion de valeurs dans la table Erreur_mesure.
insert into Erreur_mesure (station, moment, variable, erreur_mesure_code) values
  ('10000', '2021-01-01 00:00:01', 'CO', 1),
  ('10000', '2021-01-01 00:00:02', 'CO', 2);

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion de valeurs dans les tables Unite et Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05_ins-val.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- SSQA_R10_ins-inv.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Tentatives erronées d'insertion de valeurs dans les tables Erreur_mesure_code et Erreur_mesure et Mesure.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

/*
Tentative d’insertion des données invalides à des fins de tests unitaires pour les tables
du schéma SSQA_2 (système de surveillance de la qualité de l’air). Toutes les insertions
doivent entraîner une échec.

On suppose que les données valides du fichier SSQA_ins-val.sql correspondant ont été insérées
au préalable.
*/

-- code null
insert into Erreur_mesure_code (code, nom) values
  (null, 'Capteur défectueux');

-- code non-unique
insert into Erreur_mesure_code (code, nom) values
  (1, 'Capteur défectueux');

-- nom null
insert into Erreur_mesure_code (code, nom) values
  (3, null);

-- code mauvais type
insert into Erreur_mesure_code (code, nom) values
  ('test', 'osef');

-- nom trop long
insert into Erreur_mesure_code (code, nom) values
  (3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec auctor, nisl nec tincidunt ultricies, nunc nisl aliquam nunc, sit amet aliquam nisl nunc vitae nisl. Donec auctor, nisl nec tincidunt ultricies, nunc nisl aliquam nunc, sit amet aliquam nisl nunc vitae nisl. Donec auctor, nisl nec tincidunt ultricies, nunc nisl aliquam nunc, sit amet aliquam nisl nunc vitae nisl. Donec auctor, nisl nec tincidunt ultricies, nunc nisl aliquam nunc, sit amet aliquam nisl nunc vitae nisl. Donec auctor, nisl nec tincidunt ultricies, nunc nisl aliquam nunc, sit amet aliquam nisl nunc vitae nisl. Donec auctor, nisl nec tincidunt ultricies, nunc nisl aliquam nunc, sit amet aliquam nisl nunc vitae nisl.');

-- code non-existant
insert into Erreur_mesure (station, moment, variable, erreur_mesure_code) values
  ('10000', '2021-01-01 00:00:01', 'CO', 3);

-- mesure non-existante
insert into Erreur_mesure (station, moment, variable, erreur_mesure_code) values
  ('10000', '2021-01-01 00:00:03', 'CO', 1);

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-01 (capl1101, sart0701, thea1804, turr3004) : Insertion de valeurs dans les tables Unite et Variable.

-- -----------------------------------------------------------------------------
-- SSQA_R05_ins-val.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- 3.0.0_SSQA_Foreign-key-on-cascade.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Modification des contraintes de clés étrangères pour les mettre en cascade.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';


-- Capacite
begin transaction;
set transaction read write;
    alter table "SSQA_2".capacite
    drop constraint Capacite_cr0;

    alter table "SSQA_2".capacite
    add constraint Capacite_cr0 foreign key (station) references Station (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA_2".capacite
    drop constraint Capacite_cr1;

    alter table "SSQA_2".capacite
    add constraint Capacite_cr1 foreign key (variable) references Variable (code) on delete cascade on update cascade;
commit transaction;


-- Distribution
begin transaction;
set transaction read write;
    alter table "SSQA_2".distribution
    drop constraint Distribution_cr0;

    alter table "SSQA_2".distribution
    add constraint Distribution_cr0 foreign key (station) references Station (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA_2".distribution
    drop constraint Distribution_cr1;

    alter table "SSQA_2".distribution
    add constraint Distribution_cr1 foreign key (territoire) references Territoire (code) on delete cascade on update cascade;
commit transaction;


-- Mesure
begin transaction;
set transaction read write;
    alter table "SSQA_2".mesure
    drop constraint Mesure_cr0;

    alter table "SSQA_2".mesure
    add constraint Mesure_cr0 foreign key (station, variable) references Capacite on delete cascade on update cascade;
commit transaction;


-- Composition_unite
begin transaction;
set transaction read write;
    alter table "SSQA_2".composition_unite
    drop constraint Composition_unite_cr0;

    alter table "SSQA_2".composition_unite
    add constraint Composition_unite_cr0 foreign key (symbole_unite_composite) references Unite (sym) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA_2".composition_unite
    drop constraint Composition_unite_cr1;

    alter table "SSQA_2".composition_unite
    add constraint Composition_unite_cr1 foreign key (symbole_unite_fondamentale) references Unite_fond (symbole) on delete cascade on update cascade;
commit transaction;


-- Variable
begin transaction;
set transaction read write;
    alter table "SSQA_2".variable
    drop constraint Variable_cr0;

    alter table "SSQA_2".variable
    add constraint Variable_cr0 foreign key (unite) references Unite (sym) on delete cascade on update cascade;
commit transaction;


-- Exigence
begin transaction;
set transaction read write;
    alter table "SSQA_2".exigence
    drop constraint Exigence_cr0;

    alter table "SSQA_2".exigence
    add constraint Exigence_cr0 foreign key (variable) references Variable (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA_2".exigence
    drop constraint Exigence_cr1;

    alter table "SSQA_2".exigence
    add constraint Exigence_cr1 foreign key (norme) references Norme (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA_2".exigence
    drop constraint Exigence_cr2;

    alter table "SSQA_2".exigence
    add constraint Exigence_cr2 foreign key (periode_unite) references Unite (sym) on delete cascade on update cascade;
commit transaction;


-- Validation
begin transaction;
set transaction read write;
    alter table "SSQA_2".validation
    drop constraint Validation_cr0;

    alter table "SSQA_2".validation
    add constraint Validation_cr0 foreign key (variable) references Variable (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA_2".validation
    drop constraint Validation_cr1;

    alter table "SSQA_2".validation
    add constraint Validation_cr1 foreign key (norme) references Norme (code) on delete cascade on update cascade;
commit transaction;


-- Hors_service
begin transaction;
set transaction read write;
    alter table "SSQA_2".hors_service
    drop constraint Hors_service_cr0;

    alter table "SSQA_2".hors_service
    add constraint Hors_service_cr0 foreign key (station) references Station (code) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA_2".hors_service
    drop constraint Hors_service_cr1;

    alter table "SSQA_2".hors_service
    add constraint Hors_service_cr1 foreign key (nature) references Nature_Hors_service (code) on delete cascade on update cascade;
commit transaction;


-- Position
begin transaction;
set transaction read write;
    alter table "SSQA_2".position
    drop constraint Position_cr0;

    alter table "SSQA_2".position
    add constraint Position_cr0 foreign key (station) references Station (code) on delete cascade on update cascade;
commit transaction;


-- Immatriculation
begin transaction;
set transaction read write;
    alter table "SSQA_2".immatriculation
    drop constraint immatriculation_cr0;

    alter table "SSQA_2".immatriculation
    add constraint immatriculation_cr0 foreign key (station) references Station (code) on delete cascade on update cascade;
commit transaction;


-- Nom_station
begin transaction;
set transaction read write;
    alter table "SSQA_2".nom_station
    drop constraint Nom_station_cr0;

    alter table "SSQA_2".nom_station
    add constraint Nom_station_cr0 foreign key (code) references Station (code) on delete cascade on update cascade;
commit transaction;


-- Erreur_mesure
begin transaction;
set transaction read write;
    alter table "SSQA_2".erreur_mesure
    drop constraint Erreur_mesure_cr0;

    alter table "SSQA_2".erreur_mesure
    add constraint Erreur_mesure_cr0 foreign key (station, moment, variable) references Mesure (station, moment, variable) on delete cascade on update cascade;
commit transaction;

begin transaction;
set transaction read write;
    alter table "SSQA_2".erreur_mesure
    drop constraint Erreur_mesure_cr1;

    alter table "SSQA_2".erreur_mesure
    add constraint Erreur_mesure_cr1 foreign key (erreur_mesure_code) references Erreur_mesure_code (code) on delete cascade on update cascade;
commit transaction;

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Modification des contraintes de clés étrangères pour les mettre en cascade.

-- -----------------------------------------------------------------------------
-- 3.0.0_SSQA_Foreign-key-on-cascade.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- 3.1.0_SSQA_EMIR_Territoire.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Ajout des procédures et fonctions EMIR pour les territoires.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2_PUB";
set schema 'SSQA_2_PUB';

-- territoire_eva_gen
--
-- Fonction d'évaluation de tous les territoires.
--
-- @return : tous les territoires.
--
create or replace function territoire_eva_gen()
    returns setof "SSQA_2".territoire
    language sql as
    $$
        select *
        from "SSQA_2".territoire;
    $$;

-- territoire_eva_one
--
-- Fonction d'évaluation d'un territoire.
--
-- @param i_code_territoire : code du territoire
--
-- @return : le territoire correspondant au code en paramètre.
--
create or replace function territoire_eva_unique(
        i_code_territoire "SSQA_2".territoire_code
    )
    returns "SSQA_2".territoire
    language sql as
    $$
        select *
        from "SSQA_2".territoire
        where code = i_code_territoire;
    $$;

-- territoire_mod_gen_sst_exs
--
-- Procédure de modification d'un territoire.
--
-- @param i_code_territoire : code du territoire (unique)
-- @param i_nouveau_code_territoire : nouveau code du territoire (optionnel)
-- @param i_nouveau_nom_territoire : nouveau nom du territoire (optionnel)
--
create or replace procedure territoire_mod_gen_sst_exs(
    i_code_territoire "SSQA_2".territoire_code,
    i_nouveau_code_territoire "SSQA_2".territoire_code = null,
    i_nouveau_nom_territoire "SSQA_2".territoire_nom = null
)
    language sql as
$$
update "SSQA_2".territoire
set
    code = coalesce(i_nouveau_code_territoire, code),
    nom = coalesce(i_nouveau_nom_territoire, nom)
where code = i_code_territoire;
$$;

-- territoire_ins_gen_sst_exs
--
-- Procédure d'insertion d'un territoire.
--
-- @param i_code_territoire : code du territoire (unique)
-- @param i_nom_territoire : nom du territoire
--
create or replace procedure territoire_ins_gen_sst_exs(
        i_code_territoire "SSQA_2".territoire_code,
        i_nom_territoire "SSQA_2".territoire_nom
    )
    language sql as
    $$
        insert into "SSQA_2".territoire(code, nom)
        values (i_code_territoire, i_nom_territoire);
    $$;

-- territoire_ret_gen_sst
--
-- Procédure de suppression d'un territoire.
--
-- @param i_code_territoire : code du territoire (unique)
--
create or replace procedure territoire_ret_gen_sst(
        i_code_territoire "SSQA_2".territoire_code
    )
    language sql as
    $$
        delete
        from "SSQA_2".territoire
        where code = i_code_territoire;
    $$;

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout des procédures et fonctions EMIR pour les territoires.

-- -----------------------------------------------------------------------------
-- 3.1.0_SSQA_EMIR_Territoire.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- 3.2.0_SSQA_EMIR_Station.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Ajout des procédures et fonctions EMIR pour les stations.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2_PUB";
set schema 'SSQA_2_PUB';

-- station_eva_gen
--
-- Fonction d'évaluation de toutes les stations.
--
-- @return les identifiants de toutes les stations.
--
create or replace function station_eva_gen()
    returns setof "SSQA_2".station_code
    language sql as
    $$
        select code
        from "SSQA_2".station;
    $$;

-- station_eva_mobile
--
-- Fonction d'évaluation des stations mobiles.
--
-- @return les identifiants des stations mobiles.
--
create or replace function station_eva_mobile()
    returns setof "SSQA_2".station_code
    language sql as
    $$
        select code
        from "SSQA_2".station
        where mobilite = true;
    $$;

-- station_eva_fixe
--
-- Fonction d'évaluation des stations fixes.
--
-- @return les identifiants des stations fixes.
--
create or replace function station_eva_fixe()
    returns setof "SSQA_2".station_code
    language sql as
    $$
        select code
        from "SSQA_2".station
        where mobilite = false;
    $$;

-- station_eva_unique
--
-- Fonction d'évaluation d'une station.
--
-- @param i_station_code l'identifiant de la station.
--
-- @return tous les attributs concernant la station.
--
create or replace function station_eva_unique(
    i_station_code "SSQA_2".station_code
    )
    returns table (
        code "SSQA_2".station_code,
        debut_service "SSQA_2".estampille,
        fin_service   "SSQA_2".estampille,
        mobilite      "SSQA_2".station_mobilite,
        nom           "SSQA_2".station_nom,
        immatriculation "SSQA_2".immatriculation_code,
        latitude      "SSQA_2".latitude,
        longitude     "SSQA_2".longitude,
        altitude      "SSQA_2".altitude,
        territoire    "SSQA_2".territoire_code
    )
    language sql as
    $$
        select
            s.code,
            s.debut_service,
            s.fin_service,
            s.mobilite,
            ns.nom,
            i.immatriculation,
            p.latitude,
            p.longitude,
            p.altitude,
            d.territoire
        from "SSQA_2".station s
        left join "SSQA_2".nom_station ns on s.code = ns.code
        left join "SSQA_2".immatriculation i on s.code = i.station
        left join "SSQA_2".position p on s.code = p.station
        left join "SSQA_2".distribution d on s.code = d.station
        where s.code = i_station_code and p.fin is null;
    $$;

-- station_eva_hs
--
-- Fonction d'évaluation des périodes d'indisponibilité d'une station.
--
-- @param i_station_code l'identifiant de la station.
--
-- @return les périodes d'indisponibilité de la station.
--
create or replace function station_eva_hs(
    i_station_code "SSQA_2".station_code
    )
    returns table (
        station "SSQA_2".station_code,
        debut "SSQA_2".estampille,
        fin "SSQA_2".estampille,
        nature "SSQA_2".hors_service_code,
        description "SSQA_2".description_hors_service
    )
    language sql as
    $$
        select
            hs.station,
            hs.debut,
            hs.fin,
            nhs.code,
            nhs.description
        from "SSQA_2".hors_service hs
        join "SSQA_2".nature_hors_service nhs on nhs.code = hs.nature
        where station = i_station_code;
    $$;

-- station_eva_capacite
--
-- Fonction d'évaluation des capacités d'une station.
--
-- @param i_station_code l'identifiant de la station.
--
-- @return les capacités de la station.
--
create or replace function station_eva_capacite(
    i_station_code "SSQA_2".station_code
    )
    returns "SSQA_2".capacite
    language sql as
    $$
        select *
        from "SSQA_2".capacite
        where station = i_station_code;
    $$;

-- station_mod_pos
--
-- Procédure de modification de la position d'une station.
--
-- @param i_station_code l'identifiant de la station.
-- @param i_station_latitude la latitude de la station.
-- @param i_station_longitude la longitude de la station.
-- @param i_station_altitude l'altitude de la station.
--
create or replace procedure station_mod_pos(
    i_station_code "SSQA_2".station_code,
    i_station_latitude "SSQA_2".latitude,
    i_station_longitude "SSQA_2".longitude,
    i_station_altitude "SSQA_2".altitude
    )
    language sql as
    $$
        update "SSQA_2".position
        set fin = now()
        where station = i_station_code and position.fin is null;

        insert into "SSQA_2".position
        values (
            i_station_code,
            i_station_latitude,
            i_station_longitude,
            i_station_altitude,
            now(),
            null
        );
    $$;

-- station_ins_mobile_sst
--
-- Procédure d'insertion d'une station mobile.
--
-- @param i_station_code l'identifiant de la station.
-- @param i_station_immatriculation_code l'immatriculation de la station.
-- @param i_station_latitude la latitude de la station.
-- @param i_station_longitude la longitude de la station.
-- @param i_station_altitude l'altitude de la station.
-- @param i_station_nom le nom de la station.
-- @param i_station_distribution la distribution de la station.
--
create or replace procedure station_ins_mobile_sst(
    i_station_code "SSQA_2".station_code,
    i_station_immatriculation_code "SSQA_2".immatriculation_code,
    i_station_latitude "SSQA_2".latitude,
    i_station_longitude "SSQA_2".longitude,
    i_station_altitude "SSQA_2".altitude,
    i_station_nom "SSQA_2".station_nom,
    i_station_distribution "SSQA_2".distribution
    )
    language sql as
    $$
        insert into "SSQA_2".station
        values (i_station_code,
                now(),
                null,
                true);

        insert into "SSQA_2".immatriculation
        values (i_station_code,
                i_station_immatriculation_code);

        insert into "SSQA_2".position
        values (i_station_code,
                i_station_latitude,
                i_station_longitude,
                i_station_altitude,
                now(),
                null);

        insert into "SSQA_2".nom_station
        values (i_station_code,
                i_station_nom);

        insert into "SSQA_2".distribution
        values (i_station_code,
                i_station_distribution);
    $$;

-- station_ins_fixe_sst
--
-- Procédure d'insertion d'une station fixe.
--
-- @param i_station_code l'identifiant de la station.
-- @param i_station_immatriculation_code l'immatriculation de la station.
-- @param i_station_distribution la distribution de la station.
-- @param i_station_nom le nom de la station (optionnel).
-- @param i_station_latitude la latitude de la station (optionnel).
-- @param i_station_longitude la longitude de la station (optionnel).
-- @param i_station_altitude l'altitude de la station (optionnel).
--
create or replace procedure station_ins_fixe_sst(
    i_station_code "SSQA_2".station_code,
    i_station_immatriculation_code "SSQA_2".immatriculation_code,
    i_station_distribution "SSQA_2".distribution,
    i_station_nom "SSQA_2".station_nom default null,
    i_station_latitude "SSQA_2".latitude default null,
    i_station_longitude "SSQA_2".longitude default null,
    i_station_altitude "SSQA_2".altitude default null
    )
    language sql as
    $$;
        insert into "SSQA_2".station
        values (i_station_code,
                now(),
                null,
                false);

        insert into "SSQA_2".immatriculation
        values (i_station_code,
                i_station_immatriculation_code);

        insert into "SSQA_2".nom_station
        values (i_station_code,
                i_station_nom);

        insert into "SSQA_2".distribution
        values (i_station_code,
                i_station_distribution);

        insert into "SSQA_2".position
        values (i_station_code,
                i_station_latitude,
                i_station_longitude,
                i_station_altitude,
                now(),
                null);
    $$;

-- station_ins_capacite
--
-- Procédure d'ajout d'une capacité à une station.
--
-- @param i_station_code l'identifiant de la station.
-- @param i_variable_code le code de la variable.
--
create or replace procedure station_ins_capacite(
    i_station_code "SSQA_2".station_code,
    i_variable_code "SSQA_2".variable_code
    )
    language sql as
    $$
        insert into "SSQA_2".capacite
        values (
            i_station_code,
            i_variable_code
        );
    $$;

-- station_ret_gen_sst
--
-- Procédure de suppression d'une station.
--
-- @param i_station_code l'identifiant de la station.
--
create or replace procedure station_ret_gen_sst(
    i_station_code "SSQA_2".station_code
    )
    language sql as
    $$
        delete
        from "SSQA_2".station
        where code = i_station_code;
    $$;

-- station_ret_capacite
--
-- Procédure de suppression d'une capacité d'une station.
--
-- @param i_station_code l'identifiant de la station.
-- @param i_variable_code le code de la variable.
--
create or replace procedure station_ret_capacite(
    i_station_code "SSQA_2".station_code,
    i_variable_code "SSQA_2".variable_code
    )
    language sql as
    $$
        delete
        from "SSQA_2".capacite
        where station = i_station_code
        and variable = i_variable_code;
    $$;

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout des procédures et fonctions EMIR pour les stations.

-- -----------------------------------------------------------------------------
-- 3.2.0_SSQA_EMIR_Station.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- 3.3.0_SSQA_EMIR_Mesure.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Ajout des procédures et fonctions EMIR pour les mesures.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2_PUB";
set schema 'SSQA_2_PUB';

-- mesure_eva_gen
--
-- Fonction d'évaluation de toutes les mesures.
--
-- @return toutes les mesures
--
create or replace function mesure_eva_gen()
    returns setof "SSQA_2".mesure
    language sql as
    $$
        select *
        from "SSQA_2".mesure;
    $$;

-- mesure_eva_stat
--
-- Fonction d'évaluation de toutes les mesures d'une station.
--
-- @param i_station_id code de la station
-- @return toutes les mesures d'une station
--
create or replace function mesure_eva_stat(i_station_id "SSQA_2".station_code)
    returns setof "SSQA_2".mesure
    language sql as
    $$
        select *
        from "SSQA_2".mesure
        where station = i_station_id;
    $$;

-- mesure_eva_var
--
-- Fonction d'évaluation de toutes les mesures d'une variable.
--
-- @param i_variable_id code de la variable
-- @return toutes les mesures d'une variable
--
create or replace function mesure_eva_var(i_variable_id "SSQA_2".variable_code)
    returns setof "SSQA_2".mesure
    language sql as
    $$
        select *
        from "SSQA_2".mesure
        where variable = i_variable_id;
    $$;

-- mesure_eva_date
--
-- Fonction d'évaluation de toutes les mesures pour une date.
--
-- @param i_date date de la mesure
-- @return toutes les mesures pour une date
--
create or replace function mesure_eva_date(i_date "SSQA_2".estampille)
    returns setof "SSQA_2".mesure
    language sql as
    $$
        select *
        from "SSQA_2".mesure
        where moment = i_date;
    $$;

-- mesure_eva_stat_date
--
-- Fonction d'évaluation de toutes les mesures d'une station pour une date.
--
-- @param i_station_id code de la station
-- @param i_date date de la mesure
-- @return toutes les mesures d'une station pour une date
--
create or replace function mesure_eva_stat_date(i_station_id "SSQA_2".station_code, i_date "SSQA_2".estampille)
    returns setof "SSQA_2".mesure
    language sql as
    $$
        select *
        from "SSQA_2".mesure
        where station = i_station_id
        and moment = i_date;
    $$;

-- mesure_eva_stat_var
--
-- Fonction d'évaluation de toutes les mesures d'une station pour une variable.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @return toutes les mesures d'une station pour une variable
--
create or replace function mesure_eva_stat_var(i_station_id "SSQA_2".station_code, i_variable_id "SSQA_2".variable_code)
    returns setof "SSQA_2".mesure
    language sql as
    $$
        select *
        from "SSQA_2".mesure
        where station = i_station_id
        and variable = i_variable_id;
    $$;

-- mesure_eva_stat_var_date
--
-- Fonction d'évaluation de la mesure d'une station pour une variable et une date.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @param i_date date de la mesure
-- @return la mesure d'une station pour une variable et une date
--
create or replace function mesure_eva_stat_var_date(i_station_id "SSQA_2".station_code, i_variable_id "SSQA_2".variable_code, i_date "SSQA_2".estampille)
    returns setof "SSQA_2".mesure
    language sql as
    $$
        select *
        from "SSQA_2".mesure
        where station = i_station_id
        and variable = i_variable_id
        and moment = i_date;
    $$;

-- mesure_eva_stat_var_after_date
--
-- Fonction d'évaluation de toutes les mesures d'une station pour une variable et après une date.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @param i_date date minimale des mesures
-- @return toutes les mesures d'une station pour une variable et après une date
--
create or replace function mesure_eva_stat_var_after_date(i_station_id "SSQA_2".station_code, i_variable_id "SSQA_2".variable_code, i_date "SSQA_2".estampille)
    returns setof "SSQA_2".mesure
    language sql as
    $$
        select *
        from "SSQA_2".mesure
        where station = i_station_id
        and variable = i_variable_id
        and moment >= i_date;
    $$;

-- mesure_eva_stat_var_between_date
--
-- Fonction d'évaluation de toutes les mesures d'une station pour une variable et entre deux dates.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @param i_date_min date minimale des mesures
-- @param i_date_max date maximale des mesures
-- @return toutes les mesures d'une station pour une variable et entre deux dates
--
create or replace function mesure_eva_stat_var_between_date(i_station_id "SSQA_2".station_code, i_variable_id "SSQA_2".variable_code, i_date_min "SSQA_2".estampille, i_date_max "SSQA_2".estampille)
    returns setof "SSQA_2".mesure
    language sql as
    $$
        select *
        from "SSQA_2".mesure
        where station = i_station_id
        and variable = i_variable_id
        and moment >= i_date_min
        and moment <= i_date_max;
    $$;

-- mesure_mod_gen_sst_exs
--
-- Procédure de modification de la valeur d'une mesure.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @param i_date date de la mesure
-- @param i_valeur nouvelle valeur de la mesure
--
create or replace procedure mesure_mod_gen_sst_exs(i_station_id "SSQA_2".station_code, i_variable_id "SSQA_2".variable_code, i_date "SSQA_2".estampille, i_valeur "SSQA_2".mesure_valeur)
    language sql as
    $$
        update "SSQA_2".mesure
        set valeur = i_valeur
        where station = i_station_id
        and variable = i_variable_id
        and moment = i_date;
    $$;

-- mesure_ret_gen_sst_exs
--
-- Procédure de suppression d'une mesure.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @param i_date date de la mesure
--
create or replace procedure mesure_ret_gen_sst_exs(i_station_id "SSQA_2".station_code, i_variable_id "SSQA_2".variable_code, i_date "SSQA_2".estampille)
    language sql as
    $$
        delete from "SSQA_2".mesure
        where station = i_station_id
        and variable = i_variable_id
        and moment = i_date;
    $$;

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout des procédures et fonctions EMIR pour les mesures.

-- -----------------------------------------------------------------------------
-- 3.3.0_SSQA_EMIR_Mesure.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- 3.4.0_SSQA_EMIR_Variable.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Ajout des procédures et fonctions EMIR pour les variables.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2_PUB";
set schema 'SSQA_2_PUB';

-- variable_eva_gen
--
-- Fonction d'évaluation de toutes les variables.
--
-- @return toutes les variables.
--
create or replace function variable_eva_gen()
    returns setof "SSQA_2".variable
    language sql
    as $$
        select *
        from "SSQA_2".variable
    $$;

-- variable_eva_one
--
-- Fonction d'évaluation d'une variable.
--
-- @param i_variable_id le code de la variable.
-- @return la variable.
--
create or replace function variable_eva_one(i_variable_id "SSQA_2".variable_code)
    returns "SSQA_2".variable
    language sql
    as $$
        select *
        from "SSQA_2".variable
        where code = i_variable_id
    $$;

-- variable_eva_unite
--
-- Fonction d'évaluation de toutes les variables d'une unité.
--
-- @param i_unite_symbole le symbole de l'unité.
-- @return toutes les variables de l'unité.
--
create or replace function variable_eva_unite(i_unite_symbole "SSQA_2".unite_symbole)
    returns setof "SSQA_2".variable
    language sql
    as $$
        select *
        from "SSQA_2".variable
        where unite = i_unite_symbole
    $$;

--variable_mod_gen_sst_exs
--
-- Fonction de modification d'une variable.
--
-- @param i_variable_id le code de la variable.
-- @param i_variable_nom le nouveau nom de la variable (optionnel).
-- @param i_unite_symbole le symbole de la nouvelle unité (optionnel).
-- @param i_variable_valref la nouvelle valeur de référence (optionnel).
-- @param i_variable_methode la nouvelle méthode (optionnel).
--
create or replace function variable_mod_gen_sst_exs(i_variable_id "SSQA_2".variable_code, i_variable_nom "SSQA_2".variable_nom, i_unite_symbole "SSQA_2".unite_symbole, i_variable_valref "SSQA_2".mesure_valeur, i_variable_methode "SSQA_2".methode_enum)
    returns void
    language sql
    as $$
        update "SSQA_2".variable
        set nom = coalesce(i_variable_nom, nom),
            unite = coalesce(i_unite_symbole, unite),
            valref = coalesce(i_variable_valref, valref),
            methode = coalesce(i_variable_methode, methode)
        where code = i_variable_id
    $$;

-- variable_ins_gen_sst_exs
--
-- Procédure d'insertion d'une variable.
--
-- @param i_variable_id le code de la variable. (unique)
-- @param i_variable_nom le nom de la variable.
-- @param i_unite_symbole le symbole de l'unité.
-- @param i_variable_valref la valeur de référence.
-- @param i_variable_methode la méthode.
--
create or replace procedure variable_ins_gen_sst_exs(i_variable_id "SSQA_2".variable_code, i_variable_nom "SSQA_2".variable_nom, i_unite_symbole "SSQA_2".unite_symbole, i_variable_valref "SSQA_2".mesure, i_variable_methode "SSQA_2".methode_enum)
    language sql
    as $$
        insert into "SSQA_2".variable
        values (i_variable_id, i_variable_nom, i_unite_symbole, i_variable_valref, i_variable_methode)
    $$;

-- variable_ret_gen_sst_exs
--
-- Procédure de retrait d'une variable.
--
-- @param i_variable_id le code de la variable.
--
create or replace procedure variable_ret_gen_sst_exs(i_variable_id "SSQA_2".variable_code)
    language sql
    as $$
        delete from "SSQA_2".variable
        where code = i_variable_id
    $$;

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout des procédures et fonctions EMIR pour les variables.

-- -----------------------------------------------------------------------------
-- 3.4.0_SSQA_EMIR_Variable.sql
-- =========================================================================== Z
*/
/*
-- =========================================================================== A
-- 4.1.0_SSQA_DIM_Mesure.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Ajout des tables de fait et de dimension pour le schéma SSQA_DIM en rapport aux mesures valides et invalides.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_DIM";
set schema 'SSQA_DIM';

CREATE TABLE Mesure_valide_fait
(
    "station"   "SSQA_2".station_code,
    "moment"    "SSQA_2".estampille,
    "variable"  "SSQA_2".variable_code,
    "valeur"    "SSQA_2".mesure_valeur NOT NULL,
    "latitude"  "SSQA_2".latitude      NOT NULL,
    "longitude" "SSQA_2".longitude     NOT NULL,
    "altitude"  "SSQA_2".altitude      NOT NULL,
    PRIMARY KEY ("station", "moment", "variable")
);

CREATE TABLE Mesure_invalide_fait
(
    "station"                   "SSQA_2".station_code,
    "moment"                    "SSQA_2".estampille,
    "variable"                  "SSQA_2".variable_code,
    "valeur"                    "SSQA_2".mesure_valeur             NOT NULL,
    "latitude"                  "SSQA_2".latitude                  NOT NULL,
    "longitude"                 "SSQA_2".longitude                 NOT NULL,
    "altitude"                  "SSQA_2".altitude                  NOT NULL,
    "erreur_mesure_code"        "SSQA_2".Code_erreur_mesure        NOT NULL,
    "erreur_mesure_description" "SSQA_2".description_erreur_mesure NOT NULL,
    PRIMARY KEY ("station", "moment", "variable")
);

CREATE TABLE Variable
(
    "code"    "SSQA_2".variable_code,
    "nom"     "SSQA_2".variable_nom,
    "unite"   "SSQA_2".unite_symbole,
    "valref"  "SSQA_2".mesure_valeur,
    "methode" Text,
    PRIMARY KEY ("code")
);
CREATE UNIQUE INDEX "Variable_cc1" ON "variable" ("nom");

CREATE TABLE Station
(
    "code"          "SSQA_2".station_code     NOT NULL,
    "debut_service" "SSQA_2".estampille,
    "fin_service"   "SSQA_2".estampille,
    "mobilite"      "SSQA_2".station_mobilite,
    PRIMARY KEY ("code")
);

ALTER TABLE Mesure_valide_fait
    ADD CONSTRAINT "Mesure_valide_fait_cr0" FOREIGN KEY ("variable") REFERENCES Variable ("code")
    ON DELETE CASCADE;

ALTER TABLE Mesure_valide_fait
    ADD CONSTRAINT "Mesure_valide_fait_cr1" FOREIGN KEY ("station") REFERENCES Station ("code")
    ON DELETE CASCADE;

ALTER TABLE Mesure_invalide_fait
    ADD CONSTRAINT "Mesure_invalide_fait_cr0" FOREIGN KEY ("variable") REFERENCES Variable ("code")
    ON DELETE CASCADE;

ALTER TABLE Mesure_invalide_fait
    ADD CONSTRAINT "Mesure_invalide_fait_cr1" FOREIGN KEY ("station") REFERENCES Station ("code")
    ON DELETE CASCADE;


/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout de la table de fait Mesure_valide_fait.
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout de la table de fait Mesure_invalide_fait.
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout de la table de dimension Variable.
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout de la table de dimension Station.

-- -----------------------------------------------------------------------------
-- 4.1.0_SSQA_DIM_Mesure.sql
-- =========================================================================== Z
*/

/*
-- =========================================================================== A
-- 4.1.1_SSQA_EMIR_Update_Mesure.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Modification des procédures EMIR d'ajout de mesures, afin qu'elles insèrent également dans la base dimensionnelle.
-- =========================================================================== A
*/

--mesure_ins_gen_sst_exs
--
-- Procédure d'insertion d'une mesure. Si la valeur de la variable n'est pas comprise dans l'intervalle de la table validation pour cette variable et la norme choisie, une entrée est ajoutée dans la table erreur_mesure avec le code d'erreur 1.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @param i_date date de la mesure
-- @param i_valeur valeur de la mesure
--

-- Définition du schéma
create schema if not exists "SSQA_2_PUB";
set schema 'SSQA_2_PUB';

create or replace procedure mesure_ins_gen_sst_exs(i_station_id "SSQA_2".station_code, i_variable_id "SSQA_2".variable_code, i_date "SSQA_2".estampille, i_valeur "SSQA_2".mesure_valeur, i_norme "SSQA_2".norme_code)
    language plpgsql as
    $$
        begin
        -- Si la mesure ne respecte pas les normes, on l'insère avec mesure_ins_with_error.
        if not exists (
            select *
            from "SSQA_2".validation
            where variable = i_variable_id
            and norme = i_norme
            and min <= i_valeur
            and max >= i_valeur
        ) then
            call mesure_ins_with_error(i_station_id, i_variable_id, i_date, i_valeur, 1);
            return;
        end if;

        -- Sinon, on l'insère normalement.

        -- Insertion de la mesure dans la base relationnelle.
        insert into "SSQA_2".mesure (station, variable, moment, valeur)
        values (i_station_id, i_variable_id, i_date, i_valeur);

        -- Insertion de la variable dans la base dimensionnelle, si elle n'existe pas déjà.
        insert into "SSQA_DIM".variable
        select *
        from "SSQA_2".variable
        where "SSQA_2".variable.code = i_variable_id
        ON CONFLICT DO NOTHING;

        -- Insertion de la station dans la base dimensionnelle, si elle n'existe pas déjà.
        insert into "SSQA_DIM".station
        select *
        from "SSQA_2".station
        where "SSQA_2".station.code = i_station_id
        ON CONFLICT DO NOTHING;

        -- Insertion de la mesure invalide dans la base dimensionnelle.
        insert into "SSQA_DIM".mesure_valide_fait
        select m.station, m.moment, m.variable, m.valeur, p.latitude, p.longitude, p.altitude
        from "SSQA_2".mesure m
        join "SSQA_2".station s on m.station = s.code
        join "SSQA_2".position p on s.code = p.station and p.fin is null
        where m.station = i_station_id AND m.variable = i_variable_id AND m.moment = i_date;

        end;
    $$;

-- mesure_ins_with_error
--
-- Procédure d'insertion d'une mesure avec une erreur de mesure.
--
-- @param i_station_id code de la station
-- @param i_variable_id code de la variable
-- @param i_date date de la mesure
-- @param i_valeur valeur de la mesure
-- @param i_erreur_mesure_code code de l'erreur de mesure
--
create or replace procedure mesure_ins_with_error(i_station_id "SSQA_2".station_code, i_variable_id "SSQA_2".variable_code, i_date "SSQA_2".estampille, i_valeur "SSQA_2".mesure_valeur, i_erreur_mesure_code "SSQA_2".code_erreur_mesure)
    language plpgsql as
    $$
    begin
        -- Insertion de la mesure dans la base relationnelle.
        insert into "SSQA_2".mesure (station, variable, moment, valeur)
        values (i_station_id, i_variable_id, i_date, i_valeur);

        -- Insertion de l'erreur de mesure dans la base relationnelle.
        insert into "SSQA_2".erreur_mesure (station, variable, moment, erreur_mesure_code)
        values (i_station_id, i_variable_id, i_date, i_erreur_mesure_code);

        -- Insertion de la variable dans la base dimensionnelle, si elle n'existe pas déjà.
        insert into "SSQA_DIM".variable
        select *
        from "SSQA_2".variable
        where "SSQA_2".variable.code = i_variable_id
        ON CONFLICT DO NOTHING;

        -- Insertion de la station dans la base dimensionnelle, si elle n'existe pas déjà.
        insert into "SSQA_DIM".station
        select *
        from "SSQA_2".station
        where "SSQA_2".station.code = i_station_id
        ON CONFLICT DO NOTHING;

        -- Insertion de la mesure invalide dans la base dimensionnelle.
        insert into "SSQA_DIM".mesure_invalide_fait
        select m.station, m.moment, m.variable, m.valeur, p.latitude, p.longitude, p.altitude, e.code, e.nom
        from "SSQA_2".mesure m
        join "SSQA_2".station s on m.station = s.code
        join "SSQA_2".position p on s.code = p.station and p.fin is null
        join "SSQA_2".erreur_mesure_code e on i_erreur_mesure_code = e.code
        where m.station = i_station_id AND m.variable = i_variable_id AND m.moment = i_date;

        end;
    $$;

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Modification des procédures EMIR d'ajout de mesures, afin qu'elles insèrent également dans la base dimensionnelle.

-- -----------------------------------------------------------------------------
-- 4.1.1_SSQA_EMIR_Update_Mesure.sql
-- =========================================================================== Z
*/

/*
-- =========================================================================== A
-- 4.2.0_SSQA_DIM_Deplacement.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Ajout de la table de fait Deplacement_fait, au schéma SSQA_DIM.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_DIM";
set schema 'SSQA_DIM';

CREATE TABLE Deplacement_fait
(
    "station"           "SSQA_2".station_code,
    "debut_deplacement" "SSQA_2".estampille,
    "temps_deplacement" interval,
    "latitude_depart"   "SSQA_2".latitude  NOT NULL,
    "longitude_depart"  "SSQA_2".longitude NOT NULL,
    "altitude_depart"   "SSQA_2".altitude  NOT NULL,
    "latitude_fin"      "SSQA_2".latitude,
    "longitude_fin"     "SSQA_2".longitude,
    "altitude_fin"      "SSQA_2".altitude,
    PRIMARY KEY ("station", "debut_deplacement")
);

ALTER TABLE Deplacement_fait
    ADD CONSTRAINT "Deplacement_fait_cr0" FOREIGN KEY ("station") REFERENCES Station ("code");

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout de la table de fait Deplacement_fait
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout de la table de dimension Position
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout de la table de dimension Station

-- -----------------------------------------------------------------------------
-- 4.2.0_SSQA_DIM_Deplacement.sql
-- =========================================================================== Z
*/

/*
-- =========================================================================== A
-- 4.2.1_SSQA_EMIR_Update_Station.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Mise à jour de la procédure de modification de la position d'une station, afin qu'elle mette à jour l'entrepôt SSQA_DIM.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2_PUB";
set schema 'SSQA_2_PUB';

-- station_mod_pos
--
-- Procédure de modification de la position d'une station.
--
-- @param i_station_code l'identifiant de la station.
-- @param i_station_latitude la latitude de la station.
-- @param i_station_longitude la longitude de la station.
-- @param i_station_altitude l'altitude de la station.
-- @param i_fin_ancienne_position la date de fin de l'ancienne position.
-- @param i_debut_nouvelle_position la date de début de la nouvelle position.
--
create or replace procedure station_mod_pos(
    i_station_code "SSQA_2".station_code,
    i_station_latitude "SSQA_2".latitude,
    i_station_longitude "SSQA_2".longitude,
    i_station_altitude "SSQA_2".altitude,
    i_fin_ancienne_position "SSQA_2".estampille,
    i_debut_nouvelle_position "SSQA_2".estampille
)
    language plpgsql as
$$
declare
    old_latitude "SSQA_2".latitude;
    old_longitude "SSQA_2".longitude;
    old_altitude "SSQA_2".altitude;
begin
    -- Modification de l'ancienne position dans la base relationnelle.
    update "SSQA_2".position
    set fin = i_fin_ancienne_position
    where station = i_station_code and position.fin is null
    returning latitude, longitude, altitude into old_latitude, old_longitude, old_altitude;

    -- Insertion de la nouvelle position dans la base relationnelle.
    insert into "SSQA_2".position
    values (i_station_code,
            i_station_latitude,
            i_station_longitude,
            i_station_altitude,
            i_debut_nouvelle_position,
            null);

    -- Si la station n'existe pas dans l'entrepot SSQA_DIM, on l'ajoute.
    INSERT into "SSQA_DIM".station
    select *
    from "SSQA_2".station
    where "SSQA_2".station.code = i_station_code
    ON CONFLICT DO NOTHING;

    -- Insertion du déplacement dans l'entrepot SSQA_DIM.
    insert into "SSQA_DIM".deplacement_fait
    values (i_station_code, -- station
            i_fin_ancienne_position, -- debut_deplacement
            i_debut_nouvelle_position - i_fin_ancienne_position, -- temps_deplacement
            old_latitude, -- latitude_debut
            old_longitude, -- longitude_debut
            old_altitude, -- altitude_debut
            i_station_latitude, -- latitude_fin
            i_station_longitude, -- longitude_fin
            i_station_altitude -- altitude_fin
           );
end;
$$;

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Mise à jour de la procédure de modification de la position d'une station, afin qu'elle mette à jour l'entrepôt SSQA_DIM.

-- -----------------------------------------------------------------------------
-- 4.2.1_SSQA_EMIR_Update_Station.sql
-- =========================================================================== Z
*/

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Clonage des schémas SSQA et SSQA_PUB en SSQA_2 et SSQA_2_PUB.

-- -----------------------------------------------------------------------------
-- 4.3.0_SSQA_Clone_SSQA_2-SSQA_2_PUB.sql
-- =========================================================================== Z
*/