# Cowrywise DataAnalytics-Assessment

This repository contains solutions to the Cowrywise SQL proficiency assessment designed to evaluate a candidate’s ability to manipulate and analyze relational data. Each SQL file corresponds to one of the four questions provided in the assessment prompt.

---

## 🧠 Question Summaries & Approaches

### ✅ Question 1: High-Value Customers with Multiple Products
**Objective**: Identify customers who have at least one funded savings account and one funded investment plan.

**Approach**:
- Used `LEFT JOIN` to combine user data with both savings and investment tables.
- Applied conditional aggregation to count distinct savings and investment products.
- Filtered customers who met both conditions and sorted them by total deposit value.

---

### ✅ Question 2: Transaction Frequency Analysis
**Objective**: Categorize customers by transaction frequency (high, medium, or low).

**Approach**:
- Aggregated transaction counts by customer and month.
- Computed average monthly transactions per customer.
- Applied `CASE` logic to categorize frequency levels and output customer counts per category.

---

### ✅ Question 3: Account Inactivity Alert
**Objective**: Identify savings or investment accounts with no inflow activity in over one year.

**Approach**:
- Calculated the last transaction date per customer from savings accounts.
- Joined with plans to determine account types.
- Filtered for accounts inactive for over 365 days and flagged them.

---

### ✅ Question 4: Customer Lifetime Value (CLV)
**Objective**: Estimate CLV using account tenure and total transaction value.

**Approach**:
- Computed tenure in months using `TIMESTAMPDIFF`.
- Calculated total transactions and transaction value.
- Applied a simplified CLV formula based on average monthly profit per transaction.

---

## ⚠️ Challenges Encountered
- The deposit field for investment plans was not initially obvious. Further inspection of the schema helped correct assumptions.
- I handled potential divide-by-zero errors using `NULLIF` in the CLV calculation.
- I Converted amounts from kobo to naira where applicable for consistency.

---

## 📂 Repository Structure

```
DataAnalytics-Assessment/
├── Assessment_Q1.sql
├── Assessment_Q2.sql
├── Assessment_Q3.sql
├── Assessment_Q4.sql
└── README.md
```

Each SQL file is self-contained and includes inline comments for clarity.

---

## 📝 Notes
- All queries are written in standard SQL and tested for MySQL compatibility.
