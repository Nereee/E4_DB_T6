
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



#Podcast_Izena eta Podcaster kontsultarako ikuspegia sortu da
CREATE VIEW Podcast_Podcaster_View AS
SELECT 
    Podcast.Izena AS Podcast_Izena, 
    Podcasterra.IzenArtistikoa AS Podcaster
FROM 
    Podcast
JOIN 
    Podcasterra ON Podcast.IDPodcaster = Podcasterra.IDPodcaster;




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


    