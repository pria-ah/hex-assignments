USE bank_branch_accounts;

-- 1. DELETE: Remove customer 6 and related records
DELETE FROM account_holders
WHERE customer_id = 6;

DELETE FROM accounts
WHERE customer_id = 6;

DELETE FROM customers
WHERE customer_id = 6;


-- 2. ROLLBACK: Demonstrate rollback
START TRANSACTION;

DELETE FROM account_holders
WHERE customer_id = 5;

DELETE FROM accounts
WHERE customer_id = 5;

DELETE FROM customers
WHERE customer_id = 5;

ROLLBACK;

-- Check whether customer 5 is restored
SELECT * FROM customers;
SELECT * FROM accounts;
SELECT * FROM account_holders;


-- 3. AUTO_INCREMENT: Insert a new customer
INSERT INTO customers (customer_name, address)
VALUES ('Vikram', 'Salem');

SELECT * FROM customers;


-- 4. TRUNCATE: Create and test a temporary table
CREATE TABLE temp_accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    account_name VARCHAR(50)
);

INSERT INTO temp_accounts (account_name)
VALUES
('Test Account 1'),
('Test Account 2');

SELECT * FROM temp_accounts;

TRUNCATE TABLE temp_accounts;

SELECT * FROM temp_accounts;


-- 5. DROP: Remove the temporary table
DROP TABLE temp_accounts;

SHOW TABLES LIKE 'temp_accounts';
