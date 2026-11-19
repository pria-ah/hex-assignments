
USE retail_returns_refunds;

-- 1. Products with a return rate above 10%
SELECT
    p.product_id,
    p.product_name,
    SUM(s.quantity) AS total_sold,
    COALESCE(SUM(r.return_quantity), 0) AS total_returned,
    ROUND(
        COALESCE(SUM(r.return_quantity), 0) * 100.0 /
        NULLIF(SUM(s.quantity), 0), 2
    ) AS return_rate
FROM products p
JOIN sales s ON p.product_id = s.product_id
LEFT JOIN returns r ON s.sale_id = r.sale_id
GROUP BY p.product_id, p.product_name
HAVING return_rate > 10;


-- 2. Customers with returns but no refunds
SELECT DISTINCT
    c.customer_id,
    c.customer_name
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
JOIN returns r ON s.sale_id = r.sale_id
WHERE NOT EXISTS (
    SELECT 1
    FROM refunds rf
    WHERE rf.return_id = r.return_id
);


-- 3. Stores with the highest refund value
SELECT
    st.store_id,
    st.store_name,
    SUM(rf.refund_amount) AS total_refund
FROM stores st
JOIN sales s ON st.store_id = s.store_id
JOIN returns r ON s.sale_id = r.sale_id
JOIN refunds rf ON r.return_id = rf.return_id
GROUP BY st.store_id, st.store_name
ORDER BY total_refund DESC
LIMIT 1;


-- 4. Total number of returns for each product
SELECT
    p.product_name,
    COALESCE(SUM(r.return_quantity), 0) AS total_returned
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
LEFT JOIN returns r ON s.sale_id = r.sale_id
GROUP BY p.product_id, p.product_name
ORDER BY total_returned DESC;


-- 5. Customers who have returned more than one item
SELECT
    c.customer_id,
    c.customer_name,
    SUM(r.return_quantity) AS total_returned
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
JOIN returns r ON s.sale_id = r.sale_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(r.return_quantity) > 1;


-- 6. Total refund amount for each region
SELECT
    rg.region_name,
    COALESCE(SUM(rf.refund_amount), 0) AS total_refund
FROM regions rg
JOIN stores st ON rg.region_id = st.region_id
LEFT JOIN sales s ON st.store_id = s.store_id
LEFT JOIN returns r ON s.sale_id = r.sale_id
LEFT JOIN refunds rf ON r.return_id = rf.return_id
GROUP BY rg.region_id, rg.region_name;


-- 7. Employees and their managers
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.employee_id;


-- 8. Return count by return reason
SELECT
    return_reason,
    COUNT(*) AS total_returns
FROM returns
GROUP BY return_reason
ORDER BY total_returns DESC;


-- 9. Stores with more than one return
SELECT
    st.store_name,
    COUNT(r.return_id) AS total_returns
FROM stores st
JOIN sales s ON st.store_id = s.store_id
JOIN returns r ON s.sale_id = r.sale_id
GROUP BY st.store_id, st.store_name
HAVING COUNT(r.return_id) > 1;


-- 10. Total sales value and refund value for each store
SELECT
    st.store_name,
    SUM(s.quantity * s.unit_price) AS total_sales,
    COALESCE(SUM(refund_data.refund_amount), 0) AS total_refunds
FROM stores st
JOIN sales s ON st.store_id = s.store_id
LEFT JOIN (
    SELECT
        s.sale_id,
        s.store_id,
        rf.refund_amount
    FROM sales s
    JOIN returns r ON s.sale_id = r.sale_id
    JOIN refunds rf ON r.return_id = rf.return_id
) AS refund_data
ON s.sale_id = refund_data.sale_id
GROUP BY st.store_id, st.store_name;
