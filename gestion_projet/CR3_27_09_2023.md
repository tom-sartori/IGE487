# Réunion 3 (27/09/2023)

## Présents
- [x] Alexandre
- [x] Tom
- [x] Raphaël
- [x] LV

## Sujets abordés

### Passage V1 à V2
En fait, le schéma de la V1 était considéré comme juste. Il faut donc juste faire les modifications pour la V2.

### Réponses aux question de la dernière fois
#### Taille des champs
- Augmentation de la taille max de "station_nom" (63 => 512). Vu avec client, car peut être une concaténation de lieux-dits, où la station se trouve. Idem pour "territoire_nom".
- Pour les autres types ".*_nom", mentionner clairement dans l'EPP la taille min et max.

#### Mesures invalides
La raison de l'invalidité de la mesure étant inconnues, on va remplacer l'attribut "valide" par un attribut "erreur" qui est un code qui décrit l'erreur correspondante.

#### Contenu de la BD
- table hors-services : OUI
- agents entretien : NON

### Schéma de la V2
Nous avons fini le schéma de la V2, il reste à le normaliser et à l'implémenter.