-- EDA PROJECT
SELECT *
FROM users_info;

-- YOUTH WITH HIGH RISK FINANCIAL PROFILES
SELECT current_age, AVG(yearly_income), credit_score
FROM users_info
WHERE current_age <= 40
AND credit_score < 580
GROUP BY current_age, credit_score;

-- Get the debt to income ratio of the users
-- Get the credit ratings for the users
-- get the average income, credit and how many people or cases are in those credit ratings 
-- and their yearly income
WITH Credit_score_segmentation AS
(
SELECT id, yearly_income, total_debt, credit_score,
	CASE 
		WHEN total_debt = 0 THEN 1
		WHEN yearly_income = 0 THEN 0
		ELSE ROUND((yearly_income / NULLIF(total_debt, 0)), 2)
	END AS debt_to_income_ratio,
	CASE 
		WHEN credit_score >= 800 THEN 'Excellent'
		WHEN credit_score >= 740 THEN 'Very Good'
		WHEN credit_score >= 670 THEN 'Good'
		WHEN credit_score >= 580 THEN 'Fair'
		ELSE 'Poor'
	END AS credit_rating
FROM users_info
)
SELECT credit_rating, COUNT(*) AS count, AVG(debt_to_income_ratio) AS dtir,
AVG(yearly_income) AS avg_income
FROM Credit_score_segmentation
GROUP BY credit_rating
ORDER BY 
	CASE credit_rating
		WHEN 'Excellent' THEN 1
        WHEN 'Very Good' THEN 2
        WHEN 'Good' THEN 3
        WHEN 'Fair' THEN 4
        ELSE 5
	END ;


-- Average debt accumulated per age group
SELECT 
    CASE 
        WHEN current_age < 30 THEN '20s'
        WHEN current_age < 40 THEN '30s'
        WHEN current_age < 50 THEN '40s'
        WHEN current_age < 60 THEN '50s'
        ELSE '60+'
    END AS age_group,
    AVG(total_debt) AS avg_debt,
    COUNT(*) AS population
FROM users_info
GROUP BY age_group
ORDER BY avg_debt DESC;

-- Retirement types per gender
SELECT 
    CASE
		WHEN retirement_age >= 65 THEN 'Late'
        WHEN retirement_age >= 60 THEN 'Normal'
        WHEN retirement_age >= 50 THEN 'Early'
        ELSE 'N/A'
	END AS retirement_type,
    gender,
    COUNT(*) AS population
FROM users_info
GROUP BY retirement_type, gender
ORDER BY 
    CASE retirement_type
        WHEN 'Early' THEN 1
        WHEN 'Normal' THEN 2
        WHEN 'Late' THEN 3
        ELSE 4
    END,gender;
