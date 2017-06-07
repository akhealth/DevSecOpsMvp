-- Create new database.
IF NOT EXISTS (
  SELECT name
FROM sys.databases
WHERE name = N'AKTestDataBase'
)
CREATE DATABASE AKTestDataBase
GO

-- Switch to the new DB
USE AKTestDataBase
GO

-- Create table
IF OBJECT_ID('dbo.Employees', 'U') IS NOT NULL
DROP TABLE dbo.Employees
GO

CREATE TABLE dbo.Employees
(
    EmployeesId INT NOT NULL PRIMARY KEY, 
    Name [NVARCHAR](50) NOT NULL,
    Location [NVARCHAR](50) NOT NULL
);
GO

-- Insert test data
INSERT INTO Employees
   ([EmployeesId],[Name],[Location])
VALUES
   ( 1, N'Mark', N'New York'),
   ( 2, N'Clint', N'Wyoming'),
   ( 3, N'Waldo', N'Virginia'),
   ( 4, N'Simon', N'Alaska'),   
   ( 5, N'Paul', N'Alaska') 
GO   