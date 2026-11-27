
USE retail_inventory_reservation;

WITH ProductSales AS (
    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        SUM(oi.quantity) AS total_quantity,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM Products p
    JOIN Categories c
        ON p.category_id = c.category_id
    JOIN Order_Items oi
        ON p.product_id = oi.product_id
    JOIN Orders o
        ON oi.order_id = o.order_id
    WHERE o.status = 'Completed'
    GROUP BY
        p.product_id,
        p.product_name,
        c.category_name
),
RankedProducts AS (
    SELECT
        product_id,
        product_name,
        category_name,
        total_quantity,
        total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY category_name
            ORDER BY total_sales DESC
        ) AS product_rank
    FROM ProductSales
)
SELECT
    product_id,
    product_name,
    category_name,
    total_quantity,
    total_sales,
    product_rank
FROM RankedProducts
WHERE product_rank <= 3
ORDER BY category_name, product_rank;



USE retail_inventory_reservation;

WITH MonthlySales AS (
    SELECT
        p.product_id,
        p.product_name,
        DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM Products p
    JOIN Order_Items oi
        ON p.product_id = oi.product_id
    JOIN Orders o
        ON oi.order_id = o.order_id
    WHERE o.status = 'Completed'
    GROUP BY
        p.product_id,
        p.product_name,
        DATE_FORMAT(o.order_date, '%Y-%m')
),
SalesComparison AS (
    SELECT
        product_id,
        product_name,
        sales_month,
        total_sales,
        LAG(total_sales) OVER (
            PARTITION BY product_id
            ORDER BY sales_month
        ) AS previous_month_sales,
        LEAD(total_sales) OVER (
            PARTITION BY product_id
            ORDER BY sales_month
        ) AS next_month_sales
    FROM MonthlySales
)
SELECT
    product_id,
    product_name,
    sales_month,
    total_sales,
    previous_month_sales,
    next_month_sales,
    total_sales - previous_month_sales AS sales_change
FROM SalesComparison
ORDER BY product_id, sales_month;
