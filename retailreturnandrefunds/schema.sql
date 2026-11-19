
-- DATABASE SETUP
CREATE DATABASE retail_returns_refunds;

USE retail_returns_refunds;

-- 1. REGIONS
CREATE TABLE regions (
    region_id INT AUTO_INCREMENT PRIMARY KEY,
    region_name VARCHAR(50) NOT NULL
);

-- 2. STORES
CREATE TABLE stores (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    region_id INT NOT NULL,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

-- 3. EMPLOYEES
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    store_id INT NOT NULL,
    manager_id INT NULL,
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- 4. CUSTOMERS
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
);

-- 5. PRODUCTS
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL
);

-- 6. SALES
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    store_id INT NOT NULL,
    employee_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- 7. RETURNS
CREATE TABLE returns (
    return_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT NOT NULL,
    return_date DATE NOT NULL,
    return_quantity INT NOT NULL,
    return_reason VARCHAR(100),
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id)
);

-- 8. REFUNDS
CREATE TABLE refunds (
    refund_id INT AUTO_INCREMENT PRIMARY KEY,
    return_id INT NOT NULL,
    refund_date DATE NOT NULL,
    refund_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (return_id) REFERENCES returns(return_id)
);

-- DISPLAY TABLES
SHOW TABLES;

USE retail_returns_refunds;

-- 1. REGIONS
INSERT INTO regions (region_name) VALUES
('North'),
('South'),
('West');

-- 2. STORES
INSERT INTO stores (store_name, region_id) VALUES
('Chennai Central', 2),
('Coimbatore Mall', 2),
('Mumbai Central', 3),
('Delhi Market', 1);

-- 3. EMPLOYEES
-- First insert managers
INSERT INTO employees (employee_name, store_id, manager_id) VALUES
('Anil', 1, NULL),
('Bala', 2, NULL),
('Charan', 3, NULL),
('Deepa', 4, NULL);

-- Then insert employees reporting to managers
INSERT INTO employees (employee_name, store_id, manager_id) VALUES
('Priya', 1, 1),
('Rahul', 1, 1),
('Sneha', 2, 2),
('Karthik', 3, 3),
('Divya', 4, 4);

-- 4. CUSTOMERS
INSERT INTO customers (customer_name, city) VALUES
('Arun', 'Chennai'),
('Meena', 'Coimbatore'),
('Ravi', 'Mumbai'),
('Sneha', 'Delhi'),
('Kiran', 'Chennai'),
('Divya', 'Mumbai'),
('Vijay', 'Coimbatore'),
('Priya', 'Delhi');

-- 5. PRODUCTS
INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 50000),
('Mobile', 'Electronics', 20000),
('Headphones', 'Accessories', 3000),
('Keyboard', 'Accessories', 1500),
('Chair', 'Furniture', 5000),
('Table', 'Furniture', 8000);

-- 6. SALES
INSERT INTO sales
(customer_id, product_id, store_id, employee_id, sale_date, quantity, unit_price)
VALUES
(1, 1, 1, 5, '2026-01-05', 2, 50000),
(2, 2, 2, 7, '2026-01-06', 3, 20000),
(3, 3, 3, 8, '2026-01-07', 5, 3000),
(4, 4, 4, 9, '2026-01-08', 4, 1500),
(5, 5, 1, 6, '2026-01-09', 2, 5000),
(6, 1, 3, 8, '2026-01-10', 1, 50000),
(7, 2, 2, 7, '2026-01-11', 2, 20000),
(8, 3, 4, 9, '2026-01-12', 4, 3000),
(1, 4, 1, 5, '2026-01-13', 3, 1500),
(2, 5, 2, 7, '2026-01-14', 1, 5000),
(3, 6, 3, 8, '2026-01-15', 2, 8000),
(4, 1, 4, 9, '2026-01-16', 1, 50000);

-- 7. RETURNS
INSERT INTO returns
(sale_id, return_date, return_quantity, return_reason)
VALUES
(1, '2026-01-08', 1, 'Damaged product'),
(2, '2026-01-09', 1, 'Wrong item'),
(3, '2026-01-10', 2, 'Product issue'),
(4, '2026-01-11', 1, 'Not satisfied'),
(6, '2026-01-13', 1, 'Damaged product'),
(8, '2026-01-15', 2, 'Wrong item');

-- 8. REFUNDS
INSERT INTO refunds
(return_id, refund_date, refund_amount)
VALUES
(1, '2026-01-09', 50000),
(2, '2026-01-10', 20000),
(4, '2026-01-12', 1500),
(5, '2026-01-14', 50000);

-- DISPLAY ALL TABLES
SELECT * FROM regions;
SELECT * FROM stores;
SELECT * FROM employees;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM sales;
SELECT * FROM returns;
SELECT * FROM refunds;
SHOW TABLES;