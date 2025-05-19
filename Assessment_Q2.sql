-- Q2: Transaction Frequency Analysis
-- Goal: Categorize customers by how frequently they transact each month using average transactions per customer per month.

WITH monthly_transactions AS (
    -- Step 1: Count transactions per customer per month
    SELECT 
        s.owner_id,
        DATE_FORMAT(s.transaction_date, '%Y-%m-01') AS month,  -- normalize data to month level
        COUNT(*) AS transaction_count
    FROM savings_savingsaccount s
    GROUP BY 
        s.owner_id, DATE_FORMAT(s.transaction_date, '%Y-%m-01')
),

customer_avg AS (
    -- Step 2: Compute the average monthly transaction count per customer
    SELECT 
        owner_id,
        AVG(transaction_count) AS avg_transactions_per_month
    FROM monthly_transactions
    GROUP BY owner_id
)

-- Step 3: Categorize the customers based on average transaction frequency
SELECT 
    CASE 
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month >= 3 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,

    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month

FROM customer_avg
GROUP BY frequency_category

-- Optional: Ensure consistent ordering of categories
ORDER BY 
    CASE 
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        ELSE 3
    END;