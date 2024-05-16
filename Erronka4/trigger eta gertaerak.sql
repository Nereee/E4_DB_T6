-- ********************************TRIGGER********************************

DELIMITER //

CREATE TRIGGER estadistikak_egunero
AFTER INSERT ON Erreprodukzioak
FOR EACH ROW
BEGIN
    DECLARE v_IDAudio INT;
    DECLARE v_Data DATE;
    DECLARE v_ErreprodukzioDenbora INT;
    DECLARE v_GustukoKopurua INT;
    
    SET v_IDAudio = NEW.IDAudio;
    SET v_Data = NEW.ErreData;
    SET v_ErreprodukzioDenbora = (SELECT Iraupena FROM Audioa WHERE IDAudio = v_IDAudio); 
    
    UPDATE EstatistikakEgunero
    SET ErreprodukzioKopurua = ErreprodukzioKopurua + 1,
        AzkenzErreproduzioData = v_Data
    WHERE IDAudio = v_IDAudio AND Data = v_Data;
    
    IF (EXISTS (SELECT 1 FROM Gustukoak WHERE IDAudio = v_IDAudio AND IDBezeroa = NEW.IDBezeroa)) THEN
        UPDATE EstatistikakEgunero
        SET GustukoKopurua = GustukoKopurua + 1
        WHERE IDAudio = v_IDAudio AND Data = v_Data;
    END IF;
    
    UPDATE EstatistikakEgunero
    SET ErreprodukzioDenboraTotala = ErreprodukzioDenboraTotala + v_ErreprodukzioDenbora
    WHERE IDAudio = v_IDAudio AND Data = v_Data;
    
    -- Si no existe una fila para este día y audio, insertar una nueva fila en EstatistikakEgunero
    IF (SELECT COUNT(*) FROM EstatistikakEgunero WHERE IDAudio = v_IDAudio AND Data = v_Data) = 0 THEN
        INSERT INTO EstatistikakEgunero (IDAudio, Data, ErreprodukzioKopurua, GustukoKopurua, ErreprodukzioDenboraTotala, AzkenzErreproduzioData)
        VALUES (v_IDAudio, v_Data, 1, 0, v_ErreprodukzioDenbora, v_Data);
    END IF;
    
END//

DELIMITER ;


INSERT INTO Erreprodukzioak (IDBezeroa, IDAudio, ErreData)
VALUES (1, 123, '2024-05-16');

SELECT * FROM EstatistikakEgunero WHERE IDAudio = 123 AND Data = '2024-05-16';

DELIMITER //

CREATE TRIGGER estadistikak_astero
AFTER INSERT ON Erreprodukzioak
FOR EACH ROW
BEGIN
    DECLARE v_IDAudio INT;
    DECLARE v_Urte INT;
    DECLARE v_Astea INT;
    DECLARE v_ErreprodukzioDenbora INT;
    DECLARE v_GustukoKopurua INT;
    
    SET v_IDAudio = NEW.IDAudio;
    SET v_Urte = YEAR(NEW.ErreData);
    SET v_Astea = WEEK(NEW.ErreData);
    SET v_ErreprodukzioDenbora = (SELECT Iraupena FROM Audioa WHERE IDAudio = v_IDAudio); -- Duración de la reproducción en segundos (supongamos que la columna Iraupena representa la duración del audio en segundos)
    
    UPDATE EstatistikakAsteero
    SET ErreprodukzioKopurua = ErreprodukzioKopurua + 1,
        AzkenzErreproduzioData = NEW.ErreData
    WHERE IDAudio = v_IDAudio AND Urte = v_Urte AND Astea = v_Astea;
    
    IF (EXISTS (SELECT 1 FROM Gustukoak WHERE IDAudio = v_IDAudio AND IDBezeroa = NEW.IDBezeroa)) THEN
        UPDATE EstatistikakAsteero
        SET GustukoKopurua = GustukoKopurua + 1
        WHERE IDAudio = v_IDAudio AND Urte = v_Urte AND Astea = v_Astea;
    END IF;
    
    UPDATE EstatistikakAsteero
    SET ErreprodukzioDenboraTotala = ErreprodukzioDenboraTotala + v_ErreprodukzioDenbora
    WHERE IDAudio = v_IDAudio AND Urte = v_Urte AND Astea = v_Astea;
    
    IF (SELECT COUNT(*) FROM EstatistikakAsteero WHERE IDAudio = v_IDAudio AND Urte = v_Urte AND Astea = v_Astea) = 0 THEN
        INSERT INTO EstatistikakAsteero (IDAudio, Urte, Astea, ErreprodukzioKopurua, GustukoKopurua, ErreprodukzioDenboraTotala, AzkenzErreproduzioData)
        VALUES (v_IDAudio, v_Urte, v_Astea, 1, 0, v_ErreprodukzioDenbora, NEW.ErreData);
    END IF;
    
END//

DELIMITER ;

INSERT INTO Erreprodukzioak (IDBezeroa, IDAudio, ErreData)
VALUES (1, 123, '2024-05-16');

SELECT * FROM EstatistikakAsteero WHERE IDAudio = 123 AND Urte = YEAR('2024-05-16') AND Astea = WEEK('2024-05-16');

DELIMITER //

