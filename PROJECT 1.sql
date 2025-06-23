-- DATA CLEANING

SELECT *
FROM world_layoffs.layoffs;

-- 1. REMOVE DUPLICATES
-- 2. STANDARDIZE THE DATA 
-- 3. NULL VALUES OR BLANK VALUES 
-- 4. REMOVE ANY COLUMNS

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

-- 1. REMOVING DUPLICATES 
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, 'date') AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;


INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- CHECKING FOR DUPLICATES 

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- 2. STANDARDIZING DATA 

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- CHECKING UPDATED INFO 

SELECT DISTINCT industry
FROM layoffs_staging2;

SELECT DISTINCT country
FROM layoffs_staging2
WHERE country LIKE 'United States%';

UPDATE layoffs_staging2
SET country = 'United states'
WHERE country LIKE 'United States%';

-- CHECKING UPDATED INFO 
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

-- OR 

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

SELECT `date`
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE (`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT DISTINCT industry
FROM world_layoffs.layoffs_staging2
ORDER BY industry;

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE company LIKE 'Bally%';
-- nothing wrong here
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE company LIKE 'airbnb%';

UPDATE world_layoffs.layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;


UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT DISTINCT industry
FROM world_layoffs.layoffs_staging2
ORDER BY industry;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry IN ('Crypto Currency', 'CryptoCurrency');

-- now that's taken care of:
SELECT DISTINCT industry
FROM world_layoffs.layoffs_staging2
ORDER BY industry;

SELECT *
FROM world_layoffs.layoffs_staging2;

SELECT DISTINCT country
FROM world_layoffs.layoffs_staging2
ORDER BY country;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);

-- now if we run this again it is fixed
SELECT DISTINCT country
FROM world_layoffs.layoffs_staging2
ORDER BY country;


SELECT *
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL;

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Delete Useless data we can't really use
DELETE FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM world_layoffs.layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


SELECT * 
FROM world_layoffs.layoffs_staging2;

-- COMPLETED 



