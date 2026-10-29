Create database ecommerce ;
use ecommerce ;


 
create table customers (
    customerid int primary key auto_increment,
    customername varchar(100),
    email varchar(100) unique,
    city varchar(50)
);

create table products (
    productid int primary key auto_increment,
    productname varchar(100),
    category varchar(50),
    price decimal(10,2),
    stockquantity int default 0
);

create table orders (
    orderid int primary key auto_increment,
    customerid int,
    orderdate date,
    status varchar(20),
    foreign key (customerid) references customers(customerid)
);

create table orderdetails (
    orderdetailid int primary key auto_increment,
    orderid int,
    productid int,
    quantity int,
    unitprice decimal(10,2),
    foreign key (orderid) references orders(orderid),
    foreign key (productid) references products(productid)
);

insert into customers (customername, email, city)
values
('Amit Sharma', 'amit@gmail.com', 'Mumbai'),
('Priya Patil', 'priya@gmail.com', 'Pune'),
('Rahul Verma', 'rahul@gmail.com', 'Nashik'),
('Sneha Joshi', 'sneha@gmail.com', 'Thane'),
('Vikas Shah', 'vikas@gmail.com', 'Indore');



 

INSERT INTO Products
    (ProductID, ProductName, Category, Price, StockQuantity)
VALUES
    (1, 'Laptop', 'Electronics', 55000.00, 12),
    (2, 'Wireless Mouse', 'Electronics', 800.00, 75),
    (3, 'Keyboard', 'Electronics', 2500.00, 35),
    (4, 'Monitor', 'Electronics', 12000.00, 18),
    (5, 'USB-C Hub', 'Electronics', 2200.00, 40),
    (6, 'Office Chair', 'Furniture', 7500.00, 14),
    (7, 'Study Desk', 'Furniture', 12000.00, 9),
    (8, 'Bookshelf', 'Furniture', 6500.00, 11),
    (9, 'Notebook Pack', 'Stationery', 250.00, 120),
    (10, 'Pen Pack', 'Stationery', 120.00, 200);
    

 
INSERT INTO Orders (CustomerID, OrderDate, Status)
VALUES
(1, '2026-10-01', 'Delivered'),
(2, '2026-10-03', 'Pending'),
(3, '2026-10-05', 'Shipped'),
(1, '2026-10-10', 'Delivered'),
(5, '2026-10-15', 'Pending');


USE ecommerce;

INSERT INTO OrderDetails
    (OrderDetailID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
    (1, 1, 1, 1, 55000.00),
    (2, 1, 2, 2, 800.00),
    (3, 2, 3, 1, 2500.00),
    (4, 2, 4, 1, 12000.00),
    (5, 3, 5, 2, 2200.00),
    (6, 3, 6, 1, 7500.00),
    (7, 4, 7, 1, 12000.00),
    (8, 4, 9, 5, 250.00),
    (9, 5, 8, 1, 6500.00),
    (10, 5, 10, 3, 120.00);
 
 
 
SELECT * FROM Products;
select * from customers;
SELECT * FROM OrderDetails;
SELECT * FROM Orders;
 
 
SELECT ProductID, ProductName, Category, Price
FROM Products;

-- WHERE--
SELECT ProductID, ProductName, Category, Price
FROM Products
WHERE Category = 'Electronics'
  AND Price > 1000;
  
 create index idx_products_category_price
on products (category, price);


SELECT
    o.OrderID,
    c.CustomerName,
    c.City,
    o.OrderDate,
    o.Status
FROM Orders o
INNER JOIN Customers c
    ON o.CustomerID = c.CustomerID;
    
    SELECT
    o.OrderID,
    c.CustomerName,
    SUM(od.Quantity * od.UnitPrice) AS OrderTotal
FROM Orders o
INNER JOIN Customers c
    ON o.CustomerID = c.CustomerID
INNER JOIN OrderDetails od
    ON o.OrderID = od.OrderID
GROUP BY
    o.OrderID,
    c.CustomerName;
    
    USE ecommerce;

SELECT
    p.Category,
    SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Products p
INNER JOIN OrderDetails od
    ON p.ProductID = od.ProductID
GROUP BY p.Category
ORDER BY TotalSales DESC;

-- checking index 
SHow index from  Customers;
Show index from Products;
Show index from Orders;
Show index from OrderDetails;


--  Check your current table structure-- 
SHOW CREATE TABLE Products;
ALTER TABLE Products
ADD CONSTRAINT chk_product_price
CHECK (Price >= 0);

ALTER TABLE Products
ADD CONSTRAINT chk_product_stock
CHECK (StockQuantity >= 0);

INSERT INTO Products
    (ProductName, Category, Price, StockQuantity)
VALUES
    ('Test Product', 'Testing', -100.00, 10);
 