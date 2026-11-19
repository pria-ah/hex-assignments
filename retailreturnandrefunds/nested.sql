USE retail_returns_refunds;

SELECT
    customer_id,
    customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM sales
    WHERE product_id IN (
        SELECT product_id
        FROM products
        WHERE price > (
            SELECT AVG(price)
            FROM products
        )
    )
);


SELECT
    store_id,
    store_name
FROM stores
WHERE store_id IN (
    SELECT store_id
    FROM sales
    WHERE sale_id IN (
        SELECT sale_id
        FROM returns
        WHERE return_id IN (
            SELECT return_id
            FROM refunds
            WHERE refund_amount > (
                SELECT AVG(refund_amount)
                FROM refunds
            )
        )
    )
);