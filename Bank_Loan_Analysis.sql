USE Bank_Loan;
-- Calculating the total applications recieved
SELECT COUNT(ID) AS Total_Loan_Applications
from financial_loan;

-- Calculating MTD total loan applications
SELECT COUNT(ID) AS MTD_Loan_Applications
FROM financial_loan WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- Calculating PMTD Total loan applications
SELECT COUNT(ID) AS PMTD_Loan_Applications
FROM financial_loan WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--Calculating the MOM Total loan applications
WITH MTD_app AS (
    SELECT COUNT(ID) AS MTD_Loan_Applications
    FROM financial_loan 
    WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
),
PMTD_app AS (
    SELECT COUNT(ID) AS PMTD_Loan_Applications
    FROM financial_loan 
    WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 
)
SELECT (
    (MTD.MTD_Loan_Applications - PMTD.PMTD_Loan_Applications) * 100.0 / 
    NULLIF(PMTD.PMTD_Loan_Applications, 0)
) AS MOM_Loan_Applications
FROM MTD_app MTD, PMTD_app PMTD; 

-- Calculating the Total Funded Amount
SELECT SUM(LOAN_AMOUNT) AS Total_Loan_Amount
FROM financial_loan;

-- Calculating the MTD Total Funded Amount
SELECT SUM(LOAN_AMOUNT) AS MTD_Total_Funded_Amount
FROM financial_loan
WHERE MONTH(ISSUE_DATE) = 12 AND YEAR(ISSUE_DATE) = 2021;

-- Calculate the PMTD Total Funded Amount
SELECT SUM(LOAN_AMOUNT) AS PMTD_Total_Funded_Amount
FROM financial_loan
WHERE MONTH(ISSUE_DATE) = 11 AND YEAR(ISSUE_DATE) = 2021;

-- Calculate MTM Total Funded Amount
WITH MTD_Funded AS (
    SELECT SUM(LOAN_AMOUNT) AS MTD_Total_Funded_Amount
    FROM financial_loan
    WHERE MONTH(ISSUE_DATE) = 12 AND YEAR(ISSUE_DATE) = 2021
),
PMTD_Funded AS (
    SELECT SUM(LOAN_AMOUNT) AS PMTD_Total_Funded_Amount
    FROM financial_loan
    WHERE MONTH(ISSUE_DATE) = 11 AND YEAR(ISSUE_DATE) = 2021
)
SELECT (MTD.MTD_Total_Funded_Amount - PMTD.PMTD_Total_Funded_Amount) * 100.0 / PMTD.PMTD_Total_Funded_Amount AS MOM_TOTAL_FUNDED_AMOUNT
FROM MTD_Funded MTD, PMTD_Funded PMTD;

-- Calculating the Total Amount Recieved
SELECT SUM(TOTAL_PAYMENT) AS Total_Amount_Recieved
FROM financial_loan;

-- Calculating the MTD Total Amount Recieved
SELECT SUM(total_payment) AS MTD_Total_Amount_Recieved
FROM financial_loan
WHERE MONTH(ISSUE_DATE) = 12 AND YEAR(ISSUE_DATE) = 2021;

-- Calculating PMTD Total Amount Recieved
SELECT SUM(total_payment) AS PMTD_Total_Amount_Recieved
FROM financial_loan
WHERE MONTH(ISSUE_DATE) = 11 AND YEAR(ISSUE_DATE) = 2021;

-- Calculate MTM Total Amount Recieved
WITH MTD_Amount AS (
    SELECT SUM(total_payment) AS MTD_Total_Amount_Recieved
    FROM financial_loan
    WHERE MONTH(ISSUE_DATE) = 12 AND YEAR(ISSUE_DATE) = 2021
),
PMTD_Amount AS (
    SELECT SUM(total_payment) AS PMTD_Total_Amount_Recieved
    FROM financial_loan
    WHERE MONTH(ISSUE_DATE) = 11 AND YEAR(ISSUE_DATE) = 2021
)
SELECT COALESCE(((MTD.MTD_Total_Amount_Recieved - PMTD.PMTD_Total_Amount_Recieved) * 100.0 / NULLIF(PMTD.PMTD_Total_Amount_Recieved, 0)), 0) AS MOM_TOTAL_AMOUNT_Recieved
FROM MTD_Amount MTD, PMTD_Amount PMTD;

-- Calculating the Avg Int Rate
SELECT AVG(INT_RATE)*100  AS Avg_Int_Rate FROM financial_loan;

-- Calculating the MTD Avg Int Rate
SELECT AVG(INT_RATE)*100 AS MTD_Avg_Int_Rate
FROM financial_loan
WHERE MONTH(ISSUE_DATE) = 12 AND YEAR(ISSUE_DATE) = 2021;

-- Calculating the PMTD Avg Int Rate
SELECT AVG(INT_RATE)*100 AS PMTD_Avg_Int_Rate
FROM financial_loan
WHERE MONTH(ISSUE_DATE) = 11 AND YEAR(ISSUE_DATE) = 2021;

