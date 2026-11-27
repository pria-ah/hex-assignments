
USE retail_inventory_reservation;

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.stock_quantity,
    (
        SELECT AVG(p2.stock_quantity)
        FROM Products p2
        WHERE p2.category_id = p.category_id
    ) AS category_avg_stock
FROM Products p
JOIN Categories c
    ON p.category_id = c.category_id
WHERE p.stock_quantity < (
    SELECT AVG(p2.stock_quantity)
    FROM Products p2
    WHERE p2.category_id = p.category_id
);
