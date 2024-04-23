
INSERT INTO Hizkuntza (IDHizkuntza, Deskribapena) VALUES
('ES', 'Español'),
('EN', 'English'),
('FR', 'Frances'),
('DE', 'Aleman'),
('CA', 'Catalàn'),
('AR', 'Àrabe');

INSERT INTO musikaria (IzenArtistikoa, MusikIrudia, Ezaugarria, Deskribapena) VALUES
('Bad Bunny',  '  ' , 'bakarlaria', 'Benito Antonio Martínez Ocasio, artistikoki Bad Bunny bezala ezaguna, puertorricar abeslari, konpositore, musika-ekoizle eta borrokalari zalea da'),
('Estopa',  ' ','Taldea' , 'Estopa David eta José Manuel Muñoz anaiek osatutako espainiar rumba bikote katalana da. 1999ko urriaren 18an sortua, taldea Cornellà de Llobregat hirikoa da, Bartzelonako probintzian'),
('Lagrimas de sangre', ' ',  'Taldea', 'Lágrimas de Sangre 2006an Masnoun eta Bartzelonan sortutako rap talde borrokalaria da. Gaur egun, Neidos, Still Ill eta Microbio daude mikrofonoan, Acid Lemon DJ eta ekoizle gisa eta Ramón Anglada gitarran. Bere estiloa rap, hip-hop, rock eta reggae estiloetatik edaten du.'),
('Fito y Fitipaldis', ' ', 'Taldea', 'Fito & Fitipaldis es un grupo musical español de rock and roll creado en 1997, por Fito Cabrales, de Platero y Tú.  Inicialmente surgió como un proyecto paralelo que Cabrales decidió continuar tras la disolución de su anterior banda.');

INSERT INTO Podcasterra (IzenArtistikoa, PodIrudia, Deskribapena) VALUES 
('Joe Rogan', ' ', 'Munduko podcaster oberena'),
('Jordi Wild', ' ', 'Hemengo Podcaster ezagunena'),
('Marikarmen', ' ', 'Hasi berria den podkast bat');
INSERT INTO bezeroa (Izena, Abizena, Hizkuntza, Erabiltzailea, Pasahitza, Jaiotze_data, Erregistro_data, mota) VALUES
('Yorch', 'Charles', 'EN', 'charly', 'password123', '1990-01-01', '2024-04-19', 'Free'),
('Aitor', 'Mentxaka', 'ES', 'Mentxaka', 'pasahitza123', '1999-01-01', '2024-04-20', 'Premium'),
('Peru', 'Jauregi', 'ES', 'PeruJ', 'pasahitza123', '2000-01-01', '2024-04-21', 'Free'),
('Andoni', 'Salsidua', 'ES', 'Salsidu', 'pasahitza123', '2002-01-01', '2024-04-22', 'Premium');

INSERT INTO Premium (IDBezeroa, Iraungitze_data) VALUES
(2, '2025-04-19'),
(4, '2025-04-20');

INSERT INTO Album (Izenburua, Eguna, Generoa, IDMusikaria) VALUES
('Viridarquía', '2014-04-19','pop', 1),
('Un verano sin ti', '2018-05-02','rock', 2),
('Rumba a lo desconocido', '2020-07-2','rap', 3),
('Lo mas lejos a tu lado', '2010-08-03','electro', '4');

