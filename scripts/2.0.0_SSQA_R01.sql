set schema 'SSQA';
--Ajout attribut dans la table unite
alter table unite add column mult double precision  ;
alter table unite add column adds double precision  ;

alter table unite add constraint unite_cr1 check (mult is not null or adds is not null);

create table Unite_fond (
    symbole Unite_Symbole not null,
    nom Unite_Nom not null,
    constraint Unite_fond_cc0 primary key (symbole)
);

create table Composition_unite (
    symbole_unite_composite integer not null,
    symbole_unite_fond integer not null,
    exposant integer not null,
    constraint Composite_unite_cc0 primary key (symbole_unite_composite, symbole_unite_fond),
    foreign key (symbole_unite_composite) references unite(symbole),
    foreign key (symbole_unite_fond) references unite_fond(symbole)

);
