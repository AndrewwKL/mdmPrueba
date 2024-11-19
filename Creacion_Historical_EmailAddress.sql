
Use AdventureWorks2022

CREATE TABLE Historical_EmailAddress (
    ID INT PRIMARY KEY IDENTITY(1,1), 
    BusinessEntityID INT NOT NULL, 
    EmailAddress NVARCHAR(255) NOT NULL, 
    Start_Date DATETIME NOT NULL,
    End_Date DATETIME NOT NULL DEFAULT ('2999-12-31') 
);



ALTER TABLE Historical_EmailAddress
ADD EmailAddressID INT NOT NULL; 



ALTER TABLE Historical_EmailAddress
ADD CONSTRAINT FK_HistoricalEmail_BusinessEntityID
FOREIGN KEY (BusinessEntityID, EmailAddressID) 
REFERENCES Person.EmailAddress(BusinessEntityID, EmailAddressID);


