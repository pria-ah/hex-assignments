CREATE DATABASE bank_branch_accounts;

USE bank_branch_accounts;

USE bank_branch_accounts;

-- 1. Relationship Managers
CREATE TABLE relationship_managers (
    manager_id INT AUTO_INCREMENT PRIMARY KEY,
    manager_name VARCHAR(100) NOT NULL
);

-- 2. Branches
CREATE TABLE branches (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    manager_id INT NOT NULL,

    FOREIGN KEY (manager_id)
    REFERENCES relationship_managers(manager_id)
);

-- 3. Account Types
CREATE TABLE account_types (
    account_type_id INT AUTO_INCREMENT PRIMARY KEY,
    account_type VARCHAR(30) NOT NULL UNIQUE,

    CHECK (
        account_type IN (
            'Savings',
            'Current',
            'Fixed Deposit',
            'Recurring Deposit'
        )
    )
);

-- 4. Customers
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- 5. Accounts
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    account_number VARCHAR(20) NOT NULL UNIQUE,
    customer_id INT NOT NULL,
    account_type_id INT NOT NULL,
    branch_id INT NOT NULL,
    balance DECIMAL(15,2) NOT NULL,

    CHECK (balance >= 0),

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id),

    FOREIGN KEY (account_type_id)
    REFERENCES account_types(account_type_id),

    FOREIGN KEY (branch_id)
    REFERENCES branches(branch_id)
);

-- 6. Account Holders
CREATE TABLE account_holders (
    account_id INT,
    customer_id INT,

    PRIMARY KEY (account_id, customer_id),

    FOREIGN KEY (account_id)
    REFERENCES accounts(account_id),

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

USE bank_branch_accounts;

SHOW TABLES;

USE bank_branch_accounts;

-- 1. Insert Relationship Managers

INSERT INTO relationship_managers (manager_name) VALUES
('Ravi'),
('Kumar'),
('Suresh'),
('Anitha');


-- 2. Insert Branches

INSERT INTO branches (branch_name, manager_id) VALUES
('Chennai', 1),
('Mumbai', 2),
('Bangalore', 3),
('Coimbatore', 4);


-- 3. Insert Account Types

INSERT INTO account_types (account_type) VALUES
('Savings'),
('Current'),
('Fixed Deposit'),
('Recurring Deposit');


-- 4. Insert Customers

INSERT INTO customers (customer_name, address) VALUES
('Arun', 'Chennai'),
('Priya', 'Mumbai'),
('Rahul', 'Bangalore'),
('Sneha', 'Coimbatore'),
('Karthik', 'Chennai'),
('Divya', 'Mumbai');


-- 5. Insert Accounts

INSERT INTO accounts
(account_number, customer_id, account_type_id, branch_id, balance)
VALUES
('10001', 1, 1, 1, 25000.00),
('10002', 2, 2, 2, 50000.00),
('10003', 1, 1, 1, 15000.00),
('10004', 3, 2, 3, 75000.00),
('10005', 4, 3, 4, 100000.00),
('10006', 5, 1, 1, 30000.00),
('10007', 6, 4, 2, 12000.00);


-- 6. Insert Account Holders

INSERT INTO account_holders VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3),
(5, 4),
(6, 5),
(7, 6);


-- DISPLAY ALL TABLES

SELECT * FROM relationship_managers;
SELECT * FROM branches;
SELECT * FROM account_types;
SELECT * FROM customers;
SELECT * FROM accounts;
SELECT * FROM account_holders;
