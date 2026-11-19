USE retail_returns_refunds;

-- ANY: Compare refund amount with at least one other store
SELECT
    st.store_name,
    rg.region_name,
    COALESCE(SUM(rf.refund_amount), 0) AS total_refund
FROM stores st
JOIN regions rg ON st.region_id = rg.region_id
LEFT JOIN sales s ON st.store_id = s.store_id
LEFT JOIN returns r ON s.sale_id = r.sale_id
LEFT JOIN refunds rf ON r.return_id = rf.return_id
GROUP BY st.store_id, st.store_name, rg.region_id, rg.region_name
HAVING total_refund > ANY (
    SELECT COALESCE(SUM(rf2.refund_amount), 0)
    FROM stores st2
    LEFT JOIN sales s2 ON st2.store_id = s2.store_id
    LEFT JOIN returns r2 ON s2.sale_id = r2.sale_id
    LEFT JOIN refunds rf2 ON r2.return_id = rf2.return_id
    WHERE st2.region_id = st.region_id
      AND st2.store_id <> st.store_id
    GROUP BY st2.store_id
);

-- ALL: Compare refund amount with every other store
SELECT
    st.store_name,
    rg.region_name,
    COALESCE(SUM(rf.refund_amount), 0) AS total_refund
FROM stores st
JOIN regions rg ON st.region_id = rg.region_id
LEFT JOIN sales s ON st.store_id = s.store_id
LEFT JOIN returns r ON s.sale_id = r.sale_id
LEFT JOIN refunds rf ON r.return_id = rf.return_id
GROUP BY st.store_id, st.store_name, rg.region_id, rg.region_name
HAVING total_refund > ALL (
    SELECT COALESCE(SUM(rf2.refund_amount), 0)
    FROM stores st2
    LEFT JOIN sales s2 ON st2.store_id = s2.store_id
    LEFT JOIN returns r2 ON s2.sale_id = r2.sale_id
    LEFT JOIN refunds rf2 ON r2.return_id = rf2.return_id
    WHERE st2.region_id = st.region_id
      AND st2.store_id <> st.store_id
    GROUP BY st2.store_id
);