
/*
-- =========================================================================== A
-- 4.3.2_SSQA_2_ins-val.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Insertion des données dans le schéma SSQA_2.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2";
set schema 'SSQA_2';

-- Station
/* inserer ces valeurs dans la table station
04019,Trois-Rivières - Ursulines,04,"Face au 678, rue Hart",Trois-Rivières,URBAIN,1975-06-18,2011-06-28,46.3464,-72.537554
04020,Trois-Rivières - Des Draveurs,04,Avenue des Draveurs,Trois-Rivières,URBAIN,2011-08-26,2014-06-25,46.35222222,-72.54
04021,Trois-Rivières - École MEES,04,Rue Whitehead,Trois-Rivières,URBAIN,2014-07-23,,46.357211,-72.54612
04048,Trois-Rivières - Cap-de-la-Madeleine,04,Inters. Roy et Dorval,Trois-Rivières,URBAIN,1975-08-12,,46.3625,-72.51
04049,Trois-Rivières - Éc. l'Assomption,04,275 Montplaisir,Trois-Rivières,URBAIN,1985-04-19,2014-10-14,46.369909,-72.514422
*/
insert into station (code, debut_service, fin_service, mobilite) values
('04019', '1975-06-18', '2011-06-28', false),
('04020', '2011-08-26', '2014-06-25', false),
('04021', '2014-07-23', null, false),
('04048', '1975-08-12', null, false),
('04049', '1985-04-19', '2014-10-14', false);


insert into immatriculation (station, immatriculation) values
('04019', 'Trois-Rivières - Ursulines'),
('04020', 'Trois-Rivières - Des Draveurs'),
('04021', 'Trois-Rivières - École MEES'),
('04048', 'Trois-Rivières - Cap-de-la-Madeleine'),
('04049', 'Trois-Rivières - Éc. l''Assomption');


insert into position (station, latitude, longitude, altitude, debut, fin) values
('04019', 46.3464, -72.537554, 200, now(), null),
('04020', 46.35222222, -72.54, 200, now(), null),
('04021', 46.357211, -72.54612, 200, now(), null),
('04048', 46.3625, -72.51, 200, now(), null),
('04049', 46.369909, -72.514422, 200, now(), null);


insert into nom_station (code, nom) values
('04019', 'Face au 678, rue Hart'),
('04020', 'Avenue des Draveurs'),
('04021', 'Rue Whitehead'),
('04048', 'Inters. Roy et Dorval'),
('04049', '275 Montplaisir');


insert into territoire (code, nom) values
(04, 'Trois-Rivières');

insert into distribution (territoire, station) values
(04, '04019'),
(04, '04020'),
(04, '04021'),
(04, '04048'),
(04, '04049');


insert into capacite (station, variable) values
('04019', 'NO2'),
('04019', 'SO2'),
('04019', 'CO'),
('04019', 'PM25'),
('04019', 'O3'),
('04020', 'NO2'),
('04020', 'SO2'),
('04020', 'CO'),
('04020', 'PM25'),
('04020', 'O3'),
('04021', 'NO2'),
('04021', 'SO2'),
('04021', 'CO'),
('04021', 'PM25'),
('04021', 'O3'),
('04048', 'NO2'),
('04048', 'SO2'),
('04048', 'CO'),
('04048', 'PM25'),
('04048', 'O3'),
('04049', 'NO2'),
('04049', 'SO2'),
('04049', 'CO'),
('04049', 'PM25'),
('04049', 'O3');

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Insertion des données dans le schéma SSQA_2.

-- -----------------------------------------------------------------------------
-- 4.3.2_SSQA_2_ins-val.sql
-- =========================================================================== Z
*/
