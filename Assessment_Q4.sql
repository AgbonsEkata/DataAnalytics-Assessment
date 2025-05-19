-- Q4: Customer Lifetime Value (CLV) Estimation
-- Goal: Estimate customer CLV based on transaction volume and tenure.

WITH customer_stats AS (
    -- Step 1: Calculate stats per customer
    SELECT 
        u.id AS customer_id,
        CONCAT(u.first_name, ' ', u.last_name) AS name,

        -- Tenure in months since signup
        TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE()) AS tenure_months,

        -- Total number of savings transactions
        COUNT(s.id) AS total_transactions,

        -- Total transaction value (in naira)
        SUM(s.confirmed_amount / 100.0) AS total_transaction_value

    FROM users_customuser u
    LEFT JOIN savings_savingsaccount s 
        ON u.id = s.owner_id
    GROUP BY 
        u.id, u.first_name, u.last_name, u.date_joined
)

-- Step 2: Calculate CLV using the provided formula
SELECT 
    customer_id,
    name,
    tenure_months,
    total_transactions,
    ROUND(
        (total_transactions / NULLIF(tenure_months, 0)) * 12 * 
        (0.001 * COALESCE(total_transaction_value, 0) / NULLIF(total_transactions, 0)), 
        2
    ) AS estimated_clv
FROM customer_stats
WHERE tenure_months > 0
ORDER BY estimated_clv DESC;