-- 1. What are the top 5 most popular job titles?
-- 2. What are the top 20 reported salaries and their employee country?
-- 3. What is the average salary for data scientists, data engineers, and data analysts in the US?
-- 4. What percentage of roles in the US are remote?


-- 1. What are the top 5 most popular job titles?

select DISTINCT TOP 5 job_title as job_title,
	COUNT(job_title) as count_of_jobs
from [Data Science Salaries].dbo.ds_salaries
GROUP BY job_title
ORDER BY count_of_jobs desc;


-- 2. What are the top 10 reported salaries and their employee country?

select DISTINCT TOP 10 job_title,
	salary_in_usd,
	employee_residence
from [Data Science Salaries].dbo.ds_salaries
ORDER BY salary_in_usd DESC;


-- 3. What is the average salary for data scientists, data engineers, and data analysts in the US?

select job_title,
	AVG(salary_in_usd) as average_salary
from [Data Science Salaries].dbo.ds_salaries
where job_title in ('Data Scientist', 'Data Engineer', 'Data Analyst')
 AND employee_residence = 'US'
 GROUP BY job_title;


-- 4. What percentage of roles in the US are remote?

select CAST(d.numerator as decimal)/d.denominator * 100 as percentage_remote
From (select count(case when remote_ratio = 100 then 'remote' else null end) as numerator,
	count(case when remote_ratio in (0,100) then 'total' else null end) as denominator
	from [Data Science Salaries].dbo.ds_salaries) d
