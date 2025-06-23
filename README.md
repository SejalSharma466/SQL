# SQL
SQL-based project to clean and prepare a global tech layoffs dataset for analytics.
# SQL Data Cleaning Project – Global Layoffs Dataset

## 📌 Project Objective
To clean, standardize, and prepare a messy real-world dataset on global tech layoffs using SQL for business analytics.

## 🔧 Tools Used
- SQL (MySQL Workbench)
- ROW_NUMBER(), TRIM(), LIKE, STR_TO_DATE
- CTEs and Subqueries

## 🧹 Key Steps Performed
- Removed duplicate rows using `ROW_NUMBER() OVER (PARTITION BY...)`
- Trimmed text fields and standardized inconsistent values (e.g., 'United States.', 'CryptoCurrency')
- Converted date strings into proper `DATE` format using `STR_TO_DATE()`
- Handled `NULL` and blank values
- Deleted unusable data rows with missing key information

## 📁 File
- `PROJECT 1.sql` – All SQL queries used for cleaning the dataset.

## 📊 Outcome
A fully cleaned, standardized, and structured version of the original layoffs dataset ready for further analysis or visualization.


