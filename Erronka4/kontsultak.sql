-- Kontsultak


-- Albumak hartu eta haien artistak
SELECT Album.Izenburua AS Album_Izena, musikaria.IzenArtistikoa AS Artista
FROM Album
JOIN musikaria ON Album.IDMusikaria = musikaria.IDMusikaria;


-- Bezeroen playlist-ak eta haien audioak atera (Podcast-ak ezin dira playlist-etan gorde)
SELECT Playlist.Izenburua AS Playlist_Izena, Audioa.Izena AS Audio_Izena
FROM Playlist
JOIN PLaylist_Abestiak ON Playlist.IDList = PLaylist_Abestiak.IDList
JOIN Audioa ON PLaylist_Abestiak.IDAudio = Audioa.IDAudio
JOIN Abestia ON Audioa.IDAudio = Abestia.IDAudio
WHERE Playlist.IDBezeroa = 'ID_USUARIO';



-- Audio bakoitzaren erreprodukzioak hartu (podcast-ak kontuan izanda)
SELECT Audioa.Izena AS Audio_Izena, COUNT(Erreprodukzioak.codigo) AS Reproducciones
FROM Audioa
LEFT JOIN Erreprodukzioak ON Audioa.IDAudio = Erreprodukzioak.IDAudio
GROUP BY Audioa.Izena;



-- Podcast-en izenak atera eta haien podcasterrak
SELECT Podcast.Izena AS Podcast_Izena, Podcasterra.IzenArtistikoa AS Podcaster
FROM Podcast
JOIN Podcasterra ON Podcast.IDPodcaster = Podcasterra.IDPodcaster;


-- Premium bezeroak egindako erreprodukzioak askenengo 30 egunetan
SELECT DISTINCT bezeroa.IDBezeroa, bezeroa.Izena, bezeroa.Abizena
FROM bezeroa
JOIN Premium ON bezeroa.IDBezeroa = Premium.IDBezeroa
JOIN Erreprodukzioak ON bezeroa.IDBezeroa = Erreprodukzioak.IDBezeroa
WHERE Premium.Iraungitze_data >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);


-- musikari guztien izena eta deskripzioa atera
SELECT IzenArtistikoa AS Artista, Deskribapena AS Descripcion
FROM musikaria;

-- Playlist guztien sorrera data
SELECT Izenburua AS Lista_Reproduccion, Sorrera_data AS Fecha_Creacion
FROM Playlist;

-- Premium erabiltzaileen izenak eta suskripzioaren amaiera
SELECT bezeroa.Izena AS Nombre, bezeroa.Abizena AS Apellido, Premium.Iraungitze_data AS Fecha_Expiracion
FROM bezeroa
JOIN Premium ON bezeroa.IDBezeroa = Premium.IDBezeroa;


-- Album guztien tituluak eta haien genero musikala
SELECT Izenbura AS Titulo_Album, Generoa AS Genero
FROM Album;


-- erabiltzaile guztien jaiotza data
SELECT Izena AS Nombre, Jaiotze_data AS Fecha_Nacimiento
FROM bezeroa;


-- podcast guztien izena eta deskripzioa atera

SELECT IzenArtistikoa AS Podcast, Deskribapena AS Descripcion
FROM Podcasterra;

-- bezeroaren izena eta sortutako playlist guztiak

SELECT bezeroa.Izena AS Nombre_Usuario, Playlist.Sorrera_data AS Fecha_Creacion
FROM bezeroa
JOIN Playlist ON bezeroa.IDBezeroa = Playlist.IDBezeroa;


-- erreproduzkio serrendaren titulua eta barruan daukan abesti zenbakia
SELECT Playlist.Izenburua AS Nombre_Lista, COUNT(PLaylist_Abestiak.IDAudio) AS Total_Canciones
FROM Playlist
LEFT JOIN PLaylist_Abestiak ON Playlist.IDList = PLaylist_Abestiak.IDList
GROUP BY Playlist.IDList;


-- berdina baina abestiak ateratzen
SELECT 
    Playlist.Izenburua AS Nombre_Lista,
    GROUP_CONCAT(Audioa.Izena SEPARATOR ', ') AS Canciones,
    COUNT(PLaylist_Abestiak.IDAudio) AS Total_Canciones
FROM 
    Playlist
LEFT JOIN 
    PLaylist_Abestiak ON Playlist.IDList = PLaylist_Abestiak.IDList
LEFT JOIN 
    Audioa ON PLaylist_Abestiak.IDAudio = Audioa.IDAudio
GROUP BY 
    Playlist.IDList;



