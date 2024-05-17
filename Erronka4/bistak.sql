
#Albumak hartu eta haien artistak
create view AlbumOsoa as
SELECT
   Album.Izenburua AS Album_Izena,
   musikaria.IzenArtistikoa AS Artista
FROM
    Album
INNER JOIN
    musikaria ON Album.IDmusikaria = musikaria.IDmusikaria;
    
    

#Playlist_Izena eta Audio_Izena kontsultarako ikuspegia sortu da
CREATE VIEW Playlist_Audio_View AS
SELECT 
    Playlist.Izenburua AS Playlist_Izena, 
    Audioa.Izena AS Audio_Izena
FROM 
    Playlist
JOIN 
    PLaylist_Abestiak ON Playlist.IDList = PLaylist_Abestiak.IDList
JOIN 
    Audioa ON PLaylist_Abestiak.IDAudio = Audioa.IDAudio
JOIN 
    Abestia ON Audioa.IDAudio = Abestia.IDAudio;
    


#Audio_Izena eta Erreprodukzioak kontsultarako ikuspegia sortu da
CREATE VIEW Audio_Reproducciones_View AS
SELECT 
    Audioa.Izena AS Audio_Izena, 
    COUNT(Erreprodukzioak.codigo) AS Reproducciones
FROM 
    Audioa
LEFT JOIN 
    Erreprodukzioak ON Audioa.IDAudio = Erreprodukzioak.IDAudio
GROUP BY 
    Audioa.Izena;



#Premium bezeroak egindako erreprodukzioak askenengo 30 egunetan kontsultarako ikuspegia sortu da.
CREATE VIEW Premium_Erreprodukzioak_View AS
SELECT DISTINCT 
    bezeroa.IDBezeroa, 
    bezeroa.Izena, 
    bezeroa.Abizena
FROM 
    bezeroa
JOIN 
    Premium ON bezeroa.IDBezeroa = Premium.IDBezeroa
JOIN 
    Erreprodukzioak ON bezeroa.IDBezeroa = Erreprodukzioak.IDBezeroa
WHERE 
    Premium.Iraungitze_data >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);




#Musikari guztien izena eta deskripzioa kontsultarako ikuspegia sortu da
CREATE VIEW Musikaria_View AS
SELECT 
    IzenArtistikoa AS Artista, 
    Deskribapena AS Descripcion
FROM 
    musikaria;

#Programarako beharrezko bistak
create view abestiDiskak as

select IDAudio, Izena, IDAlbum, Izenburua, Iraupena
from audioa join abestia using (IDAudio) join album using (IDAlbum); 

create view albumDeskribapena as 

select Eguna, Generoa, count(IDAudio)as Audioa, SEC_TO_TIME( SUM(time_to_sec(Iraupena)))as Iraupena, IDAlbum, Izenburua
from audioa join abestia using (IDAudio) join album using (IDAlbum) group by Eguna, Generoa, IDAlbum, Izenburua;

    