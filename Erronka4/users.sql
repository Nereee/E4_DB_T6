use db_spoty;
create user
DB_administratzailea identified by 'admin1234';


create user 
Dep_burua identified by 'dep_burua1234';

create user 
Analista1 identified by 'Analista1';

create user 
Analista2 identified by 'Analista2';

create user 
Langilea identified by 'langilea1234';

create user 
Bezeroa identified by 'bezeroa1234';

use mysql;
grant all privileges on mysql.user to 'DB_administratzailea'; -- Orain administratzaileak baimen guztiak ditu
grant select, update on mysql.user to 'Dep_burua'; -- Deparatemtnu buruak bakarrik aktualizazioak egiteko baimenak ditu, eta taula batzuk ikusi //
GRANT SELECT ON db_spoty.musikaria, db_spoty.Podcasterra, db_spoty.hizkuntza, db_spoty.bezeroa, db_spoty.premium, db_spoty.album, db_spoty.audioa, db_spoty.abestia, db_spoty.podcast, db_spoty.playlist, db_spoty.gustukoak, db_spoty.estatistikak TO 'Analista1'; -- Analistak taula asko begiratzeko baimenak //
grant select on db_spoty.musikaria, db_spoty.Podcasterra, db_spoty.hizkuntza, db_spoty.bezero, db_spoty.premium, db_spoty.album, db_spoty.audioa, db_spoty.abestia, db_spoty.podcast, db_spoty.playlist, db_spoty.gustukoak, db_spoty.estatistikak  to 'Analista2'; -- Analistak taula asko begiratzeko baimenak
grant select on db_spoty.musikaria, db_spoty.Podcasterra, db_spoty.hizkuntza, db_spoty.bezero, db_spoty.premium, db_spoty.album, db_spoty.audioa, db_spoty.abestia, db_spoty.podcast, db_spoty.playlist, db_spoty.gustukoak, db_spoty.estatistikak, update on db_spoty.musikaria, db_spoty.Podcasterra, db_spoty.hizkuntza, db_spoty.bezero, db_spoty.premium, db_spoty.album, db_spoty.audioa, db_spoty.abestia, db_spoty.podcast, db_spoty.playlist 'Langilea'; -- Langileak taulak ikusteko eta editatzeko baimenak // TODO SELECT pero insert solo estadistika, audio
grant select on db_spoty.musikaria, db_spoty.podcasterra, db_spoty.hizkuntza, db_spoty.bezeroa, db_spoty.premium, db_spoty.album, db_spoty.podcast, db_spoty.abestia, db_spoty.playlist, db_spoty.Gustukoak update on to db_spoty.hizkuntza, db_spoty.bezeroa, db_spoty.playlist, db_spoty.Gustukoak to  'Bezeroa'; -- Bezeroak bakarrik taula batzuk ikusi ahal ditu eta datuak txeratu haietan. // select abesti abesti album podcast podcaster y insert en playlist

