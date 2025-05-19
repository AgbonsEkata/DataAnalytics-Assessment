-- Q3: Account Inactivity Alert
-- Goal: Identify active accounts (Savings or Investment) with no inflow transactions in the last 365 days.

WITH latest_transactions AS (
    -- Step 1: We get the latest transaction date per customer (owner_id) from savings transactions
    SELECT 
        owner_id,
        DATE(MAX(transaction_date)) AS last_transaction_date  -- ensure date only, no time
    FROM savings_savingsaccount
    GROUP BY owner_id
)

-- Step 2: Join it with plans to get the plan details and classify account types
SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,

    lt.last_transaction_date,
    DATEDIFF(CURRENT_DATE(), lt.last_transaction_date) AS inactivity_days  -- days since last transaction

FROM plans_plan p

-- Join the latest transaction info by owner
JOIN latest_transactions lt 
    ON p.owner_id = lt.owner_id

-- Step 3: Filter to only plans that have been inactive for more than 1 year
WHERE 
    lt.last_transaction_date < DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY)
    AND (p.is_regular_savings = 1 OR p.is_a_fund = 1)  -- filter to only active account types

ORDER BY inactivity_days DESC;