drop database if exists db_spoty;
create database db_spoty
collate utf8mb4_general_ci;

use db_spoty;

create table musikaria(
	IDMusikaria int auto_increment not null primary key,
	IzenArtistikoa varchar(50) not null unique,
    MusikIrudia BLOB,
    Ezaugarria enum('bakarlaria', 'taldea') not null,
    Deskribapena varchar (500)
);


create table Podcasterra(
	IDPodcaster int auto_increment not null primary key,
    IzenArtistikoa varchar(50) not null unique,
    PodIrudia BLOB,
    Deskribapena varchar (100)
); 


create table Hizkuntza(
	IDHizkuntza enum('ES', 'EU', 'EN', 'FR', 'DE', 'CA', 'AR') primary key,
    Deskribapena varchar(100) not null
);


create table bezeroa(
	IDBezeroa int auto_increment not null primary key,
    Izena varchar(30) not null,
    Abizena varchar(30) not null,
    Hizkuntza enum('ES', 'EU', 'EN', 'FR', 'DE', 'CA', 'GA', 'AR'),
    Erabiltzailea varchar(30) not null unique,
    Pasahitza varchar(40) not null,
    Jaiotze_data date not null,
    Erregistro_data date not null,
    mota enum('Free', 'Premium') not null,
    foreign key (Hizkuntza) references  Hizkuntza (IDHizkuntza) on update cascade on delete set null
);

	

create table Premium(
	IDBezeroa int not null,
    Iraungitze_data date not null,
    primary key (IDBezeroa),
    foreign key (IDBezeroa) references  bezeroa (IDBezeroa) on delete cascade on update cascade
);

create table Album(
	IDAlbum int auto_increment not null primary key,
    Izenburua varchar(50) not null,
    Eguna date not null,
    Generoa varchar(25),
	IDMusikaria int not null,
    foreign key (IDMusikaria) references  musikaria (IDMusikaria) ON UPDATE CASCADE ON DELETE CASCADE
);

create table Audioa(
	IDAudio int auto_increment not null primary key,
    Izena varchar(100) not null,
    Iraupena time,
    AudioIrudia BLOB,
    Mota enum('Podcast','Abestia') not null
);

create table Podcast(
	IDAudio int not null,
    Kolaboratzaileak varchar(100),
    IDPodcaster int not null,
    primary key (IDAudio),
    foreign key (IDPodcaster) references Podcasterra (IDPodcaster) on delete cascade on update cascade, 
    foreign key (IDAudio) references  Audioa (IDAudio) on delete cascade on update cascade
);

create table Abestia(
	IDAudio int not null,
    IDAlbum int not null,
    primary key (IDAudio),
    foreign key (IDAlbum) references  Album (IDAlbum) on update cascade on delete cascade,
    foreign key (IDAudio) references  Audioa (IDAudio) on update cascade on delete cascade
);


create table Playlist(
	IDList int auto_increment not null primary key,
    Izenburua varchar(20) not null,
    Sorrera_data date not null,
    IDBezeroa int not null,
    foreign key (IDBezeroa) references  bezeroa (IDBezeroa) on update cascade on delete cascade
);

create table PLaylist_Abestiak(
	IDList int not null,
    IDAudio int not null,
    primary key (IDList, IDAudio),
    foreign key (IDList) references  Playlist (IDList) on update cascade on delete cascade,
    foreign key (IDAudio) references  Abestia (IDAudio) on update cascade on delete cascade
);

create table Gustukoak(
	IDBezeroa int not null,
    IDAudio int not null,
    primary key (IDBezeroa, IDAudio),
    foreign key (IDBezeroa) references  bezeroa (IDBezeroa) on delete cascade on update cascade,
    foreign key (IDAudio) references  Audioa (IDAudio) on delete cascade on update cascade
);

create table Erreprodukzioak(
	codigo INT PRIMARY KEY auto_increment,
	IDBezeroa int,
    IDAudio int,
    ErreData date not null,
    foreign key (IDBezeroa) references  bezeroa (IDBezeroa) on update cascade on delete set null,
    foreign key (IDAudio) references  Audioa (IDAudio) on update cascade on delete set null
);

create table Estatistikak(
	IDAudio int auto_increment not null primary key,
    foreign key (IDAudio) references  Audioa (IDAudio),
    TopGustokoAbesti varchar(100) not null,
    TopGustukoPodcast varchar(100) not null,
    TopEntzundakoak varchar(100) not null,
    TopPlaylist varchar (100) not null
);





