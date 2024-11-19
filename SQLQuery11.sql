INSERT INTO Person.Person (BusinessEntityID, PersonType, FirstName, LastName, Title)
VALUES (1, 'SC', 'John', 'Doe', 'Mr.');

SELECT DISTINCT PersonType FROM Person.Person;

INSERT INTO Person.Person (BusinessEntityID, PersonType, FirstName, LastName, Title)
VALUES (20781, 'SC', 'Johnase', 'Doermano', 'Mr.');




INSERT INTO Person.BusinessEntity DEFAULT VALUES;
SELECT SCOPE_IDENTITY() AS NewBusinessEntityID;



SELECT * FROM Historical_Person
WHERE BusinessEntityID = 20781;




Select MAX(BusinessEntityID)
From Person.Person



--nuevo trigger 

SELECT name
FROM sys.triggers
WHERE name = 'trg_Historical_Person';

DROP TRIGGER IF EXISTS trg_Historical_Person;
DROP TRIGGER IF EXISTS Person.trg_Historical_Person;

SELECT name AS TriggerName, object_name(parent_id) AS TableName
FROM sys.triggers
WHERE name = 'trg_Historical_Person';


DROP TRIGGER IF EXISTS dbo.trg_Historical_Person;



CREATE TRIGGER trg_Historical_Person
ON Person.Person
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Insertar o Actualizar
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Manejar FirstName
        UPDATE Historical_Person
        SET End_Date = GETDATE()
        WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM inserted)
          AND Attribute_Name = 'FirstName'
          AND End_Date = '2999-12-31';

        INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
        SELECT 
            i.BusinessEntityID,
            'FirstName',
            i.FirstName,
            GETDATE()
        FROM inserted i
        LEFT JOIN Historical_Person h
        ON i.BusinessEntityID = h.BusinessEntityID
           AND h.Attribute_Name = 'FirstName'
           AND h.End_Date = '2999-12-31'
        WHERE h.BusinessEntityID IS NULL;

        -- Manejar LastName
        UPDATE Historical_Person
        SET End_Date = GETDATE()
        WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM inserted)
          AND Attribute_Name = 'LastName'
          AND End_Date = '2999-12-31';

        INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
        SELECT 
            i.BusinessEntityID,
            'LastName',
            i.LastName,
            GETDATE()
        FROM inserted i
        LEFT JOIN Historical_Person h
        ON i.BusinessEntityID = h.BusinessEntityID
           AND h.Attribute_Name = 'LastName'
           AND h.End_Date = '2999-12-31'
        WHERE h.BusinessEntityID IS NULL;

        -- Manejar Title
        UPDATE Historical_Person
        SET End_Date = GETDATE()
        WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM inserted)
          AND Attribute_Name = 'Title'
          AND End_Date = '2999-12-31';

        INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
        SELECT 
            i.BusinessEntityID,
            'Title',
            i.Title,
            GETDATE()
        FROM inserted i
        LEFT JOIN Historical_Person h
        ON i.BusinessEntityID = h.BusinessEntityID
           AND h.Attribute_Name = 'Title'
           AND h.End_Date = '2999-12-31'
        WHERE h.BusinessEntityID IS NULL;
    END

    -- Manejar Eliminaciones
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        UPDATE Historical_Person
        SET End_Date = GETDATE()
        WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM deleted)
          AND End_Date = '2999-12-31';
    END
END;


--Nuevos TRiggers

CREATE TRIGGER trg_Insert_Historical_Person
ON Person.Person
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Insertar nuevos registros en la tabla histórica
    INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
    SELECT 
        BusinessEntityID, 
        'FirstName', 
        FirstName, 
        GETDATE()
    FROM inserted;

    INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
    SELECT 
        BusinessEntityID, 
        'LastName', 
        LastName, 
        GETDATE()
    FROM inserted;

    INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
    SELECT 
        BusinessEntityID, 
        'Title', 
        Title, 
        GETDATE()
    FROM inserted;
END;


--2

CREATE TRIGGER trg_Update_Historical_Person
ON Person.Person
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Cerrar registros vigentes y actualizar FirstName
    UPDATE Historical_Person
    SET End_Date = GETDATE()
    WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM inserted)
      AND Attribute_Name = 'FirstName'
      AND End_Date = '2999-12-31';

    INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
    SELECT 
        BusinessEntityID, 
        'FirstName', 
        FirstName, 
        GETDATE()
    FROM inserted;

    -- Cerrar registros vigentes y actualizar LastName
    UPDATE Historical_Person
    SET End_Date = GETDATE()
    WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM inserted)
      AND Attribute_Name = 'LastName'
      AND End_Date = '2999-12-31';

    INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
    SELECT 
        BusinessEntityID, 
        'LastName', 
        LastName, 
        GETDATE()
    FROM inserted;

    -- Cerrar registros vigentes y actualizar Title
    UPDATE Historical_Person
    SET End_Date = GETDATE()
    WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM inserted)
      AND Attribute_Name = 'Title'
      AND End_Date = '2999-12-31';

    INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
    SELECT 
        BusinessEntityID, 
        'Title', 
        Title, 
        GETDATE()
    FROM inserted;
END;


--3

CREATE TRIGGER trg_Delete_Historical_Person
ON Person.Person
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Cerrar registros vigentes en la tabla histórica
    UPDATE Historical_Person
    SET End_Date = GETDATE()
    WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM deleted)
      AND End_Date = '2999-12-31';
END;


INSERT INTO Person.Person (BusinessEntityID, PersonType, FirstName, LastName, Title)
VALUES (20782, 'SC', 'Alice', 'Wonder', 'Ms.');

SELECT * FROM Historical_Person WHERE BusinessEntityID = 20782;



ALTER TRIGGER trg_Insert_Historical_Person
ON Person.Person
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Manejar FirstName
    INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
    SELECT 
        i.BusinessEntityID, 
        'FirstName', 
        i.FirstName, 
        GETDATE()
    FROM inserted i
    LEFT JOIN Historical_Person h
    ON i.BusinessEntityID = h.BusinessEntityID
       AND h.Attribute_Name = 'FirstName'
       AND h.End_Date = '2999-12-31'
    WHERE h.BusinessEntityID IS NULL;

    -- Manejar LastName
    INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
    SELECT 
        i.BusinessEntityID, 
        'LastName', 
        i.LastName, 
        GETDATE()
    FROM inserted i
    LEFT JOIN Historical_Person h
    ON i.BusinessEntityID = h.BusinessEntityID
       AND h.Attribute_Name = 'LastName'
       AND h.End_Date = '2999-12-31'
    WHERE h.BusinessEntityID IS NULL;

    -- Manejar Title
    INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
    SELECT 
        i.BusinessEntityID, 
        'Title', 
        i.Title, 
        GETDATE()
    FROM inserted i
    LEFT JOIN Historical_Person h
    ON i.BusinessEntityID = h.BusinessEntityID
       AND h.Attribute_Name = 'Title'
       AND h.End_Date = '2999-12-31'
    WHERE h.BusinessEntityID IS NULL;
END;
