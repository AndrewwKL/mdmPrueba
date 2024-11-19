CREATE TABLE Historical_Person (
    ID INT PRIMARY KEY IDENTITY(1,1), 
    BusinessEntityID INT NOT NULL, 
    Attribute_Name NVARCHAR(255) NOT NULL, 
    Value NVARCHAR(MAX) NOT NULL, 
    Start_Date DATETIME NOT NULL, 
    End_Date DATETIME NOT NULL DEFAULT ('2999-12-31')
);

ALTER TABLE Historical_Person
ADD CONSTRAINT FK_HistoricalPerson_BusinessEntityID
FOREIGN KEY (BusinessEntityID) REFERENCES Person.Person(BusinessEntityID);

Use AdventureWorks2022

ALTER TABLE Historical_Person
ALTER COLUMN Value NVARCHAR(MAX) NULL;
