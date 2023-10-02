set schema 'SSQA';

-- Vide la table car les anciennes données ne sont plus valides
drop table if exists Variable cascade;

-- Changement de type de la colonne méthode dans la table variable
create table Variable (
  code Variable_Code not null,
  nom Variable_nom not null,
  unite Unite_Symbole not null,
  valref Mesure_valeur not null,
  methode Integer not null,
  constraint Variable_cc0 primary key (code),
  constraint Variable_cc1 unique (nom),
  constraint Variable_cr0 foreign key (unite) references Unite(sym)
  );
