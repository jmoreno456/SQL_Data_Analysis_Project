/*
Question 5: What are the most optimal skills to learn?

Goal:
- Identify skills in high demand and associated with high average salaries for Data analyst, Data scientists, and Data engineering roles
- focus on remote jobs in the united states
- focus on job postings with a specified salary

Why?
- target skills that offer job security and financial benefits
- offer insights into career development in any of these dat roles
*/
SELECT
    sd.skills,
    COUNT(DISTINCT j.job_id) AS demand_count,
    ROUND(AVG(j.salary_year_avg)) AS avg_salary
FROM
    job_postings_fact AS j
    INNER JOIN skills_job_dim AS sjd ON j.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    j.job_title_short IN ('Data Analyst', 'Data Engineer', 'Data Scientist')
    AND j.job_country = 'United States'
    AND j.job_location = 'Anywhere'
    AND j.salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
HAVING
    COUNT(DISTINCT j.job_id) >= 10
ORDER BY
    demand_count DESC,
    avg_salary DESC;

/*
Observation:
- After retrieving the results: SQL, Python, AWS, Tableau, Azure, Power BI, Excel, and snowflake are the most optimal skills
- This means that all these tools are associated with a high demand count and a high salary
- This provides insight in helping with career development
- These tools are useful and are highly recommended to be learned
*/