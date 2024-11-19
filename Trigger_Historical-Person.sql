CREATE TRIGGER trg_Historical_Person
ON Person.Person
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Insertar o Actualizar
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Cerrar registros vigentes de FirstName
        UPDATE Historical_Person
        SET End_Date = GETDATE()
        WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM inserted)
          AND Attribute_Name = 'FirstName'
          AND End_Date = '2999-12-31';

        -- Insertar nuevo registro para FirstName
        INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
        SELECT 
            BusinessEntityID,
            'FirstName' AS Attribute_Name,
            FirstName AS Value,
            GETDATE() AS Start_Date
        FROM inserted;

        -- Cerrar registros vigentes de LastName
        UPDATE Historical_Person
        SET End_Date = GETDATE()
        WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM inserted)
          AND Attribute_Name = 'LastName'
          AND End_Date = '2999-12-31';

        -- Insertar nuevo registro para LastName
        INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
        SELECT 
            BusinessEntityID,
            'LastName' AS Attribute_Name,
            LastName AS Value,
            GETDATE() AS Start_Date
        FROM inserted;

        -- Cerrar registros vigentes de Title
        UPDATE Historical_Person
        SET End_Date = GETDATE()
        WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM inserted)
          AND Attribute_Name = 'Title'
          AND End_Date = '2999-12-31';

        -- Insertar nuevo registro para Title
        INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
        SELECT 
            BusinessEntityID,
            'Title' AS Attribute_Name,
            Title AS Value,
            GETDATE() AS Start_Date
        FROM inserted;
    END

    -- Eliminaciones
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        UPDATE Historical_Person
        SET End_Date = GETDATE()
        WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM deleted)
          AND End_Date = '2999-12-31';
    END
END;
