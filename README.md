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

Les fonctions du jalon 2 seront réparties dans des fichiers de la manière suivante :
- `3.1.0_SSQA_EMIR_Territoire` : fonctions atomiques sur les territoires
- `3.2.0_SSQA_EMIR_Station` : fonctions atomiques sur les stations
- `3.3.0_SSQA_EMIR_Mesure` : fonctions atomiques sur les mesures
- `3.4.0_SSQA_EMIR_Variable` : fonctions atomiques sur les variables
- `3.5.0_utils` : fonctions utilitaires (IQA, etc)
