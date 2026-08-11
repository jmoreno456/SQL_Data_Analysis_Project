/*
Question 2: What skills are required for these top paying positions?

Goal:
- Identify which skills are required for the highest paying Data Analyst, Data Scientist, Data Engineer positons
- Focus on remote jobs in the United states
- Compare the skills associated with the top paying roles

Why?
- provides insight into which high-paying jobs demand certain skills.
- helps job seekers know which skills to develop
*/
WITH
    skills_required AS (
        SELECT
            j.job_id,
            j.job_title_short,
            j.job_title,
            j.salary_year_avg,
            c.name AS company_name,
            ROW_NUMBER() OVER (
                PARTITION BY
                    j.job_title_short
                ORDER BY
                    j.salary_year_avg DESC
            ) AS salary_rank
        FROM
            job_postings_fact AS j
            INNER JOIN company_dim AS c ON j.company_id = c.company_id
        WHERE
            j.job_title_short IN ('Data Analyst', 'Data Scientist', 'Data Engineer')
            AND j.job_country = 'United States'
            AND j.job_location = 'Anywhere'
            AND j.salary_year_avg IS NOT NULL
    )
SELECT
    sr.job_title_short,
    sr.job_title,
    ROUND(sr.salary_year_avg) AS avg_salary,
    sr.company_name,
    sd.skills
FROM
    skills_required AS sr
    INNER JOIN skills_job_dim AS sjd ON sr.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    sr.salary_rank < 5
ORDER BY
    sr.job_title_short,
    avg_salary DESC;

/*
Observation:
- Data analysts roles have a wide spread of tools and skills used such as SQL, Tableau, Python, PowerBI, Databricks, Azure
- Data Engineer roles also had. wide range of tools and skills such as SQL, Python, Spark, Kubernetes, Kafka
- Data Scientist roles showed the same: SQL, Tableau, hadoop, java, spark
- After gathering all the information, it seems that all roles have in common: SQL, Python, visualization tools, cloud platforms, and database technologies
*/