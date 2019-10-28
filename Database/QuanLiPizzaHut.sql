CREATE DATABASE QuanLiPizzaHut
GO

USE QuanLiPizzaHut
GO

CREATE TABLE Unit
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	DisplayName NVARCHAR(128)
)
GO

CREATE TABLE Items
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	DisplayName NVARCHAR(128),
	IDUnit INT not null,
	Price MONEY not null

	FOREIGN KEY(IDUnit) REFERENCES dbo.Unit(ID)
)
GO
CREATE TABLE Customer
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(128),
	Address NVARCHAR(128),
	Phone INT ,
	Birthday DATETIME,
	NumberOfOrders INT NOT NULL 
)
GO
CREATE TABLE Users
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	DisplayName NVARCHAR(128) NOT NULL,
	Phone nvarchar(128),
	Birthday DATETIME NOT NULL,
	UserName NVARCHAR(128) NOT NULL,
	Password NVARCHAR(128) NOT NULL,
	Managers BIT NOT NULL	
)
GO

CREATE TABLE Promotions
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
    StartTime DATETIME NOT NULL,
	EndTime DATETIME NOT NULL,
	Discount FLOAT NOT NULL,
	DisplayName NVARCHAR(128) NOT NULL
)
GO

CREATE TABLE Orders
(
	ID int IDENTITY(1,1) PRIMARY KEY,
	CreateDate DATETIME NOT NULL,
	Total_Amount MONEY,
	IDCustomer INT NOT NULL,
	Address NVARCHAR(128) NOT NULL,
	IDPromotions INT,
	FOREIGN KEY (IDCustomer) REFERENCES dbo.Customer(ID),
	FOREIGN KEY (IDPromotions) REFERENCES dbo.Promotions(ID)
)
GO

CREATE TABLE Combo
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	DisplayName NVARCHAR(128) NOT NULL,
	Price MONEY NOT NULL
)
GO 

CREATE TABLE ComboDetail
(
	STT INT IDENTITY(1,1) PRIMARY KEY,
	IDItems INT NOT NULL,
	Quantity INT NOT NULL,
	ID INT NOT NULL,
	FOREIGN KEY (ID) REFERENCES dbo.Combo(ID),
	FOREIGN KEY (IDItems) REFERENCES dbo.Items(ID)
)
GO

CREATE TABLE OrderDetail
(
	STT INT IDENTITY(1,1) PRIMARY KEY,
	ID INT NOT NULL,
	IDItems INT NOT NULL,
	Quantity INT NOT NULL,
	FOREIGN KEY (ID) REFERENCES dbo.Orders(ID),
	FOREIGN KEY (IDItems) REFERENCES dbo.Items(ID)
)
GO

CREATE TABLE OrderDetailCombo
(
	STT INT IDENTITY(1,1) PRIMARY KEY,
	ID INT NOT NULL,
	IDCombo INT NOT NULL,
	Quantity INT NOT NULL,
	FOREIGN KEY (ID) REFERENCES dbo.Orders(ID),
	FOREIGN KEY (IDCombo) REFERENCES dbo.Combo(ID)
)
GO