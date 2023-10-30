# Réunion 5 (07/10/2023)

## Présents
- [x] Alexandre
- [x] Tom
- [x] Raphaël
- [x] LV

## Ordre du jour
- Mise en commun des réflexions sur les signatures des fonctions à implémenter

### Mise en commun des réflexions sur les signatures des fonctions à implémenter
Raph a détaillées les 5 requêtes du sujet, Theisse a commencé à réflechir aux besoins.
Nous allons donc commencer par implémenter les fonctions atomiques et des fonctions utilitaires (IQA, etc)
et enfin les requêtes complexes à partir de celles-ci.

Les fonction seront réparties dans des fichiers de la manière suivante :
- `3.1.0_SSQA_EMIR_Territoire` : fonctions atomiques sur les territoires
- `3.2.0_SSQA_EMIR_Station` : fonctions atomiques sur les stations
- `3.3.0_SSQA_EMIR_Mesure` : fonctions atomiques sur les mesures
- `3.4.0_SSQA_EMIR_Variable` : fonctions atomiques sur les variables
- `3.5.0_utils` : fonctions utilitaires (IQA, etc)

Les test seront répartis dans des fichiers de la manière suivante (s'il y a lieu) :
- `3.1.1_test-val` : tests valides sur les fonctions atomiques sur les territoires
- `3.2.1_test-val` : tests valides sur les fonctions atomiques sur les stations
- `3.3.1_test-val` : tests valides sur les fonctions atomiques sur les mesures
- `3.4.1_test-val` : tests valides sur les fonctions atomiques sur les variables
- `3.5.1_test-val` : tests valides sur les fonctions utilitaires (IQA, etc)

- `3.1.2_test-inv` : tests invalides sur les fonctions atomiques sur les territoires
- `3.2.2_test-inv` : tests invalides sur les fonctions atomiques sur les stations
- `3.3.2_test-inv` : tests invalides sur les fonctions atomiques sur les mesures
- `3.4.2_test-inv` : tests invalides sur les fonctions atomiques sur les variables
- `3.5.2_test-inv` : tests invalides sur les fonctions utilitaires (IQA, etc)

### Prochaine réunion
Mardi 10/10/2023 à 15h20.

## TODO

| Qui ?                    | Quoi ?                                                                                | Pour quand ?           |
| -                        | -                                                                                     | -                      |
| LV                       | Tests                                                                                 | 10/10/2023             |
| LV                       | Rédiger le SEM J1                                                                     | 10/10/2023             |
| Tom                      | Rédiger les fonctions ÉMIR                                                            | 10/10/2023             |
| Theisse                  | Rédiger le SEM J2                                                                     | 12/10/2023             |
| Raphael                  | Rédiger les requêtes plus complexes attendues pour le J2 (une fois les fonctions atomiques rédigées par Tom)                     | 12/10/2023             |
| Raphael                  | Création les fonctions utilitaires utiles (IQA, etc)                                  | 10/10/2023             |