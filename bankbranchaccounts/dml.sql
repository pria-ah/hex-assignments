USE bank_branch_accounts;

-- 1. INSERT: Add a new customer
INSERT INTO customers (customer_name, address)
VALUES ('Meena', 'Erode');

SELECT * FROM customers;


-- 2. UPDATE: Update customer address
UPDATE customers
SET address = 'Salem'
WHERE customer_name = 'Meena';

SELECT * FROM customers
WHERE customer_name = 'Meena';


-- 3. DELETE: Delete a specific customer
DELETE FROM customers
WHERE customer_name = 'Meena';

SELECT * FROM customers;


-- 4. AND: Both conditions must be true
SELECT * FROM accounts
WHERE balance > 20000 AND branch_id = 1;


-- 5. OR: At least one condition must be true
SELECT * FROM accounts
WHERE branch_id = 1 OR branch_id = 2;


-- 6. IN: Match any value in the given list
SELECT * FROM accounts
WHERE account_type_id IN (1, 2);


-- 7. BETWEEN: Find values within a range
SELECT * FROM accounts
WHERE balance BETWEEN 20000 AND 50000;


-- 8. LIKE: Search using a pattern
SELECT * FROM customers
WHERE customer_name LIKE 'A%';