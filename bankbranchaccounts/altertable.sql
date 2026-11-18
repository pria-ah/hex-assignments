USE bank_branch_accounts;

-- 1. ADD COLUMN: Add email to customers
ALTER TABLE customers
ADD email VARCHAR(100);

-- 2. ADD COLUMN: Add phone number to customers
ALTER TABLE customers
ADD phone VARCHAR(15);

-- 3. RENAME TABLE: Rename relationship_managers
ALTER TABLE relationship_managers
RENAME TO bank_managers;

-- 4. MODIFY COLUMN: Change email column size
ALTER TABLE customers
MODIFY email VARCHAR(150);

-- 5. DROP COLUMN: Remove phone column
ALTER TABLE customers
DROP COLUMN phone;

-- 6. RENAME TABLE: Change the table name back
ALTER TABLE bank_managers
RENAME TO relationship_managers;

-- Display final table structures
DESCRIBE customers;
DESCRIBE relationship_managers;

-- Display all tables
SHOW TABLES;