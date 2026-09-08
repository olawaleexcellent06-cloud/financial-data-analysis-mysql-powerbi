-- View all accounts
SELECT *
FROM `finance fraud & loans`.accounts;


-- Customer with the most accounts
SELECT
    CustomerID,
    COUNT(*) AS NumberOfAccounts
FROM `finance fraud & loans`.accounts
GROUP BY CustomerID
ORDER BY NumberOfAccounts DESC
LIMIT 1;


-- Customers with more than 5 accounts
SELECT
    CustomerID,
    COUNT(*) AS NumberOfAccounts
FROM `finance fraud & loans`.accounts
GROUP BY CustomerID
HAVING NumberOfAccounts > 5;


-- Account type with the most accounts
SELECT
    AccountTypeID,
    COUNT(*) AS NumberOfAccountType
FROM `finance fraud & loans`.accounts
GROUP BY AccountTypeID
ORDER BY NumberOfAccountType DESC
LIMIT 1;


-- Number of accounts by account status
SELECT
    AccountStatusID,
    COUNT(*) AS AccountCount
FROM `finance fraud & loans`.accounts
GROUP BY AccountStatusID;


-- Account status with the lowest number of accounts
SELECT
    AccountStatusID,
    COUNT(*) AS AccountCount
FROM `finance fraud & loans`.accounts
GROUP BY AccountStatusID
ORDER BY AccountCount ASC;


-- Year with the most account openings
SELECT
    YEAR(OpeningDate) AS OpeningYear,
    COUNT(*) AS AccountOpened
FROM `finance fraud & loans`.accounts
WHERE OpeningDate IS NOT NULL
  AND OpeningDate <> ''
GROUP BY YEAR(OpeningDate)
ORDER BY AccountOpened DESC
LIMIT 1;


-- Average account balance by account type
SELECT
    AccountTypeID,
    AVG(Balance) AS AverageBalance
FROM `finance fraud & loans`.accounts
GROUP BY AccountTypeID;


-- Account type with the highest average balance
SELECT
    AccountTypeID,
    AVG(Balance) AS AverageBalance
FROM `finance fraud & loans`.accounts
GROUP BY AccountTypeID
ORDER BY AverageBalance DESC
LIMIT 1;

-- Transaction type with the lowest number of transactions
SELECT
    TransactionTypeID,
    COUNT(*) AS TransactionOccurred
FROM `finance fraud & loans`.transactions
GROUP BY TransactionTypeID
ORDER BY TransactionOccurred
LIMIT 1;


-- Total transaction amount by transaction type
SELECT
    TransactionTypeID,
    SUM(Amount) AS Transaction_Amount
FROM `finance fraud & loans`.transactions
GROUP BY TransactionTypeID;


-- Transaction type with the highest total transaction amount
SELECT
    TransactionTypeID,
    SUM(Amount) AS Transaction_Amount
FROM `finance fraud & loans`.transactions
GROUP BY TransactionTypeID
ORDER BY Transaction_Amount DESC
LIMIT 1;


-- Average transaction amount by transaction type
SELECT
    TransactionTypeID,
    AVG(Amount) AS Average_Transaction_Amount
FROM `finance fraud & loans`.transactions
GROUP BY TransactionTypeID;


-- Year with the most transactions
SELECT
    YEAR(TransactionDate) AS Transaction_Year,
    COUNT(*) AS Transaction_Occurred
FROM `finance fraud & loans`.transactions
WHERE TransactionDate IS NOT NULL
  AND TransactionDate <> ''
GROUP BY YEAR(TransactionDate)
ORDER BY Transaction_Occurred DESC
LIMIT 1;


-- Transaction count and average amount by year
SELECT
    YEAR(TransactionDate) AS Transaction_Year,
    COUNT(*) AS Transaction_Occurred,
    AVG(Amount) AS Average_Amount
FROM `finance fraud & loans`.transactions
WHERE TransactionDate IS NOT NULL
  AND TransactionDate <> ''
GROUP BY YEAR(TransactionDate)
ORDER BY Average_Amount DESC;


