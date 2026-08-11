/*
Question 4: What are the top skills based on salary for these roles?

Goal:
- Find the top paying skills for Data Analysts, Data Engineers, and Data Scientists
- look at average salary associated with each skill for these roles
- focus on roles with salaries
- focus on remote roles in the United states
- focus on skills that are required in multiple jobs

Why?
- This will reveal how different skills impact salary levels across all 3 data roles
- helps provide insight into which rewarding skills to acquire or improve
*/
SELECT
    j.job_title_short,
    sd.skills,
    COUNT(*) AS job_count,
    ROUND(AVG(salary_year_avg)) AS avg_salary
FROM
    job_postings_fact AS j
    INNER JOIN skills_job_dim AS sjd ON j.job_id = sjd.job_id
    INNER JOIN skills_dim as sd ON sjd.skill_id = sd.skill_id
WHERE
    j.job_title_short IN ('Data Analyst', 'Data Scientist', 'Data Engineer')
    AND j.job_country = 'United States'
    AND j.job_location = 'Anywhere'
    AND j.salary_year_avg IS NOT NULL
GROUP BY
    j.job_title_short,
    sd.skills
HAVING
    COUNT(*) >= 10
ORDER BY
    j.job_title_short,
    avg_salary DESC;

/*
Observation:
- After retrieving the results, it seems that the highest paid skill is Numpy
- Numpy is required in more than 10 jobs and has a higher average salary as it is in-demand for higher paying roles such as Data Engineers, along with: kubernetes, and kafka.
- The highest average salaried skills for Data scientists are GO, bigquery, and C
- as for data analysts: the highest salaried skill is: hadoop, go, AWS, azure, and snowflake.
*/