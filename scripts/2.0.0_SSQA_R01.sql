set schema 'SSQA';
--Ajout attribut dans la table unite
alter table unite add column mult integer ;
alter table unite add column adds integer ;

create table Unite_fond (
    symbole integer not null,
    nom varchar(50) not null,
    constraint Unite_fond_cc0 primary key (symbole)
);

create table Composite_unite (
    symbole_unite_composite integer not null,
    symbole_unite_fond integer not null,
    exposant integer not null,
    constraint Composite_unite_cc0 primary key (symbole_unite_composite, symbole_unite_fond),
    foreign key (symbole_unite_composite) references unite(symbole),
    foreign key (symbole_unite_fond) references unite_fond(symbole)
);
