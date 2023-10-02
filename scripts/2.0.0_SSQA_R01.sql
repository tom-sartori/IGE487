set schema 'SSQA';

-- Empty table since we can't use old data
drop table if exists Unite cascade;

create table Unite (
    sym Unite_Symbole not null,
    nom Unite_Nom not null unique,
    mult double precision not null,
    add double precision not null,
    constraint Unite_cc0 primary key (sym),
    constraint Unite_mult_positif check (mult >= 0)
);

create table Unite_fond (
    symbole Unite_Symbole not null,
    nom Unite_Nom not null unique,
    constraint Unite_fond_cc0 primary key (symbole)
);

create table Composition_unite (
    symbole_unite_composite Unite_Symbole not null,
    symbole_unite_fondamentale Unite_Symbole not null,
    exposant integer not null,
    constraint Composition_unite_cc0 primary key (symbole_unite_composite, symbole_unite_fondamentale),
    constraint Composition_unite_cr0 foreign key (symbole_unite_composite) references Unite (sym),
    constraint Composition_unite_cr1 foreign key (symbole_unite_fondamentale) references Unite_fond (symbole)
);