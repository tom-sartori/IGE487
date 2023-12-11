/*
-- =========================================================================== A
-- 4.2.2_SSQA_EMIR_Update_Station_ins.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Modification de la position d'une station, afin d'insérer des déplacements dans l'entrepôt SSQA_DIM.
-- =========================================================================== A
*/

call station_mod_pos('000001', -72.923, 46.372, 201, '2023-12-08 22:18:07.293273', '2023-12-10 22:18:07.293273');
call station_mod_pos('000001', -73.923, 47.372, 202, '2023-12-11 22:18:07.293273', '2023-12-14 22:18:07.293273');
call station_mod_pos('000001', -74.923, 48.372, 203, '2023-12-15 22:18:07.293273', '2023-12-16 22:18:07.293273');
call station_mod_pos('000001', -75.923, 49.372, 204, '2023-12-17 22:18:07.293273', '2023-12-18 22:18:07.293273');
call station_mod_pos('000001', -76.923, 20.372, 205, '2023-12-21 22:18:07.293273', '2023-12-25 22:18:07.293273');

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Modification de la position d'une station, afin d'insérer des déplacements dans l'entrepôt SSQA_DIM.

-- -----------------------------------------------------------------------------
-- 4.2.2_SSQA_EMIR_Update_Station_ins.sql
-- =========================================================================== Z
*/
