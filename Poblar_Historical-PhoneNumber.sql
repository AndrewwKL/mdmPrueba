Use AdventureWorks2022

INSERT INTO Historical_PhoneNumber (BusinessEntityID, PhoneNumber, Start_Date)
SELECT 
    BusinessEntityID, 
    PhoneNumber, 
    GETDATE() AS Start_Date
FROM Person.PersonPhone;
