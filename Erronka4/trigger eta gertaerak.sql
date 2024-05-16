-- ********************************TRIGGERRAK********************************
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

CREATE PROCEDURE astero_estatistikak()
BEGIN
    -- Calculamos las estadísticas semanales
    INSERT INTO EstatistikakAsteero (IDAudio, Urte, Astea, ErreprodukzioKopurua, GustukoKopurua)
    SELECT 
        IDAudio, 
        YEAR(Data) AS Urte, 
        WEEK(Data) AS Astea, 
        SUM(ErreprodukzioKopurua), 
        SUM(GustukoKopurua)
    FROM 
        EstatistikakEgunero
    GROUP BY 
        IDAudio, Urte, Astea
    ON DUPLICATE KEY UPDATE 
        ErreprodukzioKopurua = VALUES(ErreprodukzioKopurua), 
        GustukoKopurua = VALUES(GustukoKopurua);
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE hilero_estatistikak()
BEGIN
    -- Calculamos las estadísticas mensuales
    INSERT INTO EstatistikakHilero (IDAudio, Urte, Hilabetea, ErreprodukzioKopurua, GustukoKopurua)
    SELECT 
        IDAudio, 
        YEAR(Data) AS Urte, 
        MONTH(Data) AS Hilabetea, 
        SUM(ErreprodukzioKopurua), 
        SUM(GustukoKopurua)
    FROM 
        EstatistikakEgunero
    GROUP BY 
        IDAudio, Urte, Hilabetea
    ON DUPLICATE KEY UPDATE 
        ErreprodukzioKopurua = VALUES(ErreprodukzioKopurua), 
        GustukoKopurua = VALUES(GustukoKopurua);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE urteko_estatistikak()
BEGIN
    -- Calculamos las estadísticas anuales
    INSERT INTO EstatistikakUrtero (IDAudio, Urte, ErreprodukzioKopurua, GustukoKopurua)
    SELECT 
        IDAudio, 
        YEAR(Data) AS Urte, 
        SUM(ErreprodukzioKopurua), 
        SUM(GustukoKopurua)
    FROM 
        EstatistikakEgunero
    GROUP BY 
        IDAudio, Urte
    ON DUPLICATE KEY UPDATE 
        ErreprodukzioKopurua = VALUES(ErreprodukzioKopurua), 
        GustukoKopurua = VALUES(GustukoKopurua);
END //

DELIMITER ;



-- ********************************GERTAERAK********************************
SET GLOBAL event_scheduler = ON;

DELIMITER //
CREATE EVENT astero_estatistikak
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
    CALL astero_estatistikak();
END //
DEMILIMITER;

DELIMITER //
CREATE EVENT hilero_estatistikak
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    CALL hilero_estatistikak();
END //
DEMILIMITER;

DELIMITER //
CREATE EVENT urteko_estatistikak
ON SCHEDULE EVERY 1 YEAR
DO
BEGIN
    CALL urteko_estatistikak();
END //
DEMILIMITER;


DELIMITER //

CREATE EVENT update_premium_bezeroak
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    DECLARE uneko_data DATE;
    DECLARE erabiltzaile_id INT;
    
    SET uneko_data = CURDATE();
    
    SELECT IDBezeroa INTO erabiltzaile_id
    FROM Premium
    WHERE Iraungitze_data <= uneko_data;
    
    IF erabiltzaile_id IS NOT NULL THEN
        UPDATE Bezeroa
        SET mota = 'Free'
        WHERE IDBezeroa = erabiltzaile_id;
        
        DELETE FROM Premium
        WHERE IDBezeroa = erabiltzaile_id;
    END IF;
END;
//

DELIMITER ;









