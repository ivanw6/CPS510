-- Assignment 3 Tables
-- Group 9

-- Ivan Wang
-- Ethan Soosaipillai
-- Hareesh Suresh
 
-- Create Promotion table
CREATE TABLE Promotion (
    PromotionID INT PRIMARY KEY,
    DiscountAmount DECIMAL(10, 2) NOT NULL,
    Description VARCHAR(255),
    StartDate VARCHAR(255),
    EndDate VARCHAR(255)
);

-- Create Supplier table
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    ContactPerson VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(20)
);

-- Create Manager table
CREATE TABLE Manager (
    ManagerID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(20),
    UNIQUE (Phone)
);

-- Create Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(20),
    LoyaltyPoints INT DEFAULT 0,
    UNIQUE (Phone),
    UNIQUE (Email)
);

-- Create Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Role VARCHAR(255) NOT NULL,
    Shift VARCHAR(255),
    PerformanceScore FLOAT DEFAULT 0,
    ManagerID INT, -- foreign key
    FOREIGN KEY (ManagerID) REFERENCES Manager(ManagerID)
);

-- Create Product table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Category VARCHAR(255),
    StockLevel INT DEFAULT 0,
    Price FLOAT DEFAULT 0.00 NOT NULL,
    Barcode VARCHAR(255) NOT NULL,
    UNIQUE (Barcode),
    SupplierID INT, -- foreign key
    PromotionID INT, -- foreign key
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (PromotionID) REFERENCES Promotion(PromotionID)
);

-- Create Transaction table
CREATE TABLE Transaction (
    TransactionID INT PRIMARY KEY,
    Timestamp TIMESTAMP,
    PaymentMethod VARCHAR(255),
    TotalAmount FLOAT NOT NULL,
    CustomerID INT, -- foreign key
    EmployeeID INT, -- foreign key
    ProductID INT, -- foreign key
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


DROP TABLE Product;
DROP TABLE Customer;
DROP TABLE Manager;
DROP TABLE Employee;
DROP TABLE Promotion;
DROP TABLE Transaction;
DROP TABLE Supplier;