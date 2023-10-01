set schema 'SSQA';

/*
Tentative d’insertion des données invalides à des fins de tests unitaires pour les tables
du schéma SSQA (système de surveillance de la qualité de l’air). Toutes les insertions
doivent entraîner une échec.

On suppose que les données valides du fichier SSQA_ins-val.sql correspondant ont été insérées
au préalable.
*/

-- Unite
-- symbole trop long
  insert into Unite (sym, nom, mult, add) values
    ('symbole vraiment trop long pour être pratique', 'peu importe', 1, 0);
-- symbole null
    insert into Unite (sym, nom, mult, add) values
        (null, 'peu importe', 1, 0);
-- nom null
    insert into Unite (sym, nom, mult, add) values
        ('sym', null, 1, 0);
-- mult null
    insert into Unite (sym, nom, mult, add) values
        ('sym', 'peu importe', null, 0);
-- add null
    insert into Unite (sym, nom, mult, add) values
        ('sym', 'peu importe', 1, null);
-- mult négatif
    insert into Unite (sym, nom, mult, add) values
        ('sym', 'peu importe', -1, 0);
-- add négatif
    insert into Unite (sym, nom, mult, add) values
        ('sym', 'peu importe', 1, -1);
-- conflit de clé primaire
    insert into Unite (sym, nom, mult, add) values
        ('s', 'peu importe', 1, 0);
