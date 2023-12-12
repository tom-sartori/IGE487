# IGE487 - Modélisation de bases de données

## Contributeurs

|          Nom          |   CIP    |                                        Mail                                         |
|:---------------------:|:--------:|:-----------------------------------------------------------------------------------:|
|   Alexandre Theisse   | thea1804 |     [alexandre.theisse@usherbrooke.ca](mailto:alexandre.theisse@usherbrooke.ca)     |
| Louis-Vincent Capelli | capl1101 | [louis-vincent.capelli@usherbrooke.ca](mailto:louis-vincent.capelli@usherbrooke.ca) |
|   Raphael Turcotte    | turr3004 |     [raphael.turcotte2@usherbrooke.ca](mailto:raphael.turcotte2@usherbrooke.ca)     |
|      Tom Sartori      | sart0701 |           [tom.sartori@usherbrooke.ca](mailto:tom.sartori@usherbrooke.ca)           |

## Installation

Une concaténation des différents scripts est disponible dans le fichier `scripts/full_script.sql`. Il permet d'avoir la version finale de la base de données. Il comporte certains tests de valeurs invalies et il faut donc le lancer en ignorant les warnings. 

## Note technique

L'intégralité des scripts sql sont disponibles dans le sous dossier `scripts` du projet.

De manière générale, la nomenclature des scripts sql est la suivante : `version_epp.ordre_execution.x_R0X....sql`

Les fonctions et procédures du jalon 2 seront réparties dans des fichiers de la manière suivante :
- `3.1.0_SSQA_EMIR_Territoire` : fonctions atomiques sur les territoires
- `3.2.0_SSQA_EMIR_Station` : fonctions atomiques sur les stations
- `3.3.0_SSQA_EMIR_Mesure` : fonctions atomiques sur les mesures
- `3.4.0_SSQA_EMIR_Variable` : fonctions atomiques sur les variables
- `3.5.0_utils` : fonctions utilitaires (IQA, etc)

Les fonctions et procédures du jalon 3 seront réparties dans des fichiers de la manière suivante :
- `4.1.0_SSQA_DIM_Mesure.sql` : création des tables de faits des mesures valides et invalides, ainsi que leurs tables de dimensions, dans le schéma SSQA_DIM. 
- `4.1.1_SSQA_EMIR_Update_Mesure.sql` : modification de la procédure EMIR d'insertion d'une mesure. 
- `4.1.2_SSQA_EMIR_Update_Mesure_ins.sql` : insertion de mesures dans les schémas SSQA et SSQA_DIM par la procédure EMIR. 
- `4.2.0_SSQA_DIM_Deplacement.sql` : création de la table de faits des dépalcements des stations, ainsi que leurs tables de dimensions, dans le schéma SSQA_DIM. 
- `4.2.1_SSQA_EMIR_Update_Station.sql` : modification de la procédure EMIR de mise à jour d'une station. 
- `4.2.2_SSQA_EMIR_Update_Station_ins.sql` : ajout de déplacements de stations. 
- `4.3.0_SSQA_Clone_SSQA_2-SSQA_2_PUB.sql` : clone des schémas de la base relationnelle et son api. SSQA et SSQA_PUB -> SSQA_2 et SSQA_2_PUB. 
- `4.3.1_SSQA_2_del.sql` : suppression des données clonées inutiles de SSQA_2. 
- `4.3.2_SSQA_2_ins-val.sql` : insertion de nouvelles données dans SSQA_2. 
- `4.3.3_SSQA_DIM_ins-mesure.sql` : insertion des mesures réalisées à Trois Rivières, dans SSQA_2 et SSQA_DIM, par les procédures EMIR de SSQA_2_PUB.  

Comme indiqué plus haut, une concaténation des différents scripts est disponible dans le fichier `scripts/full_script.sql`. Il permet d'avoir la version finale de la base de données. Il comporte certains tests de valeurs invalies et il faut donc le lancer en ignorant les warnings. 
