Use AdventureWorks2022

INSERT INTO Historical_EmailAddress (BusinessEntityID, EmailAddressID, EmailAddress, Start_Date)
SELECT 
    BusinessEntityID, 
    EmailAddressID, 
    ISNULL(EmailAddress, 'N/A') AS EmailAddress, -- Reemplaza valores NULL por un valor predeterminado
    GETDATE() AS Start_Date
FROM Person.EmailAddress
WHERE EmailAddress IS NOT NULL; 


