set schema 'SSQA';

alter table Seuils rename to Validation;

-- Renommage des contraintes

alter table Validation drop constraint Seuils_cc0;
alter table Validation drop constraint Seuils_cr0;
alter table Validation drop constraint Seuils_cr1;
alter table Validation drop constraint Seuils_min_max;

alter table Validation add constraint Validation_cc0 primary key (variable, norme);
alter table Validation add constraint Validation_cr0 foreign key (variable) references Variable(code);
alter table Validation add constraint Validation_cr1 foreign key (norme) references Norme(code);
alter table Validation add constraint Validation_min_max check (min <= max);