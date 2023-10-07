# Réunion 4 (04/10/2023)

## Présents
- [x] Alexandre
- [x] Tom
- [x] Raphaël
- [x] LV

## Ordre du jour
- Mise à jour des documents du Jalon 1
- Corrections BD
- Choix de technologie pour l'API

### Mise à jour des documents du Jalon 1
- Rapport : tout à faire
- SEM : revoir les exigences
- SCBD : préciser les options et celle qu'on a choisie

### Corrections BD
- Ajouter les clés référentielles vers Unité pour Exigence et Variable
- Enum méthodes de codif faire une table
- Changer la contrainte sur mult et régler le problème d'arrondi (mettre decimal plutôt que double precision ?)
- Renommer les types de mult et add et mobilite et exposant

### Choix de technologie pour l'API
Aucune, on fera tout en SQL et on rendra publiques les fonctions haut-niveau utiles à l'utilisateur.

### Prochaine réunion
Samedi 07/10/2023 à 11h.

## TODO

| Qui ?                    | Quoi ?                                                                        | Pour quand ?           |
| -                        | -                                                                             | -                      |
| LV                       | Rapport J1                                                                    | 07/10/2023             |
| LV                       | SEM J1                                                                        | 07/10/2023             |
| LV                       | SCBD J1                                                                       | 07/10/2023             |
| LV                       | Modifications de la BD                                                        | 07/10/2023             |
| Alexandre                | SEM J2                                                                        | 07/10/2023             |
| Tout le monde            | Réfléchir aux signatures des fonctions à implémenter (pour SCBD)              | 07/10/2023             |