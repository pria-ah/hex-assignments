
USE retail_order_fulfilment;

DELIMITER //

CREATE PROCEDURE sp_place_order(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    OUT p_order_id INT
)
BEGIN
    DECLARE v_stock INT;
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_order_number VARCHAR(30);

    -- ERROR HANDLER
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- VALIDATE CUSTOMER
    IF NOT EXISTS (
        SELECT 1 FROM customers
        WHERE customer_id = p_customer_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Customer does not exist';
    END IF;

    -- GET PRODUCT STOCK AND PRICE
    SELECT stock_quantity, selling_price
    INTO v_stock, v_price
    FROM products
    WHERE product_id = p_product_id
    FOR UPDATE;

    -- VALIDATE QUANTITY
    IF p_quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantity must be greater than zero';
    END IF;

    -- CHECK STOCK AVAILABILITY
    IF v_stock < p_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock available';
    END IF;

    -- GENERATE ORDER NUMBER
    SET v_order_number =
        CONCAT('ORD-', UUID_SHORT());

    -- INSERT ORDER
    INSERT INTO orders
    (order_number, customer_id, order_date, status)
    VALUES
    (v_order_number, p_customer_id, CURDATE(), 'Pending');

    SET p_order_id = LAST_INSERT_ID();

    -- INSERT ORDER ITEM
    INSERT INTO order_items
    (order_id, product_id, quantity, unit_price)
    VALUES
    (p_order_id, p_product_id, p_quantity, v_price);

    -- REDUCE PRODUCT STOCK
    UPDATE products
    SET stock_quantity = stock_quantity - p_quantity
    WHERE product_id = p_product_id;

    COMMIT;

END //

DELIMITER ;

CALL sp_place_order(1, 2, 2, @new_order_id);

-- DISPLAY OUTPUT PARAMETER
SELECT @new_order_id AS New_Order_ID;

-- CHECK ORDER DETAILS
SELECT * FROM orders;

SELECT * FROM order_items;

-- CHECK UPDATED STOCK
SELECT * FROM products;