CREATE TRIGGER estadistikak_hilero
AFTER INSERT ON Erreprodukzioak
FOR EACH ROW
BEGIN
    DECLARE v_IDAudio INT;
    DECLARE v_Urte INT;
    DECLARE v_Hilabetea INT;
    DECLARE v_ErreprodukzioDenbora INT;
    DECLARE v_GustukoKopurua INT;
    
    SET v_IDAudio = NEW.IDAudio;
    SET v_Urte = YEAR(NEW.ErreData);
    SET v_Hilabetea = MONTH(NEW.ErreData);
    SET v_ErreprodukzioDenbora = (SELECT Iraupena FROM Audioa WHERE IDAudio = v_IDAudio); -- Duración de la reproducción en segundos (supongamos que la columna Iraupena representa la duración del audio en segundos)
    
    UPDATE EstatistikakHilero
    SET ErreprodukzioKopurua = ErreprodukzioKopurua + 1,
        AzkenzErreproduzioData = NEW.ErreData
    WHERE IDAudio = v_IDAudio AND Urte = v_Urte AND Hilabetea = v_Hilabetea;
    
    IF (EXISTS (SELECT 1 FROM Gustukoak WHERE IDAudio = v_IDAudio AND IDBezeroa = NEW.IDBezeroa)) THEN
        UPDATE EstatistikakHilero
        SET GustukoKopurua = GustukoKopurua + 1
        WHERE IDAudio = v_IDAudio AND Urte = v_Urte AND Hilabetea = v_Hilabetea;
    END IF;
    
    UPDATE EstatistikakHilero
    SET ErreprodukzioDenboraTotala = ErreprodukzioDenboraTotala + v_ErreprodukzioDenbora
    WHERE IDAudio = v_IDAudio AND Urte = v_Urte AND Hilabetea = v_Hilabetea;
    
    IF (SELECT COUNT(*) FROM EstatistikakHilero WHERE IDAudio = v_IDAudio AND Urte = v_Urte AND Hilabetea = v_Hilabetea) = 0 THEN
        INSERT INTO EstatistikakHilero (IDAudio, Urte, Hilabetea, ErreprodukzioKopurua, GustukoKopurua, ErreprodukzioDenboraTotala, AzkenzErreproduzioData)
        VALUES (v_IDAudio, v_Urte, v_Hilabetea, 1, 0, v_ErreprodukzioDenbora, NEW.ErreData);
    END IF;
    
END//

DELIMITER ;

INSERT INTO Erreprodukzioak (IDBezeroa, IDAudio, ErreData)
VALUES (1, 123, '2024-05-16');

SELECT * FROM EstatistikakHilero WHERE IDAudio = 123 AND Urte = YEAR('2024-05-16') AND Hilabetea = MONTH('2024-05-16');

DELIMITER //

CREATE TRIGGER estadistikak_urtero
AFTER INSERT ON Erreprodukzioak
FOR EACH ROW
BEGIN
    DECLARE v_IDAudio INT;
    DECLARE v_Urte INT;
    DECLARE v_ReproduccionDuracion INT;
    DECLARE v_GustukoKopurua INT;
    
    SET v_IDAudio = NEW.IDAudio;
    SET v_Urte = YEAR(NEW.ErreData);
    SET v_ReproduccionDuracion = (SELECT Iraupena FROM Audioa WHERE IDAudio = v_IDAudio); -- Duración de la reproducción en segundos (supongamos que la columna Iraupena representa la duración del audio en segundos)
    
    UPDATE EstatistikakUrtero
    SET ErreprodukzioKopurua = ErreprodukzioKopurua + 1,
        AzkenzErreproduzioData = NEW.ErreData
    WHERE IDAudio = v_IDAudio AND Urte = v_Urte;
    
    IF (EXISTS (SELECT 1 FROM Gustukoak WHERE IDAudio = v_IDAudio AND IDBezeroa = NEW.IDBezeroa)) THEN
        UPDATE EstatistikakUrtero
        SET GustukoKopurua = GustukoKopurua + 1
        WHERE IDAudio = v_IDAudio AND Urte = v_Urte;
    END IF;
    
    UPDATE EstatistikakUrtero
    SET ErreprodukzioDenboraTotala = ErreprodukzioDenboraTotala + v_ReproduccionDuracion
    WHERE IDAudio = v_IDAudio AND Urte = v_Urte;
    
    IF (SELECT COUNT(*) FROM EstatistikakUrtero WHERE IDAudio = v_IDAudio AND Urte = v_Urte) = 0 THEN
        INSERT INTO EstatistikakUrtero (IDAudio, Urte, ErreprodukzioKopurua, GustukoKopurua, ErreprodukzioDenboraTotala, AzkenzErreproduzioData)
        VALUES (v_IDAudio, v_Urte, 1, 0, v_ReproduccionDuracion, NEW.ErreData);
    END IF;
    
END//

DELIMITER ;

INSERT INTO Erreprodukzioak (IDBezeroa, IDAudio, ErreData)
VALUES (1, 123, '2024-05-16');

SELECT * FROM EstatistikakUrtero WHERE IDAudio = 123 AND Urte = YEAR('2024-05-16');

-- ********************************TRIGGER********************************



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