-- Highest-average transaction type in each year
WITH Highest_average_transaction_amount AS (
    SELECT
        YEAR(TransactionDate) AS Transaction_Year,
        TransactionTypeID,
        AVG(Amount) AS Average_Amount
    FROM `finance fraud & loans`.transactions
    WHERE TransactionDate IS NOT NULL
      AND TransactionDate <> ''
    GROUP BY YEAR(TransactionDate), TransactionTypeID
),
Rank_Transaction AS (
    SELECT
        Transaction_Year,
        TransactionTypeID,
        Average_Amount,
        ROW_NUMBER() OVER (
            PARTITION BY Transaction_Year
            ORDER BY Average_Amount DESC
        ) AS Transaction_Rank
    FROM Highest_average_transaction_amount
)
SELECT
    Transaction_Year,
    TransactionTypeID,
    Average_Amount
FROM Rank_Transaction
WHERE Transaction_Rank = 1
ORDER BY Transaction_Year;

-- Transaction count and total amount by branch
SELECT
    BranchID,
    COUNT(*) AS Transaction_Occurred,
    SUM(Amount) AS Total_Transaction_Amount
FROM `finance fraud & loans`.transactions
GROUP BY BranchID;


-- Branch with the highest total transaction amount
SELECT
    BranchID,
    COUNT(*) AS Transaction_Occurred,
    SUM(Amount) AS Total_Transaction_Amount
FROM `finance fraud & loans`.transactions
GROUP BY BranchID
ORDER BY Total_Transaction_Amount DESC
LIMIT 1;


-- Transaction count and average amount by branch
SELECT
    BranchID,
    COUNT(*) AS Transaction_Occurred,
    AVG(Amount) AS Average_Transaction_Amount
FROM `finance fraud & loans`.transactions
GROUP BY BranchID;


-- Branch with the highest average transaction amount
SELECT
    BranchID,
    COUNT(*) AS Transaction_Occurred,
    AVG(Amount) AS Average_Transaction_Amount
FROM `finance fraud & loans`.transactions
GROUP BY BranchID
ORDER BY Average_Transaction_Amount DESC
LIMIT 1;


-- Transaction count by year and branch
SELECT
    YEAR(TransactionDate) AS Transaction_Year,
    BranchID,
    COUNT(*) AS Transaction_Processed
FROM `finance fraud & loans`.transactions
WHERE TransactionDate IS NOT NULL
  AND TransactionDate <> ''
GROUP BY YEAR(TransactionDate), BranchID
ORDER BY Transaction_Processed DESC, BranchID;


-- Branch with the highest transaction count in each year
WITH branch_transactions AS (
    SELECT
        YEAR(TransactionDate) AS Transaction_Year,
        BranchID,
        COUNT(*) AS Transaction_Processed
    FROM `finance fraud & loans`.transactions
    WHERE TransactionDate IS NOT NULL
      AND TransactionDate <> ''
    GROUP BY YEAR(TransactionDate), BranchID
),
ranked_branches AS (
    SELECT
        Transaction_Year,
        BranchID,
        Transaction_Processed,
        ROW_NUMBER() OVER (
            PARTITION BY Transaction_Year
            ORDER BY Transaction_Processed DESC
        ) AS Branch_Rank
    FROM branch_transactions
)
SELECT
    Transaction_Year,
    BranchID,
    Transaction_Processed
FROM ranked_branches
WHERE Branch_Rank = 1
ORDER BY Transaction_Year;


-- Total transaction amount by year and branch
SELECT
    YEAR(TransactionDate) AS Transaction_Year,
    BranchID,
    SUM(Amount) AS Total_Transaction_Amount_Processed
FROM `finance fraud & loans`.transactions
WHERE TransactionDate IS NOT NULL
  AND TransactionDate <> ''
GROUP BY YEAR(TransactionDate), BranchID
ORDER BY Total_Transaction_Amount_Processed DESC, BranchID;


-- Branch with the highest transaction amount in each year
WITH branch_amounts AS (
    SELECT
        YEAR(TransactionDate) AS Transaction_Year,
        BranchID,
        SUM(Amount) AS Total_Transaction_Amount_Processed
    FROM `finance fraud & loans`.transactions
    WHERE TransactionDate IS NOT NULL
      AND TransactionDate <> ''
    GROUP BY YEAR(TransactionDate), BranchID
),
ranked_branches AS (
    SELECT
        Transaction_Year,
        BranchID,
        Total_Transaction_Amount_Processed,
        ROW_NUMBER() OVER (
            PARTITION BY Transaction_Year
            ORDER BY Total_Transaction_Amount_Processed DESC
        ) AS Branch_Rank
    FROM branch_amounts
)
SELECT
    Transaction_Year,
    BranchID,
    Total_Transaction_Amount_Processed
