-- Create database
CREATE database job_analysis; 

-- Select the database 
use job_analysis;

-- Display all records from table
SELECT * from salaries;
SELECT * from job_skills;
SELECT * FROM job_industries;

-- Check Total Records
SELECT COUNT(*) FROM salaries;
SELECT count(*) FROM job_industries;
SELECT COUNT(*) FROM job_skills;

-- Display structure of tables
DESC salaries;
DESC job_skills;
DESC job_industries;

-- NULL VALUE 
SELECT * FROM salaries
WHERE max_salary IS NULL
OR min_salary IS NULL
OR med_salary IS NULL;

-- Find rows where pay period is missing
SELECT * FROM salaries
WHERE pay_period IS NULL;

-- Find missing skill values
SELECT * FROM job_skills
WHERE skill_abr IS NULL;

-- Find missing industry IDs
SELECT * FROM job_industries
WHERE industry_id IS NULL;

-- Check duplicate job IDs in salaries table
SELECT job_id,
	COUNT(*) AS duplicate_count
FROM salaries
GROUP BY job_id
HAVING COUNT(*) > 1;

-- Check duplicate combinations of job_id and skill
SELECT job_id,
	skill_abr,
    COUNT(*)
FROM job_skills
GROUP BY job_id, skill_abr
HAVING COUNT(*) > 1;

-- Find highest salary
SELECT MAX(max_salary) AS highest_salary
FROM salaries;

-- Find lowest salary
SELECT MIN(min_salary) AS lowest_salary
FROM salaries;

-- Calculate average salary
SELECT AVG(med_salary) AS average_salary
FROM salaries;

-- Count jobs based on pay period
SELECT pay_period,
	COUNT(*) AS total_jobs
FROM salaries
GROUP BY pay_period;

-- Count demand for each skill
SELECT skill_abr,
	COUNT(*) AS demand_count
FROM job_skills
GROUP BY skill_abr
ORDER BY demand_count DESC;

-- Display top 10 demand skills
SELECT skill_abr,
	COUNT(*) AS demand_count
FROM job_skills
GROUP BY skill_abr
ORDER BY demand_count DESC
LIMIT 10;

-- Count number of jobs in each industry
SELECT industry_id,
	COUNT(*) AS total_jobs
FROM job_industries
GROUP BY industry_id
ORDER BY total_jobs DESC;

-- JOINS
-- Calculate average salary for each skill
SELECT js.skill_abr,
	ROUND(AVG(s.max_salary),2) AS avg_salary
FROM salaries s
JOIN job_skills js
ON s.job_id = js.job_id
GROUP BY js.skill_abr
ORDER BY avg_salary DESC;

-- Calculate average salary for each industry
SELECT ji.industry_id,
	ROUND(AVG(s.max_salary),2) AS avg_salary
FROM salaries s
JOIN job_industries ji
ON s.job_id = ji.job_id
GROUP BY ji.industry_id
ORDER BY avg_salary DESC;

-- CASE STATEMENT
-- Categorize salaries into High, Medium, and Low
SELECT job_id,
	 max_salary,
     CASE
		WHEN max_salary >= 150000 THEN 'High Salary'
        WHEN max_salary >= 80000 THEN 'Medium Salary'
        ELSE 'Low Salary'
	END AS salary_category
FROM salaries;

-- WINDOW FUNCTION
-- Rank jobs based on highest salary
SELECT job_id,
	max_salary,
    RANK() OVER(ORDER BY max_salary DESC) AS salary_rank
FROM salaries;

