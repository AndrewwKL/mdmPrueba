CREATE TRIGGER trg_Historical_PhoneNumber
ON Person.PersonPhone
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Registro de datos nuevos o actualizados
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Cerrar el registro existente
        UPDATE Historical_PhoneNumber
        SET End_Date = GETDATE()
        WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM inserted)
          AND PhoneNumber IN (SELECT PhoneNumber FROM inserted)
          AND End_Date = '2999-12-31';

        -- Insertar nuevos registros
        INSERT INTO Historical_PhoneNumber (BusinessEntityID, PhoneNumber, Start_Date)
        SELECT 
            BusinessEntityID,
            PhoneNumber,
            GETDATE()
        FROM inserted;
    END

    -- Registro de eliminaciones
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        UPDATE Historical_PhoneNumber
        SET End_Date = GETDATE()
        WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM deleted)
          AND PhoneNumber IN (SELECT PhoneNumber FROM deleted)
          AND End_Date = '2999-12-31';
    END
END;
