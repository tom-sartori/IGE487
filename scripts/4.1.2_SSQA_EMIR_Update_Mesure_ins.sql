/*
-- =========================================================================== A
-- 4.1.2_SSQA_EMIR_Update_Mesure_ins.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Ajout de mesures dans la base de données relationnelle et dimensionnelle.
-- =========================================================================== A
*/


-- Insert valide.
call mesure_ins_gen_sst_exs('10000', 'NO2', '2023-12-08 22:18:07.293273' , 4, 'NQMAA_2014');

-- Insert invalide.
call mesure_ins_gen_sst_exs('16000', 'CO', '2023-12-08 22:18:07.293273' , 50, 'NCQAA_2020');

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Ajout de mesures dans la base de données relationnelle et dimensionnelle.

-- -----------------------------------------------------------------------------
-- 4.1.2_SSQA_EMIR_Update_Mesure_ins.sql
-- =========================================================================== Z
*/
