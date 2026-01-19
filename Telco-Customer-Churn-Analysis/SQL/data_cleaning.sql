CREATE VIEW churn_analysis AS
SELECT
    CustomerID,
    `Tenure Months`,
    `Monthly Charges` AS monthly_charges,
    `Total Charges` AS total_charges,
    Contract,
    `Churn Label`
FROM telco_customer_churn;

SELECT `Total Charges`
FROM telco_customer_churn
LIMIT 10;

-- checking for missing values

SELECT
    SUM(CASE WHEN `Tenure Months` IS NULL THEN 1 ELSE 0 END) AS missing_tenure,
    SUM(CASE WHEN `Monthly Charges` IS NULL THEN 1 ELSE 0 END) AS missing_monthly_charges,
    SUM(CASE WHEN `Total Charges` IS NULL THEN 1 ELSE 0 END) AS missing_total_charges,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS missing_contract
FROM telco_customer_churn;

ALTER TABLE telco_customer_churn
RENAME COLUMN `ï»¿CustomerID` TO CustomerID;


-- checking for duplicates

SELECT CustomerID, COUNT(*)
FROM telco_customer_churn
GROUP BY CustomerID
HAVING COUNT(*) > 1;