-- Calculating MTM Avg Int Rate
WITH MTD_Avg_Int AS (
    SELECT AVG(INT_RATE) * 100 AS MTD_Avg_Int_Rate
    FROM financial_loan
    WHERE MONTH(ISSUE_DATE) = 12 AND YEAR(ISSUE_DATE) = 2021
),
PMTD_Avg_Int AS (
    SELECT AVG(INT_RATE) * 100 AS PMTD_Avg_Int_Rate
    FROM financial_loan
    WHERE MONTH(ISSUE_DATE) = 11 AND YEAR(ISSUE_DATE) = 2021
)
SELECT ((MTD.MTD_Avg_Int_Rate - PMTD.PMTD_Avg_Int_Rate) * 100.0 / PMTD.PMTD_Avg_Int_Rate) AS MOM_Avg_Int_Rate
FROM MTD_Avg_Int MTD, PMTD_Avg_Int PMTD;

-- Calculating the Avg Debt To Income Rate (DTI)
SELECT AVG(DTI)*100 AS AVG_DTI FROM financial_loan;

-- Calculating the MTD DTI
SELECT AVG(DTI)*100 AS MTD_AVG_DTI
FROM financial_loan
WHERE MONTH(ISSUE_DATE) = 12 AND YEAR(ISSUE_DATE) = 2021;

-- Calculating the PMTD DTI
SELECT AVG(DTI)*100 AS PMTD_AVG_DTI
FROM financial_loan
WHERE MONTH(ISSUE_DATE) = 11 AND YEAR(ISSUE_DATE) = 2021;

--Calculating MOM DTI
WITH MTD_DTI AS(
 SELECT AVG(DTI)*100 AS MTD_AVG_DTI
FROM financial_loan
WHERE MONTH(ISSUE_DATE) = 12 AND YEAR(ISSUE_DATE) = 2021
),
PMTD_DTI AS(
    SELECT AVG(DTI)*100 AS PMTD_AVG_DTI
FROM financial_loan
WHERE MONTH(ISSUE_DATE) = 11 AND YEAR(ISSUE_DATE) = 2021
)
SELECT ((MTD.MTD_AVG_DTI - PMTD.PMTD_AVG_DTI) * 100.0 / PMTD.PMTD_AVG_DTI) AS MOM_AVG_DTI
FROM MTD_DTI MTD, PMTD_DTI PMTD;

-- Calculating the Good Loan Application Percentage
SELECT (COUNT(CASE WHEN LOAN_STATUS = 'FULLY PAID' OR LOAN_STATUS = 'CURRENT' THEN ID END)*100)/
COUNT(ID) AS Good_Loan_Percentage
FROM financial_loan;

-- Calculate the Total Good_Loan_Application
SELECT COUNT(ID) AS Good_Loan_Application
from financial_loan
where LOAN_STATUS = 'FULLY PAID' OR LOAN_STATUS = 'CURRENT';

-- Calculating the Good_Loan_Funded_Amount
SELECT SUM(LOAN_AMOUNT) AS Good_Loan_Funded_Amount
FROM financial_loan
WHERE LOAN_STATUS = 'FULLY PAID' OR LOAN_STATUS = 'CURRENT';

-- Calculating the Good Loan Recieved Amount
SELECT SUM(TOTAL_PAYMENT) AS Good_Loan_Amount_Recieved 
FROM financial_loan
WHERE LOAN_STATUS = 'FULLY PAID' OR LOAN_STATUS = 'CURRENT';

-- Bad Loan Issued
-- Calculating Bad Loan Percentage

SELECT (COUNT(CASE WHEN LOAN_STATUS = 'CHARGED OFF' THEN ID END)*100) / COUNT(ID) AS Bad_Loan_Percentage
FROM financial_loan;

--Calculating the total count of Bad Loan Applications
SELECT COUNT(ID) AS Bad_Loan_Applications
FROM financial_loan
WHERE LOAN_STATUS  = 'CHARGED OFF';

--Calculating the Bad Loan Funded Amount
SELECT SUM(LOAN_AMOUNT) AS Bad_Loan_Funded_Amount
FROM financial_loan
WHERE LOAN_STATUS = 'CHARGED OFF';

-- Calculating the Loan_Amount, Total_Amount_Recieved, Total_Funded_Amount, Interest_Rate, DTI on the basis of the loan_status
SELECT 
    LOAN_STATUS,
	COUNT(ID) AS Loan_Count,
	SUM(TOTAL_PAYMENT) AS Total_Amount_Recieved,
	SUM(LOAN_AMOUNT) AS Total_Funded_Amount,
	AVG(INT_RATE * 100) AS Interest_Rate,
	AVG(DTI * 100 ) AS DTI
	FROM 
	    financial_loan
	GROUP BY LOAN_STATUS;

--Calcualting MTD_Total_Amount_Recieved, MTD_Total_Funded_Amount on the basis of loan_status
SELECT 
    LOAN_STATUS,
	SUM(TOTAL_PAYMENT) AS MTD_Total_Amount_Recieved,
	SUM(LOAN_AMOUNT) AS MTD_Total_Funded_Amount
	FROM
	    financial_loan
	WHERE MONTH(ISSUE_DATE) = 12 AND YEAR(ISSUE_DATE) = 2021
	GROUP BY LOAN_STATUS;


SELECT * FROM financial_loan;

