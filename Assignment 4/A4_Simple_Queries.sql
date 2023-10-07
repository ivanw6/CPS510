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
    Timestamp VARCHAR(255),
    PaymentMethod VARCHAR(255),
    TotalAmount FLOAT NOT NULL,
    CustomerID INT, -- foreign key
    EmployeeID INT, -- foreign key
    ProductID INT, -- foreign key
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Promotion Table Queries
/* 
    Query to retrieve distinct discount amounts 
    and promotionIDs, checks for discount amounts
    that are greater than 10, and orders by
    discount amount in ascending order
*/
SELECT DISTINCT DiscountAmount as "Discount", PromotionID as "Promotion ID"
FROM Promotion
WHERE DiscountAmount > 10
ORDER BY DiscountAmount ASC;

/*
    Query to retrieve distinct promotion ids
    and start and end dates then orders by 
    StartDate in descending order
*/
SELECT DISTINCT PromotionID as "Promotion ID", StartDate as "Start Date", EndDate as "End Date"
FROM Promotion 
ORDER BY StartDate DESC;

-- Supplier Table Queries
/*
    Query to retreive distinct company names and
    their contact person, order by company name
    in ascending order
*/
SELECT DISTINCT Name as "Company Name", ContactPerson as "Contact Person's Name"
FROM Supplier
ORDER BY Name ASC;

/*
    Query to retreive the contact name
    and count the number of suppliers for each
    contact person and order the results by
    the count in descending order
*/
SELECT ContactPerson as "Contact Person's Name", COUNT(*) as "Supplier Count"
FROM Supplier
GROUP BY ContactPerson
ORDER BY "Supplier Count" DESC;

-- Manager Table Queries
/*
    Query to retreive phone numbers and count
    the number of managers for each phone number
    and order the results by the count in descending
    order
*/
SELECT Phone as "Phone Number", COUNT(*) as "Manager Count"
FROM Manager
GROUP BY Phone
ORDER BY "Manager Count" DESC;

/*
    Query to retreive distinct manager emails and
    phone numbers and order by email in ascending
    order
*/
SELECT DISTINCT Email as "Email Address", Phone as "Phone Number"
FROM Manager
ORDER BY Email ASC;

-- Customer Table Queries
/*
    Query to count the number of customers with
    low loyalty where the condition is that if
    the number of loyalty points they have is
    less than 3000, then orders the results by
    the name in ascending order
*/
SELECT Name as "Customer Name", COUNT(*) as "Low Loyalty" 
FROM Customer
WHERE LoyaltyPoints < 3000
GROUP BY Name
ORDER BY Name ASC;

/*
    Query to retrieve distinct customer emails and
    phone numbers, and order them by phone number in
    ascending order
*/
SELECT DISTINCT Email as "Email Address", Phone as "Phone Number"
FROM Customer
ORDER BY Phone ASC;

-- Employee Table Queries
/*
    Query to calculate the average performance score
    for each role and order the results by the average
    score in descending order
*/
SELECT Role as "Employee Role", AVG(PerformanceScore) as "Average Performance Score"
FROM Employee
GROUP BY Role
ORDER BY "Average Performance Score" ASC;

/*
    Query to retrieve distinct employee roles and shifts
    then order them by role in ascending order
*/
SELECT DISTINCT Role as "Employee Role", Shift as "Shift Times"
FROM Employee
ORDER BY Role ASC;

-- Product Table Queries
/*
    Query to count the number of products in each
    category and order the results by the count
    in descending order
*/
SELECT Category as "Categories", COUNT(*) as "Product Count"
FROM Product
GROUP BY Category
ORDER BY "Product Count" DESC;

/*
    Query to retrieve distinct product names and
    prices and check for prices greater than $20.00
    then order the products by price in descending order
*/
SELECT DISTINCT Name as "Product Name", Price as "Price"
FROM Product
WHERE Price > 20.00
ORDER BY Price DESC;

-- Transaction Table Queries
/*
    Query to retrieve the payment method and calculate
    the total sales amount for each payment method and order
    the results by the total sales amount in ascending order
*/
SELECT PaymentMethod as "Payment Method", SUM(TotalAmount) as "Total Sales ($)"
FROM Transaction
GROUP BY PaymentMethod
ORDER BY "Total Sales ($)" ASC;

/*
    Query to retrieve distinct payment methods and total amounts
    and order the total amounts in desecending order
*/
SELECT DISTINCT PaymentMethod as "Payment Method", TotalAmount as "Total ($)"
FROM Transaction
ORDER BY TotalAmount DESC;

DROP TABLE Product;
DROP TABLE Customer;
DROP TABLE Manager;
DROP TABLE Employee;
DROP TABLE Promotion;
DROP TABLE Transaction;
DROP TABLE Supplier;