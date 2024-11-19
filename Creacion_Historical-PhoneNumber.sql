Use AdventureWorks2022

CREATE TABLE Historical_PhoneNumber (
    ID INT PRIMARY KEY IDENTITY(1,1),
    BusinessEntityID INT NOT NULL, 
    PhoneNumber NVARCHAR(25) NOT NULL, 
    Start_Date DATETIME NOT NULL, 
    End_Date DATETIME NOT NULL DEFAULT ('2999-12-31') 
);

ALTER TABLE Historical_PhoneNumber
ADD CONSTRAINT FK_HistoricalPhone_BusinessEntityID
FOREIGN KEY (BusinessEntityID) REFERENCES Person.PhoneNumber(BusinessEntityID);


ALTER TABLE Historical_PhoneNumber
ADD PhoneNumber NVARCHAR(25) NOT NULL; 


ALTER TABLE Historical_PhoneNumber
DROP COLUMN PhoneNumber;


ALTER TABLE Historical_PhoneNumber
ADD CONSTRAINT FK_HistoricalPhone_BusinessEntityID
FOREIGN KEY (BusinessEntityID, PhoneNumber)
REFERENCES Person.PersonPhone(BusinessEntityID, PhoneNumber);

