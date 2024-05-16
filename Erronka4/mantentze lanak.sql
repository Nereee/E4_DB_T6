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