INSERT INTO Audioa (Izena, Iraupena, AudioIrudia, Mota) VALUES
#LagrimasDeSangre Abestiak
('Viridarquia', '00:04:44', NULL, 'Abestia'),
('Buen viaje', '00:04:20', NULL, 'Abestia'),
('Quemar el mar', '00:05:01', NULL, 'Abestia'),
#BadBunny Abestiak
('La Noche de Anoche (feat. Rosalía)', '00:03:25', NULL, 'Abestia'),
('DAKITI', '00:03:25', NULL, 'Abestia'),
('Hoy Cobré', '00:02:51', NULL, 'Abestia'),
#Estopa Abestiak
('Pastillas Para Dormir', '00:03:25', NULL, 'Abestia'),
('Tu calorro', '00:03:45', NULL, 'Abestia'),
('Como camaron', '00:03:51', NULL, 'Abestia'),
#FitoFitipaldis abestiak
('Por la Boca Vive el Pez', '00:04:06', NULL, 'Abestia'),
('Me Equivocaría Otra Vez', '00:04:26', NULL, 'Abestia'),
('Soldadito Marinero', '00:03:28', NULL, 'Abestia'),
#The Wild Project podcast
('En las profundidades del Bosque', '00:45:00', NULL, 'Podcast'),
('Conexiones Naturales: Entendiendo los Ecosistemas', '00:30:00', NULL, 'Podcast'),
('Guardianes del Hábitat: Conservación y Sostenibilidad', '01:00:00', NULL, 'Podcast'),
#Marikarmen Podcast
('The Joe Rogan Experience', '02:00:00', NULL, 'Podcast'),
('RadioLab - Episodio : Colors', '01:00:00', NULL, 'Podcast'),
('This American Life', '00:30:00', NULL, 'Podcast'),
#Joe_rogan Podcast
('Graham Hancock and Flint Dibble', '04:26:26', NULL, 'Podcast'),
('Neal Brennam', '00:04:32', NULL, 'Podcast');


INSERT INTO Podcast (IDAudio, Kolaboratzaileak, IDPodcaster) VALUES
(13, NULL, 3),
(14, 'Mari ', 2),
(15, 'Juan Magan', 2),
(16, 'Elon Musk', 1),
(17, 'Radio lab', 1),
(18, 'Americano promedio', 1),
(19, 'Graham Hancock', 3),
(20, 'Flint Dibble', 3);

INSERT INTO Abestia (IDAudio, IDAlbum) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(6, 2),
(7, 3),
(8, 3),
(9,3),
(10, 4),
(11, 4),
(12, 4);

INSERT INTO Playlist (Izenburua, Sorrera_data, IDBezeroa) VALUES
('Kotxerako musika', '2024-04-19', 1),
('Erretxeko musika', '2023-04-06', 2),
('Txirrindula', '2024-01-03', 3),
('Basket', '2023-09-09', 4);

INSERT INTO PLaylist_Abestiak (IDList, IDAudio) VALUES
(1, 1),
(1, 4),
(1, 6),
(1, 8),
(2, 1),
(2,4),
(2,6),
(2,9),
(3,7),
(3,8),
(3,2),
(3,12),
(4,12),
(4,7),
(4,6),
(4,2),
(4,1);

INSERT INTO Gustukoak (IDBezeroa, IDAudio) VALUES
(1, 1),
(1, 6),
(2,4),
(2,6),
(3,7),
(3,8),
(4,12),
(4,2),
(4,1);

INSERT INTO Erreprodukzioak (IDBezeroa, IDAudio, ErreData) VALUES
(1, 1, '2024-04-19'),
(2, 4, '2024-04-19'),
(3, 5, '2024-04-19'),
(4, 8, '2024-04-19'),
(1, 12, '2024-04-19'),
(2, 18, '2024-04-19'),
(3, 17, '2024-04-19'),
(4, 16, '2024-04-19'),
(1, 3, '2024-04-19'),
(2, 5, '2024-04-19'),
(3, 5, '2024-04-19'),
(4, 5, '2024-04-19'),
(1, 3, '2024-04-19'),
(2, 8, '2024-04-19'),
(3, 11, '2024-04-19'),
(4, 12, '2024-04-19');

INSERT INTO Estatistikak (IDAudio, TopGustokoAbesti, TopGustukoPodcast, TopEntzundakoak, TopPlaylist) VALUES
(1, 'Top Abestia', 'Top Podcast', 'Top Entzundakoak', 'Top Playlist');




