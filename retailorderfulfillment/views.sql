
USE retail_order_fulfilment;

-- =====================================
-- TASK 1: CREATE TWO VIEWS
-- =====================================

-- 1. CREATE ORDER SUMMARY VIEW

CREATE VIEW vw_order_summary AS
SELECT
    o.order_id,
    o.order_number,
    c.customer_name,
    o.order_date,
    o.status,
    COUNT(oi.order_item_id) AS total_items,
    SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    o.order_number,
    c.customer_name,
    o.order_date,
    o.status;

SELECT * FROM vw_order_summary;


-- 2. CREATE LOW STOCK VIEW

CREATE VIEW vw_low_stock AS
SELECT
    product_id,
    product_name,
    stock_quantity,
    reorder_level
FROM products
WHERE stock_quantity <= reorder_level
WITH CHECK OPTION;

SELECT * FROM vw_low_stock;


-- 3. DEMONSTRATE UPDATABLE VIEW WITH CHECK OPTION

-- Update stock through the view
UPDATE vw_low_stock
SET stock_quantity = 6
WHERE product_id = 1;

-- Verify updated view
SELECT * FROM vw_low_stock;

-- Verify original products table
SELECT * FROM products;

-- Test CHECK OPTION (expected to fail)
UPDATE vw_low_stock
SET stock_quantity = 15
WHERE product_id = 1;
