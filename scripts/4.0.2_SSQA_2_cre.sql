/*Statut : en vigueur
Résumé : Création des tables du schéma SSQA (système de surveillance de la qualité de l’air).
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