FROM ranked_branches
WHERE Branch_Rank = 1
ORDER BY Transaction_Year;


-- Average transaction amount by year and branch
SELECT
    YEAR(TransactionDate) AS Transaction_Year,
    BranchID,
    AVG(Amount) AS Average_Transaction_Amount_Processed
FROM `finance fraud & loans`.transactions
WHERE TransactionDate IS NOT NULL
  AND TransactionDate <> ''
GROUP BY YEAR(TransactionDate), BranchID
ORDER BY Average_Transaction_Amount_Processed DESC, BranchID;


-- Branch with the highest average transaction amount in each year
WITH CTE_highest_average_transaction AS (
    SELECT
        YEAR(TransactionDate) AS Transaction_Year,
        BranchID,
        AVG(Amount) AS Average_Transaction
    FROM `finance fraud & loans`.transactions
    WHERE TransactionDate IS NOT NULL
      AND TransactionDate <> ''
    GROUP BY YEAR(TransactionDate), BranchID
),
Rank_branches AS (
    SELECT
        Transaction_Year,
        BranchID,
        Average_Transaction,
        ROW_NUMBER() OVER (
            PARTITION BY Transaction_Year
            ORDER BY Average_Transaction DESC
        ) AS Branch_Rank
    FROM CTE_highest_average_transaction
)
SELECT
    Transaction_Year,
    BranchID,
    Average_Transaction
FROM Rank_branches
WHERE Branch_Rank = 1
ORDER BY Transaction_Year;

-- Total loan principal by loan status
SELECT
    LoanStatusID,
    SUM(PrincipalAmount) AS TotalPrincipalAmountOfLoansIssued
FROM `finance fraud & loans`.loans
GROUP BY LoanStatusID
ORDER BY TotalPrincipalAmountOfLoansIssued DESC;


-- Average interest rate by loan status
SELECT
    LoanStatusID,
    AVG(InterestRate) AS AverageInterestRate
FROM `finance fraud & loans`.loans
GROUP BY LoanStatusID
ORDER BY AverageInterestRate DESC;


-- Average principal amount by loan status
SELECT
    LoanStatusID,
    AVG(PrincipalAmount) AS AveragePrincipalAmount
FROM `finance fraud & loans`.loans
GROUP BY LoanStatusID
ORDER BY AveragePrincipalAmount DESC;


-- Number of loans issued by year
SELECT
    YEAR(StartDate) AS Loans_Issued_By_Year,
    COUNT(*) AS Total_Loans_Issued
FROM `finance fraud & loans`.loans
WHERE YEAR(StartDate) IS NOT NULL
  AND StartDate <> ''
GROUP BY YEAR(StartDate)
ORDER BY Total_Loans_Issued DESC;


-- Total loan principal issued by year
SELECT
    YEAR(StartDate) AS Loans_Issued_By_Year,
    SUM(PrincipalAmount) AS TotalPrincipalAmountOfLoansIssued
FROM `finance fraud & loans`.loans
WHERE YEAR(StartDate) IS NOT NULL
  AND StartDate <> ''
GROUP BY YEAR(StartDate)
ORDER BY TotalPrincipalAmountOfLoansIssued DESC;


-- Average loan principal issued by year
SELECT
    YEAR(StartDate) AS Loans_Issued_By_Year,
    AVG(PrincipalAmount) AS AveragePrincipalAmountOfLoansIssued
FROM `finance fraud & loans`.loans
WHERE YEAR(StartDate) IS NOT NULL
  AND StartDate <> ''
GROUP BY YEAR(StartDate)
ORDER BY AveragePrincipalAmountOfLoansIssued DESC;


-- Year with the highest total loan principal issued
SELECT
    YEAR(StartDate) AS Loans_Issued_By_Year,
    SUM(PrincipalAmount) AS TotalPrincipalAmountOfLoansIssued
