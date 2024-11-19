Use AdventureWorks2022

INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
SELECT 
    BusinessEntityID, 
    'FirstName' AS Attribute_Name, 
    FirstName AS Value, 
    GETDATE() AS Start_Date
FROM Person.Person;

INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
SELECT 
    BusinessEntityID, 
    'LastName' AS Attribute_Name, 
    LastName AS Value, 
    GETDATE() AS Start_Date
FROM Person.Person;

INSERT INTO Historical_Person (BusinessEntityID, Attribute_Name, Value, Start_Date)
SELECT 
    BusinessEntityID, 
    'Title' AS Attribute_Name, 
    Title AS Value, 
    GETDATE() AS Start_Date
FROM Person.Person;

