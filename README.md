# Financial & Loan Analytics


## Project Overview
This project analyzes a synthetic financial database sourced from Kaggle using MySQL to examine customers, accounts, transactions, loans, branches, and account types.

The objective was to use SQL to answer practical business questions related to financial activity and performance, including transaction volumes and amounts, account balances, customer activity, branch performance, and loan activity.

The analysis uses SQL querying, aggregation, joins, Common Table Expressions (CTEs), and window functions to transform the financial data into meaningful business analysis.

## Business Problem
Financial institutions generate large volumes of data across customers, accounts, transactions, loans, and branches. Without proper analysis, it can be difficult to understand customer activity, transaction performance, account balances, and loan activity.

This project aims to answer key business questions such as:
* Which customers hold the most accounts?
* Which account types have the highest average balances?
* Which transaction types generate the highest transaction amounts?
* Which years recorded the highest transaction activity?
* Which branches process the highest transaction amounts?
* Which loan statuses account for the highest loan principal?
* Which years recorded the highest loan activity?
* Which customers have the highest loan principal and transaction activity?
* How do transaction and loan activities differ across account types?

  ## Tools Used
* MySQL
* SQL
* Power BI
* Common Table Expressions (CTEs)
* Window Functions
* Aggregate Functions
* Data Analysis

## Analysis Process
The analysis was completed in the following stages:

### 1. Database Analysis
* Imported the financial database into MySQL.
* Reviewed the available tables and financial data.
* Identified relationships between customers, accounts, transactions, loans, branches, and account types.

### 2. Account Analysis
* Analyzed account volumes and account statuses.
* Examined account openings by year.
* Compared average account balances across account types.
* Identified customers with the highest number of accounts.

### 3. Transaction Analysis
* Analyzed transaction volumes and amounts by transaction type.
* Compared average transaction amounts.
* Examined transaction activity across different years.
* Used window functions to identify the highest-average transaction type in each year.

### 4. Branch Performance Analysis
* Compared transaction activity across branches.
* Analyzed transaction counts, total amounts, and average transaction amounts.
* Identified the highest-performing branches by year.

### 5. Loan Analysis
* Analyzed loan principal amounts by loan status.
* Compared average interest rates and principal amounts.
* Examined loan activity and principal amounts by year.
* Used window functions to identify leading loan statuses by year.

### 6. Customer Analysis
* Analyzed customer accounts, balances, loans, and transactions.
* Identified customers with the highest loan principal and transaction activity.
* Compared total loan principal across customer types.

### 7. Account Type Analysis
* Compared transaction activity across account types.
* Analyzed loan counts and total loan amounts by account type.
* Compared average loan amounts across account statuses.

* ### 8. Dashboard Development
* Connected the financial data to Power BI.
* Built KPI cards for Total Customers, Total Accounts, Total Transactions, and Total Loan Value.
* Created column and bar charts to analyze transaction types, account types, customer types, loan status, account status, and branch performance.
* Added slicers for Transaction Type and Account Status.
* Created a table visual showing customer account balances, including highest-balance customers.


## Key Business Insights
The analysis examined the following areas:

### Account Performance
* Account distribution and account status
* Account openings by year
* Average account balances by account type
* Customer account ownership

### Transaction Performance
* Transaction volume by transaction type
* Total and average transaction amounts
* Yearly transaction activity
* Highest-average transaction types by year

### Branch Performance
* Transaction volume by branch
* Total transaction amounts by branch
* Average transaction amounts by branch
* Yearly branch performance

### Loan Performance
* Loan principal by loan status
* Average interest rates by loan status
* Loan activity by year
* Yearly loan principal performance

### Customer Activity
* Customer loan activity
* Customer account ownership
* Customer account balances
* Customer transaction activity

### Account Type Performance
* Transaction activity by account type
* Loan activity by account type
* Total loan amounts by account type
* Average loan amounts by account status

* ## Business Recommendations

The analysis can support business decisions in the following areas:

* Monitor account balances and account activity across different account types.
* Review transaction volumes and transaction amounts to understand customer financial activity.
* Compare branch performance to identify areas requiring further investigation.
* Monitor loan principal amounts and interest rates across different loan statuses.
* Review customer-level loan, account, and transaction activity to better understand customer engagement.
* Compare account types based on transaction and loan activity to support performance evaluation.

## Dashboard Preview

The Power BI dashboard provides an interactive overview of financial activity across customers, accounts, transactions, loans, and branches.

The dashboard includes:

* KPI cards for Total Customers, Total Accounts, Total Transactions, and Total Loan Value
* Charts for transaction types, account types, customer types, loan status, account status, and branch performance
* Slicers for Transaction Type and Account Status
* A customer account balance table highlighting account balances and highest-balance customers


## Repository Structure

```text
financial-data-analysis-mysql-powerbi/
│
├── Finance Fraud & Loan Analytics.sql
├── Finance, Loans & Fraud Analytics Dashboard.pbix
└── README.md
```


## Skills Demonstrated

* SQL Querying
* Data Analysis
* MySQL
* Aggregate Functions
* Data Aggregation
* JOINs
* Common Table Expressions (CTEs)
* Window Functions
* `ROW_NUMBER()`
* `PARTITION BY`
* Business Analysis
* Financial Data Analysis

## Dataset

1. **Source:** Kaggle
2. **Type:** Synthetic financial database
3. **Main areas:** Customers, Accounts, Transactions, Loans, Branches, and Account Types
4. **Database:** MySQL


