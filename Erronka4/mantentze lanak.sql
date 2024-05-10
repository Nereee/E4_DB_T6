use db_spoty;
-- *********************************INDIZEAK****************************

-- musikaria
create index idx_IzenArtistikoa on musikaria(IzenArtistikoa); -- izen artiskikoaren arabera bilatzeko
select * from musikaria where IzenArtistikoa = 'Estopa';

-- podcasterra
create index idx_IzenArtistikoa_podcaster on Podcasterra(IzenArtistikoa); -- izen artiskikoaren arabera bilatzeko
select * from Podcasterra where IzenArtistikoa = 'Jordi Wild';

-- bezeroa
create index idx_Erabiltzailea on bezeroa(Erabiltzailea); -- Erabiltzaileen izenen bitartez bezeroak bilatzeko
create index idx_Hizkuntza on bezeroa(Hizkuntza); -- Bezeroen hizkuntza filtroak egiteko
select * from bezeroa where Erabiltzailea = 'Mentxaka';
select * from bezeroa where Hizkuntza = 'ES';

-- album
create index idx_IDMusikaria on Album(IDMusikaria); -- Musikari baten albumak bilatzeko
select * from Album where IDMusikaria = 1;

-- playlist 
create index idx_IDBezeroa on Playlist(IDBezeroa); -- Bezero baten playlistak bilatzeko
select * from Playlist where IDBezeroa = 3;

-- *****************************PROZEDURAK ETA FUNTZIOAK*****************************

-- Erabiltzaileak gehitzeko
DELIMITER //

create procedure InsertBezeroa(
    in p_Izena varchar(30),
    in p_Abizena varchar(30),
    in p_Hizkuntza enum('ES', 'EU', 'EN', 'FR', 'DE', 'CA', 'GA', 'AR'),
    in p_Erabiltzailea varchar(30),
    in p_Pasahitza varchar(40),
    in p_Jaiotze_data date,
    in p_mota enum('Free', 'Premium')
)
begin
    insert into bezeroa (Izena, Abizena, Hizkuntza, Erabiltzailea, Pasahitza, Jaiotze_data, Erregistro_data, mota)
    values (p_Izena, p_Abizena, p_Hizkuntza, p_Erabiltzailea, p_Pasahitza, p_Jaiotze_data, NOW(), p_mota);
end //

DELIMITER ;

-- KONPROBAKETA
call InsertBezeroa('Jose', 'Francisco', 'EN', 'eljose', '123', '1983-01-01', 'Free');
-- KONPROBAKETA

-- Erabiltzaileak ezabatzeko 
DELIMITER //

create procedure deletebezeroa(
    in p_idbezeroa int
)
begin
    declare v_num_bez int;
    
    -- erabiltzailea aurkitu daitekeen adierazteko aldagaia
    declare aurkitua boolean default false;
    
    -- ez aurkitutako erregistroa kudeatzeko kudeatzailea
    declare continue handler for not found set aurkitua = true;
    
    -- erabiltzailea badago egiaztatu
    select count(*) into v_num_bez
    from bezeroa
    where idbezeroa = p_idbezeroa;
    
    -- erabiltzailea aurkitzen badago, ezabaketarekin jarraitu
    if not aurkitua then
        delete from bezeroa
        where idbezeroa = p_idbezeroa;
        select concat(p_idbezeroa, '. bezeroa ezabatu egin da') as emaitza;
    else
        select 'ez da bezeroa aurkitu' as emaitza;
    end if;
end //

DELIMITER ;

-- KONPROBAKETA
call DeleteBezeroa(6); -- Ezabatu nahi duzun erabuiltzailearen ID-a erabili
-- KONPROBAKETA

-- Adina kalkulatzeko
DELIMITER //

create function KalkulatuAdina(
    p_jaiotze_data date
)
returns int
begin
    declare adina int;
    set adina = year(now()) - year(p_jaiotze_data);
    if month(now()) < month(p_jaiotze_data) or (month(now()) = month(p_jaiotze_data) and day(now()) < day(p_jaiotze_data)) then
        set adina = adina - 1;
    end if;
    return adina;
end //

DELIMITER ;

-- KONPROBAKETA
select KalkulatuAdina('1990-01-01') as adina;
-- KONPROBAKETA

-- ********************************TRIGER ETA GERTAERAK********************************

