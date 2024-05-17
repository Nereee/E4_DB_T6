DELIMITER //
CREATE TRIGGER egunero_estatistikak
AFTER INSERT ON Erreprodukzioak
FOR EACH ROW
BEGIN
    DECLARE audio_data DATE;
    DECLARE audio_id INT;
    
    SELECT ErreData INTO audio_data FROM Erreprodukzioak WHERE codigo = NEW.codigo;
    
    SELECT IDAudio INTO audio_id FROM Erreprodukzioak WHERE codigo = NEW.codigo;
    
    UPDATE EstatistikakEgunero
    SET ErreprodukzioKopurua = ErreprodukzioKopurua + 1
    WHERE IDAudio = audio_id AND Data = audio_data;

    IF EXISTS (SELECT 1 FROM Gustukoak WHERE IDAudio = audio_id AND Data = audio_data) THEN
        UPDATE EstatistikakEgunero
        SET GustukoKopurua = GustukoKopurua + 1
        WHERE IDAudio = audio_id AND Data = audio_data;
    END IF;
END; //
DELIMITER;

DELIMITER //
CREATE TRIGGER asteko_estatistikak
AFTER UPDATE ON EstatistikakEgunero
FOR EACH ROW
BEGIN
    DECLARE astea INT;
    DECLARE urte INT;
    DECLARE audio_id INT;

    -- Aste zenbakia lortu
    SET astea = WEEK(NEW.Data, 1); -- Lortzen du astearen zenbakia
    -- Urtea lortu
    SET urte = YEAR(NEW.Data); -- Lortzen du urtea
    -- Audioaren ID-a lortu
    SET audio_id = NEW.IDAudio; -- Lortzen du audioaren ID-a

    -- Sartu edo eguneratu datuak EstatistikakAsteero taulan
    INSERT INTO EstatistikakAsteero (IDAudio, Urte, Astea, ErreprodukzioKopurua, GustukoKopurua, ErreprodukzioDenboraTotala, AzkenzErreproduzioData)
    VALUES (audio_id, urte, astea, NEW.ErreprodukzioKopurua, NEW.GustukoKopurua, NEW.ErreprodukzioDenboraTotala, NEW.AzkenzErreproduzioData)
    ON DUPLICATE KEY UPDATE
        ErreprodukzioKopurua = VALUES(ErreprodukzioKopurua),
        GustukoKopurua = VALUES(GustukoKopurua),
        ErreprodukzioDenboraTotala = VALUES(ErreprodukzioDenboraTotala),
        AzkenzErreproduzioData = VALUES(AzkenzErreproduzioData);
END; //
DELIMITER ;


DELIMITER //
CREATE TRIGGER hileko_estatistikak
AFTER UPDATE ON EstatistikakEgunero
FOR EACH ROW
BEGIN
    DECLARE hilabetea INT;
    DECLARE urte INT;
    DECLARE audio_id INT;

    -- Hilabete zenbakia lortu
    SET hilabetea = MONTH(NEW.Data); -- Lortzen du hilabetearen zenbakia
    -- Urtea lortu
    SET urte = YEAR(NEW.Data); -- Lortzen du urtea
    -- Audioaren ID-a lortu
    SET audio_id = NEW.IDAudio; -- Lortzen du audioaren ID-a

    -- Sartu edo eguneratu datuak EstatistikakHilero taulan
    INSERT INTO EstatistikakHilero (IDAudio, Urte, Hilabetea, ErreprodukzioKopurua, GustukoKopurua, ErreprodukzioDenboraTotala, AzkenzErreproduzioData)
    VALUES (audio_id, urte, hilabetea, NEW.ErreprodukzioKopurua, NEW.GustukoKopurua, NEW.ErreprodukzioDenboraTotala, NEW.AzkenzErreproduzioData)
    ON DUPLICATE KEY UPDATE
        ErreprodukzioKopurua = VALUES(ErreprodukzioKopurua),
        GustukoKopurua = VALUES(GustukoKopurua),
        ErreprodukzioDenboraTotala = VALUES(ErreprodukzioDenboraTotala),
        AzkenzErreproduzioData = VALUES(AzkenzErreproduzioData);
END; //
DELIMITER ;

DELIMITER //
CREATE TRIGGER urteko_estatistikak
AFTER UPDATE ON EstatistikakEgunero
FOR EACH ROW
BEGIN
    DECLARE urte INT;
    DECLARE audio_id INT;

    SET urte = YEAR(NEW.Data); -- Obtiene el año
    SET audio_id = NEW.IDAudio; -- Obtiene el ID del audio

    INSERT INTO EstatistikakUrtero (IDAudio, Urte, ErreprodukzioKopurua, GustukoKopurua, ErreprodukzioDenboraTotala, AzkenzErreproduzioData)
    VALUES (audio_id, urte, NEW.ErreprodukzioKopurua, NEW.GustukoKopurua, NEW.ErreprodukzioDenboraTotala, NEW.AzkenzErreproduzioData)
    ON DUPLICATE KEY UPDATE
        ErreprodukzioKopurua = VALUES(ErreprodukzioKopurua),
        GustukoKopurua = VALUES(GustukoKopurua),
        ErreprodukzioDenboraTotala = VALUES(ErreprodukzioDenboraTotala),
        AzkenzErreproduzioData = VALUES(AzkenzErreproduzioData);
END; //
DELIMITER ;


DELIMITER // 
create event update_premium_bezeroak
on schedule every 1 day
do
begin
    declare uneko_data date;
    declare erabiltzaile_id int;
    
    set uneko_data = curdate();
    
    select idbezeroa into erabiltzaile_id
    from premium
    where iraungitze_data <= uneko_data;
    
    if erabiltzaile_id is not null then
        update bezeroa
        set mota = 'free'
        where idbezeroa = erabiltzaile_id;
        
        delete from premium
        where idbezeroa = erabiltzaile_id;
        
    end if;
end;
DELIMITER ;

DELIMITER //
CREATE EVENT IF NOT EXISTS inaktibo_playlista_desaktibatu
ON SCHEDULE EVERY 1 MONTH
STARTS '2024-01-01 04:00:00'
DO
BEGIN
    DELETE FROM Playlist
    WHERE IDList NOT IN (
        SELECT DISTINCT IDList 
        FROM PLaylist_Abestiak
        WHERE Sorrera_data >= CURDATE() - INTERVAL 1 YEAR
    ) AND Sorrera_data < CURDATE() - INTERVAL 1 YEAR;
END//
DELIMITER ;

DELIMITER //
CREATE EVENT IF NOT EXISTS inaktibo_album_desaktibatu
ON SCHEDULE EVERY 1 MONTH
STARTS '2024-01-01 04:00:00'
DO
BEGIN
    DELETE FROM Album
    WHERE Eguna < CURDATE() - INTERVAL 1 YEAR;
END//
DELIMITER ;

DELIMITER //
CREATE EVENT IF NOT EXISTS inaktibo_abesti_desaktibatu
ON SCHEDULE EVERY 1 MONTH
STARTS '2024-01-01 04:00:00'
DO
BEGIN
    DELETE FROM Audioa
    WHERE IDAudio NOT IN (
        SELECT DISTINCT IDAudio 
        FROM PLaylist_Abestiak
    ) AND IDAudio NOT IN (
        SELECT DISTINCT IDAudio 
        FROM Podcast
    );
END//
DELIMITER ;

