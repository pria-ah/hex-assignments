
USE retail_order_fulfilment;

DELIMITER //

CREATE PROCEDURE sp_process_pending_orders()
BEGIN
    DECLARE v_order_id INT;
    DECLARE v_done INT DEFAULT 0;

    -- Declare cursor
    DECLARE order_cursor CURSOR FOR
        SELECT order_id
        FROM orders
        WHERE status = 'Pending';

    -- Handle end of cursor records
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_done = 1;

    -- Open cursor
    OPEN order_cursor;

    order_loop: LOOP

        -- Fetch one order ID
        FETCH order_cursor INTO v_order_id;

        IF v_done = 1 THEN
            LEAVE order_loop;
        END IF;

        -- Update each pending order
        UPDATE orders
        SET status = 'Processing'
        WHERE order_id = v_order_id;

    END LOOP;

    -- Close cursor
    CLOSE order_cursor;

END //

DELIMITER ;


-- CALL THE CURSOR PROCEDURE
CALL sp_process_pending_orders();

-- DISPLAY UPDATED ORDERS
SELECT * FROM orders;

-- Reset pending orders for comparison
UPDATE orders
SET status = 'Pending'
WHERE status = 'Processing';

-- Update all pending orders in one statement
UPDATE orders
SET status = 'Processing'
WHERE status = 'Pending';

-- DISPLAY RESULTS
SELECT * FROM orders;
