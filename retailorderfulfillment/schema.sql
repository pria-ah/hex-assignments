
CREATE DATABASE retail_order_fulfilment;

USE retail_order_fulfilment;


-- 1. CUSTOMERS TABLE
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50)
);


-- 2. SUPPLIERS TABLE
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15)
);


-- 3. PRODUCTS TABLE
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    supplier_id INT,
    cost_price DECIMAL(10,2) NOT NULL,
    selling_price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    reorder_level INT NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    CHECK (cost_price >= 0),
    CHECK (selling_price >= 0),
    CHECK (stock_quantity >= 0)
);


-- 4. ORDERS TABLE
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(30) UNIQUE,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(30) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


-- 5. ORDER ITEMS TABLE
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    CHECK (quantity > 0)
);


-- 6. FOLLOW-UP TABLE
CREATE TABLE follow_ups (
    followup_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    followup_date DATE NOT NULL,
    remarks VARCHAR(255),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


-- CUSTOMERS
INSERT INTO customers (customer_name, email, city) VALUES
('Arun', 'arun@gmail.com', 'Chennai'),
('Priya', 'priya@gmail.com', 'Coimbatore'),
('Rahul', 'rahul@gmail.com', 'Bangalore'),
('Sneha', 'sneha@gmail.com', 'Mumbai');


-- SUPPLIERS
INSERT INTO suppliers (supplier_name, contact_number) VALUES
('ABC Suppliers', '9876543210'),
('XYZ Traders', '9876501234'),
('Global Distributors', '9876512345');


-- PRODUCTS
INSERT INTO products
(product_name, supplier_id, cost_price, selling_price,
 stock_quantity, reorder_level)
VALUES
('Laptop', 1, 35000, 45000, 5, 10),
('Mobile', 2, 12000, 18000, 25, 10),
('Keyboard', 1, 500, 800, 8, 15),
('Mouse', 3, 250, 500, 30, 10),
('Monitor', 2, 7000, 10000, 4, 8),
('Printer', 3, 5000, 7500, 20, 5);


-- ORDERS
INSERT INTO orders
(order_number, customer_id, order_date, status)
VALUES
('ORD-000001', 1, DATE_SUB(CURDATE(), INTERVAL 5 DAY), 'Pending'),
('ORD-000002', 2, DATE_SUB(CURDATE(), INTERVAL 2 DAY), 'Pending'),
('ORD-000003', 3, CURDATE(), 'Completed'),
('ORD-000004', 4, DATE_SUB(CURDATE(), INTERVAL 7 DAY), 'Pending');


-- ORDER ITEMS
INSERT INTO order_items
(order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 45000),
(1, 2, 2, 18000),
(2, 3, 3, 800),
(3, 4, 2, 500),
(4, 5, 1, 10000);


SELECT * FROM customers;
SELECT * FROM suppliers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM follow_ups;

SHOW TABLES;
