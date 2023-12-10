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
Résumé : Création des tables du schéma SSQA (système de surveillance de la qualité de l’air).
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA";
set schema 'SSQA';

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
  2022-11-20 (LL01) : AirEstrie -> SSQA.
  2019-12-17 (CK01) : Création initiale de AirEstrie (version minimaliste).

Références (consultées le 2022-11-24) :
  [epp] https://usherbrooke.sharepoint.com/.../Cours-IFT187-01-H23/General/SSQA_EPP_v2023-1.pdf
  [alth] https://fr.wikipedia.org/wiki/Everest
  [altb] https://fr.wikipedia.org/wiki/Fosse_des_Mariannes

-- -----------------------------------------------------------------------------
-- SSQA_cre.sql
-- =========================================================================== Z
*/
