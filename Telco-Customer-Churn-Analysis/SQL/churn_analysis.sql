CREATE DATABASE telco_churn;
USE telco_churn;

SELECT * FROM telco_customer_churn;

SELECT 
    ROUND(
        SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 
        2
    ) AS churn_rate_percent
FROM telco_customer_churn;

SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS churn_rate_percent
FROM telco_customer_churn
GROUP BY Contract
ORDER BY churn_rate_percent DESC;

SELECT
    CASE
        WHEN `Tenure Months` BETWEEN 0 AND 6 THEN '0–6 months'
        WHEN `Tenure Months`  BETWEEN 7 AND 12 THEN '7–12 months'
        WHEN `Tenure Months` BETWEEN 13 AND 24 THEN '1–2 years'
        ELSE '2+ years'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS churn_rate_percent
FROM telco_customer_churn
GROUP BY tenure_group
ORDER BY churn_rate_percent DESC;


SELECT
    Contract,
    CASE
        WHEN `Tenure Months` <= 6 THEN '0–6 months'
        WHEN `Tenure Months` <= 12 THEN '7–12 months'
        ELSE '1+ years'
    END AS tenure_group,
    CASE
        WHEN `Monthly Charges` < 35 THEN 'Low'
        WHEN `Monthly Charges` BETWEEN 35 AND 70 THEN 'Medium'
        ELSE 'High'
    END AS charge_group,
    COUNT(*) AS total_customers,
    ROUND(
        SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS churn_rate_percent
FROM telco_customer_churn
GROUP BY Contract, tenure_group, charge_group
HAVING COUNT(*) >= 50
ORDER BY churn_rate_percent DESC;



