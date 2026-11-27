
CREATE DATABASE retail_inventory_reservation;
USE retail_inventory_reservation;
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2),
    stock_quantity INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
); 

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
); 


USE retail_inventory_reservation;

INSERT INTO Categories VALUES
(1, 'Electronics'),
(2, 'Accessories'),
(3, 'Home Appliances');

INSERT INTO Products VALUES
(101, 'Laptop', 1, 50000, 20),
(102, 'Mobile', 1, 20000, 35),
(103, 'Keyboard', 2, 800, 10),
(104, 'Mouse', 2, 500, 25),
(105, 'Washing Machine', 3, 30000, 8),
(106, 'Refrigerator', 3, 40000, 15);

INSERT INTO Customers VALUES
(1, 'Arun', 'arun@gmail.com'),
(2, 'Priya', 'priya@gmail.com'),
(3, 'Rahul', 'rahul@gmail.com'),
(4, 'Sneha', 'sneha@gmail.com');

INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, '2026-01-10', 'Completed'),
(2, '2026-01-20', 'Completed'),
(3, '2026-02-05', 'Completed'),
(1, '2026-02-15', 'Completed'),
(4, '2026-03-10', 'Completed'),
(2, '2026-03-20', 'Completed');

INSERT INTO Order_Items
(order_id, product_id, quantity, unit_price) VALUES
(1, 101, 2, 50000),
(1, 103, 3, 800),
(2, 102, 2, 20000),
(3, 101, 1, 50000),
(3, 104, 4, 500),
(4, 105, 1, 30000),
(5, 102, 3, 20000),
(6, 106, 2, 40000);

SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Order_Items;

