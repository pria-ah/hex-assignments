
USE retail_order_fulfilment;

DROP PROCEDURE IF EXISTS sp_validate_order;

DELIMITER //

CREATE PROCEDURE sp_validate_order(
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_stock INT DEFAULT 0;
    DECLARE v_count INT DEFAULT 0;

    SELECT COUNT(*), COALESCE(MAX(stock_quantity), 0)
    INTO v_count, v_stock
    FROM products
    WHERE product_id = p_product_id;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Product does not exist';

    ELSEIF p_quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid quantity';

    ELSEIF p_quantity > v_stock THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock';

    ELSE
        SELECT 'Order validation successful' AS Message;
    END IF;

END//

DELIMITER ;
CALL sp_validate_order(2, 2);
CALL sp_validate_order(1, 100);
CALL sp_validate_order(2, 0);
CALL sp_validate_order(100, 2);