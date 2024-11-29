USE COMPANY;
-- 1.How many customers does the store have?
SELECT * FROM company.`customer purchasing behaviors`;

SELECT 
    COUNT(DISTINCT USER_ID) AS TOTAL_CLIENTS
FROM
    COMPANY.`customer purchasing behaviors`;

-- 2. What is the average income for the clients who come to this store?

SELECT 
    ROUND(AVG(ANNUAL_INCOME),2) AS AVG_ANNUAL_INCOME,
	ROUND(AVG(ANNUAL_INCOME) / 12,2) AS AVG_MONTHLY_INCOME,
    MIN(ANNUAL_INCOME) AS MIN_ANNUAL_INCOME,
    MAX(ANNUAL_INCOME) AS MAX_ANNUAL_INCOME
FROM
    company.`customer purchasing behaviors`;
 

 
 -- 3. What is the client average annual income by age?
 
 SELECT AGE,AVG(ANNUAL_INCOME) AS AVG_ANNUAL_INCOME
 FROM company.`customer purchasing behaviors`
 GROUP BY AGE;
 
SELECT 
    CASE
        WHEN AGE <= 30 THEN '30 AND YOUNGER'
        WHEN AGE <= 40 THEN '31-40 YEARS'
        ELSE 'OLDER THAN 40'
    END AS AGE_GROUP,
    ROUND(AVG(ANNUAL_INCOME), 2) AS AVG_ANNUAL_INCOME,
    ROUND(AVG(PURCHASE_AMOUNT),2) AS AVG_PURCHASE_AMOUNT,
    COUNT(USER_ID) AS CLIENT_COUNT
FROM
    company.`customer purchasing behaviors`
GROUP BY 1;
 
 -- 5.What is the average income and purchase amount by loyalty score?
 
SELECT 
    LOYALTY_SCORE, ROUND(AVG(ANNUAL_INCOME),2) AS AVG_ANNUAL_INCOME,
    ROUND(AVG(PURCHASE_AMOUNT),2) AS AVG_PURCHASE_AMOUNT
FROM
    company.`customer purchasing behaviors`
GROUP BY LOYALTY_SCORE;
 
 
 SELECT * FROM company.`customer purchasing behaviors`;