USE retail_returns_refunds;

-- 1. Index on sales customer_id
CREATE INDEX idx_sales_customer
ON sales(customer_id);

-- 2. Index on sales product_id
CREATE INDEX idx_sales_product
ON sales(product_id);

-- 3. Index on sales store_id
CREATE INDEX idx_sales_store
ON sales(store_id);

-- 4. Index on returns sale_id
CREATE INDEX idx_returns_sale
ON returns(sale_id);

-- 5. Index on refunds return_id
CREATE INDEX idx_refunds_return
ON refunds(return_id);

-- 6. Index on sales sale_date
CREATE INDEX idx_sales_date
ON sales(sale_date);

-- Check indexes
SHOW INDEX FROM sales;
SHOW INDEX FROM returns;
SHOW INDEX FROM refunds;

EXPLAIN
SELECT *
FROM sales
WHERE customer_id = 1;

EXPLAIN
SELECT *
FROM returns
WHERE sale_id = 1;