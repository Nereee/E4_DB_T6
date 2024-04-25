use db_spoty;
create user
DB_administratzailea identified by 'admin1234';


create user 
Dep_burua identified by 'dep_burua1234';

create user 
Analista1 identified by 'Analista1';

create user 
Analista2 identified by 'Analista2';

#ezin da user hau sortu, errorea ematen du
create user 
Langilea identified by 'langilea';

create user 
Bezeroa identified by 'bezeroa1234';



use mysql;
grant all privileges on db_spoty.* to 'DB_administratzailea'; -- Orain administratzaileak baimen guztiak ditu
-- Deparatemtnu buruak bakarrik aktualizazioak egiteko baimenak ditu, eta taula batzuk ikusi

REPAIR TABLE mysql.tables_priv;
GRANT SELECT, UPDATE, ALTER ON db_spoty.musikaria TO 'Dep_burua';
GRANT SELECT, UPDATE, ALTER ON db_spoty.bezeroa TO 'Dep_burua';
GRANT SELECT, UPDATE, ALTER ON  db_spoty.Podcasterra TO 'Dep_burua';
GRANT SELECT, UPDATE, ALTER ON  db_spoty.hizkuntza TO 'Dep_burua';
GRANT SELECT, UPDATE, ALTER ON db_spoty.premium TO 'Dep_burua';
GRANT SELECT, UPDATE, ALTER ON db_spoty.album TO 'Dep_burua';
GRANT SELECT, UPDATE, ALTER ON  db_spoty.audioa TO 'Dep_burua';
GRANT SELECT, UPDATE, ALTER ON db_spoty.abestia TO 'Dep_burua';
GRANT SELECT, UPDATE, ALTER ON db_spoty.podcast TO 'Dep_burua';
GRANT SELECT, UPDATE, ALTER ON db_spoty.playlist TO 'Dep_burua';
GRANT SELECT, UPDATE, ALTER ON db_spoty.gustukoak TO 'Dep_burua';
GRANT SELECT, UPDATE, ALTER ON db_spoty.estatistikak TO 'Dep_burua';
GRANT SELECT, UPDATE, ALTER ON db_spoty.erreprodukzioak TO 'Dep_burua';
CREATE ROLE Analistak;

#Analistei bakarrik select egiteko baimenak emango dituegu, ez dute ezer ikutu behar, bakarrik datuak atera
GRANT SELECT ON db_spoty.musikaria TO Analistak;
GRANT SELECT ON db_spoty.bezeroa TO Analistak;
GRANT SELECT ON  db_spoty.Podcasterra TO Analistak;
GRANT SELECT ON  db_spoty.hizkuntza TO Analistak;
GRANT SELECT ON db_spoty.premium TO Analistak;
GRANT SELECT ON db_spoty.album TO Analistak;
GRANT SELECT ON db_spoty.erreprodukzioak to Analistak;
GRANT SELECT ON  db_spoty.audioa TO Analistak;
GRANT SELECT ON db_spoty.abestia TO Analistak;
GRANT SELECT ON db_spoty.podcast TO Analistak;
GRANT SELECT ON db_spoty.playlist TO Analistak;
GRANT SELECT ON db_spoty.gustukoak TO Analistak;
GRANT SELECT ON db_spoty.estatistikak TO Analistak;

GRANT Analistak TO Analista1, Analista2;

#Langileak baimen gehiago eukiko dute, select ia berdinak bainankasu honetan update desberdinak egin dezakete datu berriak sartzeko edo ezabatzeko
grant select, update on db_spoty.musikaria to 'Langilea';
grant select, update on db_spoty.Podcasterra to 'Langilea';
grant select, update on db_spoty.hizkuntza to 'Langilea';
grant select, update on db_spoty.bezeroa to 'Langilea';
grant select, update on db_spoty.premium to 'Langilea';
grant select, update on db_spoty.album to 'Langilea';
grant select, update on db_spoty.musikaria to 'Langilea';
grant select, update on db_spoty.audioa to 'Langilea';
grant select, update on db_spoty.abestia to 'Langilea';
grant select, update on db_spoty.podcast to 'Langilea';


#Bezeroek aldiz, select asko egin ahal izango dute. Abesti eta podcast desberdin entzun ahal izateko, musikarien perfilak ikusteko... Baina datuak txertatxeko limitazioak dituzte, hizkuntza aldatu, haien datuak, playlist-etan aldaketak egin eta gustuko abestaik kendu eta ipini
grant select on db_spoty.musikaria to  'Bezeroa';
grant select on db_spoty.podcasterra to  'Bezeroa';
grant select, update on db_spoty.hizkuntza to  'Bezeroa';
grant select, update on db_spoty.bezeroa to  'Bezeroa';
grant select on db_spoty.premium to  'Bezeroa';
grant select on db_spoty.album to  'Bezeroa';
grant select on db_spoty.podcast to  'Bezeroa';
grant select on db_spoty.abestia to  'Bezeroa';
grant select, update on db_spoty.playlist to  'Bezeroa';
grant select, update on db_spoty.Gustukoak to  'Bezeroa';





