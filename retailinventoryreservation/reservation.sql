
USE retail_inventory_reservation;

DROP PROCEDURE IF EXISTS sp_reserve_stock;

DELIMITER $$

CREATE PROCEDURE sp_reserve_stock(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_stock INT;
    DECLARE v_price DECIMAL(10,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS (
        SELECT customer_id
        FROM Customers
        WHERE customer_id = p_customer_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Customer does not exist';
    END IF;

    SELECT stock_quantity, price
    INTO v_stock, v_price
    FROM Products
    WHERE product_id = p_product_id
    FOR UPDATE;

    IF v_stock IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Product does not exist';

    ELSEIF p_quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid quantity';

    ELSEIF v_stock < p_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock. Order cancelled';
    END IF;

    INSERT INTO Orders (customer_id, order_date, status)
    VALUES (p_customer_id, CURDATE(), 'Completed');

    SET @new_order_id = LAST_INSERT_ID();

    INSERT INTO Order_Items
    (order_id, product_id, quantity, unit_price)
    VALUES
    (@new_order_id, p_product_id, p_quantity, v_price);

    UPDATE Products
    SET stock_quantity = stock_quantity - p_quantity
    WHERE product_id = p_product_id;

    COMMIT;
END$$

DELIMITER ;

-- Test 1: Successful reservation
CALL sp_reserve_stock(1, 101, 2);

SELECT * FROM Orders;
SELECT * FROM Order_Items;
SELECT * FROM Products WHERE product_id = 101;

-- Test 2: Insufficient stock (expected error)
CALL sp_reserve_stock(2, 101, 100);

-- Test 3: Verify rollback
SELECT * FROM Products WHERE product_id = 101;
SELECT * FROM Orders;
SELECT * FROM Order_Items;
