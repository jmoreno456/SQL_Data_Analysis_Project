/*
Question 3: What are the most in-demand skills for these roles?

Goal:
- Focus on in-demand skills for data analysts, data scientists, and data engineers
- focus on all job postings
- focus on remote roles in the united states

Why?
- Retrieves the top skills with the highest demand in the job market
- providing insights for the most in-demand skills for job seekers
*/
SELECT
    sd.skills,
    COUNT(sjd.job_id) AS demand_count
FROM
    job_postings_fact AS j
    INNER JOIN skills_job_dim AS sjd ON j.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    j.job_title_short IN ('Data Analyst', 'Data Engineer', 'Data Scientist')
    AND j.job_country = 'United States'
    AND j.job_location = 'Anywhere'
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC;

/*
Observation:
- After looking at the results, I have noticed that the most in-demand skill is SQL
- Python is a close second to SQL as most in-demand skill
- Cloud platforms such as AWS, AZURE are also in demand with AWS being the third highest among these skills
- Visualization tools such as Tableau is the 5th most in-demand skill across these roles
*/