DELIMITER // 

create trigger delete_album_abestiak
before delete on Album
for each row
begin
    delete from Abestia where IDAlbum = old.IDAlbum;
end //

DELIMITER ;

-- KONPROBAKETA
#delete from Album where IDAlbum = 2;
select au.Izena as Abestia, m.IzenArtistikoa as Artista
from Audioa au
join Abestia ab on au.IDAudio = ab.IDAudio
join Album al on ab.IDAlbum = al.IDAlbum
join musikaria m on al.IDMusikaria = m.IDMusikaria
where m.IDMusikaria = 2;
-- KONPROBAKETA

DELIMITER // 

create trigger delete_artista_albumak_abestiak
before delete on musikaria
for each row
begin
    -- Artistak dituen albumak ezabatzeko
    delete from Album where IDMusikaria = old.IDMusikaria;

    -- Albumak dituen abestiak ezabatzeko
    delete from Abestia where IDAlbum in (select IDAlbum from Album where IDMusikaria = old.IDMusikaria);
end //

DELIMITER ;

-- KONPROBAKETA
#delete from musikaria where IDMusikaria = 4;
select * from Album where IDMusikaria = 4;

select au.Izena as Abestia, m.IzenArtistikoa as Artista
from Audioa au
join Abestia ab on au.IDAudio = ab.IDAudio
join Album al on ab.IDAlbum = al.IDAlbum
join musikaria m on al.IDMusikaria = m.IDMusikaria
where m.IDMusikaria = 4;
-- KONPROBAKETA

DELIMITER //
create trigger update_top_gustoko_abesti
after insert on Gustukoak
for each row
begin
    update Estatistikak
    set TopGustokoAbesti = (select group_concat(distinct au.Izena separator ', ')
        from Audioa au
        join Gustukoak gu on au.IDAudio = gu.IDAudio
        where au.Mota = 'Abestia'
        group by gu.IDBezeroa
        order by COUNT(*) desc
        limit 5
    );
end //
DELIMITER ;


DELIMITER //
create trigger update_top_gustuko_podcast
after insert on Gustukoak
for each row
begin
    update Estatistikak
    set TopGustukoPodcast = (
        select Izena
        from Audioa
        where Mota = 'Podcast'
        group by IDAudio
        order by count(*) desc
        limit 5
    );
end //
DELIMITER ;

DELIMITER //
create trigger update_top_entzundakoak
after insert on Erreprodukzioak
for each row
begin
    update Estatistikak
    set TopEntzundakoak = (
        select Izena
        from Audioa
        where IDAudio = new.IDAudio
    );
end //
DELIMITER ;

DELIMITER //
create trigger update_top_playlist
after insert on PLaylist_Abestiak
for each row
begin
    update Estatistikak
    set TopPlaylist = (
        select Izenburua
        from Playlist
        where IDList = new.IDList
    );
end //
DELIMITER ;



DELIMITER // 

create event update_premium_bezeroak
on schedule every 1 day
do
begin
    declare uneko_data date;
    declare erabiltzaile_id int;
    
    -- Uneko data lortu
    set uneko_data = curdate();
    
    -- Lortu premium bezeroa iraungituta duten erabiltzaileen id-a
    select idbezeroa into erabiltzaile_id
    from premium
    where iraungitze_data <= uneko_data;
    
    -- Free kontua bihurtu erabiltzaileei kontua iraungitua denean
    if erabiltzaile_id is not null then
        update bezeroa
        set mota = 'free'
        where idbezeroa = erabiltzaile_id;
        
        -- Ezabatu premium datuak erabiltzaile horretarako
        delete from premium
        where idbezeroa = erabiltzaile_id;
        
    end if;
end;

DELIMITER ;

-- KONPROBAKETA
update Premium
set Iraungitze_data = '2023-03-03'
where IDBezeroa = (
    select IDBezeroa
    from bezeroa
    where Erabiltzailea = 'Mentxaka'
);

select b.IDBezeroa, b.Izena, b.Abizena, b.Hizkuntza, b.Erabiltzailea, b.Pasahitza, b.Jaiotze_data, b.Erregistro_data, b.mota, p.Iraungitze_data
from bezeroa b
join Premium p on b.IDBezeroa = p.IDBezeroa;
-- KONPROBAKETA












