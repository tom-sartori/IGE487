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
Résumé : Retrait des données des tables du schéma SSQA.
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
delete from distribution ;
delete from Territoire ;
delete from Capacite ;
delete from Station ;
delete from validation ;
delete from Norme ;
delete from Variable ;
delete from Unite ;
delete from composition_unite ;
delete from unite_fond ;
delete from nom_station ;
delete from immatriculation ;
delete from position ;
delete from hors_service ;
delete from nature_hors_service ;
delete from erreur_mesure ;
delete from erreur_mesure_code ;

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