FROM `finance fraud & loans`.loans
WHERE YEAR(StartDate) IS NOT NULL
  AND StartDate <> ''
GROUP BY YEAR(StartDate)
ORDER BY TotalPrincipalAmountOfLoansIssued DESC
LIMIT 1;


-- Loan status with the highest principal amount in each year
WITH PrincipalAmountOfLoansIssued AS (
    SELECT
        YEAR(StartDate) AS Loan_Year,
        LoanStatusID,
        SUM(PrincipalAmount) AS TotalPrincipalAmountOfLoansIssued
    FROM `finance fraud & loans`.loans
    WHERE YEAR(StartDate) IS NOT NULL
      AND StartDate <> ''
    GROUP BY YEAR(StartDate), LoanStatusID
),
Rank_Loan AS (
    SELECT
        Loan_Year,
        LoanStatusID,
        TotalPrincipalAmountOfLoansIssued,
        ROW_NUMBER() OVER (
            PARTITION BY Loan_Year
            ORDER BY TotalPrincipalAmountOfLoansIssued DESC
        ) AS Loan_Rank
    FROM PrincipalAmountOfLoansIssued
)
SELECT
    Loan_Year,
    LoanStatusID,
    TotalPrincipalAmountOfLoansIssued
FROM Rank_Loan
WHERE Loan_Rank = 1
ORDER BY Loan_Year;


-- Loan status with the highest average interest rate in each year
WITH highest_average_interest_rate_in_each_year AS (
    SELECT
        YEAR(StartDate) AS Loan_Year,
        LoanStatusID,
        AVG(InterestRate) AS Average_Interest
    FROM `finance fraud & loans`.loans
    WHERE YEAR(StartDate) IS NOT NULL
      AND StartDate <> ''
    GROUP BY YEAR(StartDate), LoanStatusID
),
Interest_Rank AS (
    SELECT
        Loan_Year,
        LoanStatusID,
        Average_Interest,
        ROW_NUMBER() OVER (
            PARTITION BY Loan_Year
            ORDER BY Average_Interest DESC
        ) AS Ranked
    FROM highest_average_interest_rate_in_each_year
)
SELECT
    Loan_Year,
    LoanStatusID,
    Average_Interest
FROM Interest_Rank
WHERE Ranked = 1
ORDER BY Loan_Year;

-- Customer with the highest total loan principal
SELECT
    c.CustomerID,
    SUM(l.PrincipalAmount) AS TotalLoanPrincipal
FROM `finance fraud & loans`.customers c
JOIN `finance fraud & loans`.accounts a
    ON c.CustomerID = a.CustomerID
JOIN `finance fraud & loans`.loans l
    ON a.AccountID = l.AccountID
GROUP BY c.CustomerID
ORDER BY TotalLoanPrincipal DESC
LIMIT 1;


-- Customer with the most loans
SELECT
    c.CustomerID,
    COUNT(*) AS Number_of_Loans
FROM `finance fraud & loans`.customers c
JOIN `finance fraud & loans`.accounts a
    ON c.CustomerID = a.CustomerID
JOIN `finance fraud & loans`.loans l
    ON a.AccountID = l.AccountID
GROUP BY c.CustomerID
ORDER BY Number_of_Loans DESC
LIMIT 1;


-- Total loan principal by customer type
SELECT
    ct.CustomerTypeID,
    SUM(l.PrincipalAmount) AS TotalLoanPrincipal
FROM `finance fraud & loans`.customers c
JOIN `finance fraud & loans`.customer_types ct
    ON c.CustomerTypeID = ct.CustomerTypeID
JOIN `finance fraud & loans`.accounts a
    ON c.CustomerID = a.CustomerID
JOIN `finance fraud & loans`.loans l
    ON a.AccountID = l.AccountID
GROUP BY ct.CustomerTypeID
ORDER BY TotalLoanPrincipal DESC;


-- Number of accounts per customer
SELECT
    c.CustomerID,
    COUNT(*) AS Number_of_Accounts
FROM `finance fraud & loans`.customers c
JOIN `finance fraud & loans`.accounts a
    ON c.CustomerID = a.CustomerID
GROUP BY c.CustomerID;


-- Average balance per customer
SELECT
    c.CustomerID,
    AVG(a.Balance) AS Average_Balance
