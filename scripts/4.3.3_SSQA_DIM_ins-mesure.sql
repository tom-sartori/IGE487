/*
-- =========================================================================== A
-- 4.3.3_SSQA_DIM_ins-mesure.sql
-- ---------------------------------------------------------------------------
Activité : IFT187_2023-1
Encodage : UTF-8, CRLF
Plateforme : PostgreSQL 12 à 15
Responsable : alexandre.theisse@usherbrooke.ca, louis-vincent.capelli@usherbrooke.ca, raphael.turcotte2@usherbrooke.ca, tom.sartori@usherbrooke.ca,
Version : 1.0.0
Statut : en vigueur
Résumé : Insertion des mesures dans le schéma SSQA2, grâce à l'EMIR SSQA_2_PUB.mesure_ins_gen_sst_exs. Insert également dans SSQA_DIM.
-- =========================================================================== A
*/

-- Définition du schéma
create schema if not exists "SSQA_2_PUB";
set schema 'SSQA_2_PUB';

--Mesures de la station 04021,04048 pour la variable SO2, NO2, CO, PM25, O3
call mesure_ins_gen_sst_exs('04021', 'NO2', '2020-02-04 15:00:00', 4, 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'NO2', '2020-02-04 16:00:00', 4 , 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'NO2', '2020-02-04 17:00:00', 4 , 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'NO2', '2020-02-04 18:00:00', 5 , 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'NO2', '2020-02-04 19:00:00', 4, 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'NO2', '2020-02-04 20:00:00', 11 , 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'NO2', '2020-02-04 21:00:00', 6 , 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-04 22:00:00', 0 , 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-04 23:00:00', 3, 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 00:00:00', 4, 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 01:00:00', 3, 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 02:00:00', 0.1211 , 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 03:00:00', 0.163 , 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 04:00:00', 0.2702 , 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 05:00:00', 0.1865 , 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 06:00:00', 0.1675 , 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 07:00:00', 0.1677 , 'NQMAA_2014');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 08:00:00', 0.1335 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 09:00:00', 0.1442 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 10:00:00', 0.1607 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 11:00:00', 0.1155 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 12:00:00', 0.1267 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 13:00:00', 0.1442 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 14:00:00', 0.142 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 15:00:00', 0.1497 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 16:00:00', 0.2745 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 17:00:00', 0.3892 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 18:00:00', 0.2093 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 19:00:00', 0.161 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 20:00:00', 0.3067 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 21:00:00', 0.159 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 22:00:00', 0.166 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-05 23:00:00', 0.216 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 00:00:00', 0.2508 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 01:00:00', 0.2222 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 02:00:00', 0.2249 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 03:00:00', 0.2528 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 04:00:00', 0.3587 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 05:00:00', 0.2363 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 06:00:00', 0.2215 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 07:00:00', 0.2253 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 08:00:00', 0.1028 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 09:00:00', 0.3267 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 10:00:00', 0.2328 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 11:00:00', 0.1958 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 12:00:00', 0.2193 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 13:00:00', 0.1735 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 14:00:00', 0.162 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 15:00:00', 0.1775 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 16:00:00', 0.2335 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 17:00:00', 0.1635 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 18:00:00', 0.1488 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 19:00:00', 0.1183 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 20:00:00', 0.1367 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 21:00:00', 0.1162 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 22:00:00', 0.1152 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-06 23:00:00', 0.1623 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 00:00:00', 0.1392 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 01:00:00', 0.0936 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 02:00:00', 0.1045 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 03:00:00', 0.1152 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 04:00:00', 0.2013 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 05:00:00', 0.1208 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 06:00:00', 0.1585 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 07:00:00', 0.137 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 08:00:00', 0.1432 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 09:00:00', 0.0822 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 10:00:00', 0.1163 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 11:00:00', 0.1117 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 12:00:00', 0.0895 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 13:00:00', 0.1253 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 14:00:00', 0.1282 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 15:00:00', 0.0952 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 16:00:00', 0.1442 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 17:00:00', 0.116 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 18:00:00', 0.154 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 19:00:00', 0.1438 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 20:00:00', 0.1445 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 21:00:00', 0.1533 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 22:00:00', 0.1383 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-07 23:00:00', 0.135 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 00:00:00', 0.1482 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 01:00:00', 0.1098 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 02:00:00', 0.103 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 03:00:00', 0.1236 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 04:00:00', 0.1834 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 05:00:00', 0.1417 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 06:00:00', 0.1513 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 07:00:00', 0.1278 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 08:00:00', 0.1187 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 09:00:00', 0.1302 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 10:00:00', 0.146 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 11:00:00', 0.115 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 12:00:00', 0.0995 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 13:00:00', 0.15 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 14:00:00', 1.6948 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 15:00:00', 4.5735 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 16:00:00', 3.6567 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 17:00:00', 1.378 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 18:00:00', 2.0518 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 19:00:00', 1.509 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 20:00:00', 0.2613 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 21:00:00', 0.3427 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 22:00:00', 0.2877 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-08 23:00:00', 0.275 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 00:00:00', 0.2573 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 01:00:00', 0.1806 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 02:00:00', 0.3283 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 03:00:00', 0.2108 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 04:00:00', 0.3736 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 05:00:00', 0.2888 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 06:00:00', 0.6632 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 07:00:00', 0.6277 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 08:00:00', 0.5037 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 09:00:00', 0.2827 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 10:00:00', 0.2965 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 11:00:00', 0.3023 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 12:00:00', 0.3487 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 13:00:00', 1.2545 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 14:00:00', 0.5452 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 15:00:00', 4.3807 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 16:00:00', 0.3532 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 17:00:00', 0.6252 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 18:00:00', 0.3005 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 19:00:00', 0.2562 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 20:00:00', 0.2268 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 21:00:00', 0.3273 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 22:00:00', 0.2515 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-09 23:00:00', 0.2315 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 00:00:00', 0.1597 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 01:00:00', 0.2252 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 02:00:00', 0.2306 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 03:00:00', 0.2472 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 04:00:00', 0.3513 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 05:00:00', 0.2902 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 06:00:00', 0.3285 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 07:00:00', 0.3077 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 08:00:00', 0.2607 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 09:00:00', 0.2522 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 10:00:00', 0.2563 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 11:00:00', 0.2345 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 12:00:00', 0.2345 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 13:00:00', 0.2345 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 14:00:00', 0.2345 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 15:00:00', 0.2345 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 16:00:00', 0.2345 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 17:00:00', 0.2345 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 18:00:00', 0.2345 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 19:00:00', 0.2345 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 20:00:00', 0.2345 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 21:00:00', 0.2345 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 22:00:00', 0.2345 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2020-02-10 23:00:00', 0.2345 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2021-02-24 12:00:00', 0.0167 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2021-02-24 13:00:00', 0.0838 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2021-02-24 14:00:00', 0.115 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2021-02-24 15:00:00', 0.107 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-24 12:00:00', 0.0167 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-24 13:00:00', 0.0838 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-24 14:00:00', 0.115 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-24 15:00:00', 0.107 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-24 16:00:00', 0.1362 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-24 17:00:00', 0.116 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-24 18:00:00', 0.0788 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-24 19:00:00', 0.0573 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-24 20:00:00', 0.0412 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-24 21:00:00', 0.07 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-24 22:00:00', 0.1008 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-24 23:00:00', 0.1503 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-25 00:00:00', 0.0633 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-25 01:00:00', 0.0836 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-25 02:00:00', 0.0338 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-25 03:00:00', 0.0258 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-25 04:00:00', 0.0213 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'SO2', '2022-02-25 05:00:00', 0.0142 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-24 12:00:00', 4.4043 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-24 13:00:00', 4.8818 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-24 14:00:00', 4.5505 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-24 15:00:00', 4.6505 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-24 16:00:00', 5.3332 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-24 17:00:00', 5.0167 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-24 18:00:00', 5.4248 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-24 19:00:00', 4.5663 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-24 20:00:00', 7.5738 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-24 21:00:00', 35.1442 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-24 22:00:00', 42.7405 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-24 23:00:00', 35.1857 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-25 00:00:00', 25.8793 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-25 01:00:00', 14.426 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-25 02:00:00', 14.0022 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-25 03:00:00', 10.5072 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-25 04:00:00', 7.306 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04048', 'PM25', '2022-02-25 05:00:00', 5.7327 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2021-02-13 16:00:00', 0.0582 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2021-02-13 17:00:00', 0.1117 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2021-02-13 18:00:00', 0.2098 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2021-02-13 19:00:00', 0.1757 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2021-02-13 20:00:00', 0.152 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2021-02-13 21:00:00', 0.1247 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2021-02-13 22:00:00', 0.1788 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'SO2', '2021-02-13 23:00:00', 0.1818 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'PM25', '2021-02-13 16:00:00', 32.1545 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'PM25', '2021-02-13 17:00:00', 29.9023 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'PM25', '2021-02-13 18:00:00', 27.7625 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'PM25', '2021-02-13 19:00:00', 27.6823 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'PM25', '2021-02-13 20:00:00', 29.0767 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'PM25', '2021-02-13 21:00:00', 30.3268 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'PM25', '2021-02-13 22:00:00', 23.673 , 'NQMAA_2020');
call mesure_ins_gen_sst_exs('04021', 'PM25', '2021-02-13 23:00:00', 19.4808 , 'NQMAA_2020');

/*
-- =========================================================================== Z
Contributeurs :
    capl1101 louis-vincent.capelli@usherbrooke.ca
    sart0701 tom.sartori@usherbrooke.ca
    thea1804 alexandre.theisse@usherbrooke.ca
    turr3004 raphael.turcotte2@usherbrooke.ca

Tâches réalisées :
  2023-10-11 (capl1101, sart0701, thea1804, turr3004) : Insertion des mesures dans le schéma SSQA2, grâce à l'EMIR SSQA_2_PUB.mesure_ins_gen_sst_exs. Insert également dans SSQA_DIM.

-- -----------------------------------------------------------------------------
-- 4.3.3_SSQA_DIM_ins-mesure.sql
-- =========================================================================== Z
*/
