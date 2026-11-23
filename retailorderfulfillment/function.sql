
USE retail_order_fulfilment;

DELIMITER //

CREATE FUNCTION fn_calculate_tax(
    p_amount DECIMAL(10,2),
    p_tax_rate DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_tax DECIMAL(10,2);

    SET v_tax = p_amount * p_tax_rate / 100;

    RETURN v_tax;
END //

DELIMITER ;


SELECT fn_calculate_tax(10000, 18) AS Tax_Amount;

-- CALCULATE TOTAL INCLUDING TAX
SELECT
    10000 AS Amount,
    fn_calculate_tax(10000, 18) AS Tax,
    10000 + fn_calculate_tax(10000, 18) AS Total_Amount;
