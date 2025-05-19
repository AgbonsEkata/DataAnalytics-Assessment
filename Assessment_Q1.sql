-- Q1: High-Value Customers with Multiple Products
-- Goal: Find customers with at least one funded savings account AND one funded investment plan, and sort them by total deposits (from savings accounts only).

SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,

    -- Count of distinct savings accounts with confirmed deposits
    COUNT(DISTINCT CASE
        WHEN s.id IS NOT NULL THEN s.id
    END) AS savings_count,

    -- Count of distinct investment plans (where is_a_fund = 1)
    COUNT(DISTINCT CASE
        WHEN p.is_a_fund = 1 THEN p.id
    END) AS investment_count,

    -- Total confirmed deposits from savings accounts (converted from kobo to naira)
    SUM(s.confirmed_amount / 100.0) AS total_deposits

FROM users_customuser u

-- Join to savings accounts with positive confirmed amount
LEFT JOIN savings_savingsaccount s 
    ON u.id = s.owner_id AND s.confirmed_amount > 0

-- Join to investment plans where is_a_fund = 1
LEFT JOIN plans_plan p 
    ON u.id = p.owner_id AND p.is_a_fund = 1

GROUP BY u.id, u.first_name, u.last_name

-- Only include the customers who have both savings and investment plans
HAVING 
    COUNT(DISTINCT CASE WHEN s.id IS NOT NULL THEN s.id END) > 0 AND
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) > 0

-- Sort by total deposits ordered in descending order
ORDER BY total_deposits DESC;