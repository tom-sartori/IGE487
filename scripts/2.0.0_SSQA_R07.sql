set schema 'SSQA';

alter table Station add column mobile boolean not null;

create table Station_nom (
    code Station_Code not null,
    nom Station_Nom not null,
    constraint Station_nom_cc0 primary key (code),
    foreign key (code) references Station(code)
    constraint Station_nom_cc1 check (nom is not null where idStation=Station.idStation and Station.mobile=true) 
);

create table Position (
    station Station_Code not null,
    latitude Latitude not null,
    longitude Longitude not null,
    debut Estampille not null,
    fin Estampille not null,
    constraint Position_cc0 primary key (station, debut),
    foreign key (station) references Station(code)
    constraint Position_cc1 check (fin > debut)
    constraint Position_cc2 check (latitude is not null and longitude is not null)
    constraint Position_cc3 check ((Select count(*) from Position where station=Position.station and fin is null)=1)
    
);

create table Immatriculation (
    station Station_Code not null,
    immatriculation varchar(50) not null,
    constraint immatriculation_cc0 primary key (station),
    foreign key (station) references Station(code)
);

alter table Station drop column latitude;
alter table Station drop column longitude;
alter table Station drop column nom;

