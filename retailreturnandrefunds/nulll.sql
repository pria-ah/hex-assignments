
USE retail_returns_refunds;

-- STEP 1: Create a temporary table
CREATE TEMPORARY TABLE refund_check (
    return_id INT
);

-- STEP 2: Insert values including NULL
INSERT INTO refund_check VALUES
(1),
(2),
(NULL);

-- STEP 3: Demonstrate the NOT IN problem
SELECT *
FROM returns
WHERE return_id NOT IN (
    SELECT return_id
    FROM refund_check
);

-- STEP 4: Correct the query using NOT EXISTS
SELECT r.*
FROM returns r
WHERE NOT EXISTS (
    SELECT 1
    FROM refund_check rc
    WHERE rc.return_id = r.return_id
);

-- STEP 5: Remove the temporary table
DROP TEMPORARY TABLE refund_check;
