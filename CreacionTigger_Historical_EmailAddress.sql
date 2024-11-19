CREATE TRIGGER trg_Historical_EmailAddress
ON Person.EmailAddress
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Registro de datos nuevos o actualizados
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Cerrar el registro existente
        UPDATE Historical_EmailAddress
        SET End_Date = GETDATE()
        WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM inserted)
          AND EmailAddressID IN (SELECT EmailAddressID FROM inserted)
          AND End_Date = '2999-12-31';

        -- Insertar nuevos registros
        INSERT INTO Historical_EmailAddress (BusinessEntityID, EmailAddressID, EmailAddress, Start_Date)
        SELECT 
            BusinessEntityID,
            EmailAddressID,
            EmailAddress,
            GETDATE()
        FROM inserted;
    END

    -- Registro de eliminaciones
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        UPDATE Historical_EmailAddress
        SET End_Date = GETDATE()
        WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM deleted)
          AND EmailAddressID IN (SELECT EmailAddressID FROM deleted)
          AND End_Date = '2999-12-31';
    END
END;