FROM `finance fraud & loans`.customers c
JOIN `finance fraud & loans`.accounts a
    ON c.CustomerID = a.CustomerID
GROUP BY c.CustomerID;


-- Customer with the highest average balance
SELECT
    c.CustomerID,
    AVG(a.Balance) AS Average_Balance
FROM `finance fraud & loans`.customers c
JOIN `finance fraud & loans`.accounts a
    ON c.CustomerID = a.CustomerID
GROUP BY c.CustomerID
ORDER BY Average_Balance DESC
LIMIT 1;


-- Customer with the highest total transaction amount
SELECT
    c.CustomerID,
    SUM(ts.Amount) AS Total_Transaction_Amount
FROM `finance fraud & loans`.customers c
JOIN `finance fraud & loans`.accounts a
    ON c.CustomerID = a.CustomerID
JOIN `finance fraud & loans`.transactions ts
    ON a.AccountID = ts.AccountOriginID
GROUP BY c.CustomerID
ORDER BY Total_Transaction_Amount DESC
LIMIT 1;


-- Customer with the highest average transaction amount
SELECT
    c.CustomerID,
    AVG(ts.Amount) AS Average_Transaction_Amount
FROM `finance fraud & loans`.customers c
JOIN `finance fraud & loans`.accounts a
    ON c.CustomerID = a.CustomerID
JOIN `finance fraud & loans`.transactions ts
    ON a.AccountID = ts.AccountOriginID
GROUP BY c.CustomerID
ORDER BY Average_Transaction_Amount DESC
LIMIT 1;

-- Transaction count by account type
SELECT
    a.AccountTypeID,
    COUNT(*) AS Count_Transactions_Occurred
FROM `finance fraud & loans`.accounts a
JOIN `finance fraud & loans`.transactions ts
    ON a.AccountID = ts.AccountOriginID
JOIN `finance fraud & loans`.account_types at
    ON a.AccountTypeID = at.AccountTypeID
GROUP BY a.AccountTypeID;


-- Total transaction amount by account type
SELECT
    a.AccountTypeID,
    SUM(ts.Amount) AS Total_Amounts
FROM `finance fraud & loans`.accounts a
JOIN `finance fraud & loans`.transactions ts
    ON a.AccountID = ts.AccountOriginID
JOIN `finance fraud & loans`.account_types at
    ON a.AccountTypeID = at.AccountTypeID
GROUP BY a.AccountTypeID;


-- Number of loans by account type
SELECT
    a.AccountTypeID,
    COUNT(*) AS Total_Loan
FROM `finance fraud & loans`.accounts a
JOIN `finance fraud & loans`.loans l
    ON a.AccountID = l.AccountID
GROUP BY a.AccountTypeID;


-- Total loan amount by account type
SELECT
    a.AccountTypeID,
    SUM(PrincipalAmount) AS Total_Loan_Amount
FROM `finance fraud & loans`.accounts a
JOIN `finance fraud & loans`.loans l
    ON a.AccountID = l.AccountID
GROUP BY a.AccountTypeID;


-- Account type with the highest total loan amount
SELECT
    a.AccountTypeID,
    SUM(PrincipalAmount) AS Total_Loan_Amount
FROM `finance fraud & loans`.accounts a
JOIN `finance fraud & loans`.loans l
    ON a.AccountID = l.AccountID
GROUP BY a.AccountTypeID
ORDER BY Total_Loan_Amount DESC
LIMIT 1;


-- Average loan amount by account status
SELECT
    a.AccountStatusID,
    AVG(PrincipalAmount) AS Average_Loan_Amount
FROM `finance fraud & loans`.accounts a
JOIN `finance fraud & loans`.loans l
    ON a.AccountID = l.AccountID
GROUP BY a.AccountStatusID;


-- Account status with the highest average loan amount
SELECT
    a.AccountStatusID,
    AVG(PrincipalAmount) AS Average_Loan_Amount
FROM `finance fraud & loans`.accounts a
JOIN `finance fraud & loans`.loans l
    ON a.AccountID = l.AccountID
GROUP BY a.AccountStatusID
ORDER BY Average_Loan_Amount DESC
LIMIT 1;
     


       













     
     
     


       



















     
     
	
     


       


















