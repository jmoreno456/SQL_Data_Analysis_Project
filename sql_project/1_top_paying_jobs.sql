/*
Question 1: What are the top-paying roles for Data Analysts, Data Scientists, Data Engineers?

Goal:
- Identify the highest-paying remote jobs for:
1. Data Analysts
2. Data Scientists
3. Data Engineers
- Focus on jobs in the United States.
- Exclude jobs without salary information.
- Compare the highest-paying opportunities across each role.
*/
WITH
    top_paying_jobs AS (
        SELECT
            j.job_id,
            j.job_title,
            j.job_title_short,
            c.name AS company_name,
            j.job_location,
            j.salary_year_avg,
            j.job_schedule_type,
            j.job_posted_date,
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
    job_id,
    job_title_short,
    job_title,
    company_name,
    job_location,
    salary_year_avg,
    job_schedule_type,
    job_posted_date,
    salary_rank
FROM
    top_paying_jobs
WHERE
    salary_rank <= 10
ORDER BY
    job_title_short DESC,
    salary_year_avg DESC;

/*
Observation:
- Data Analysts roles range from $170k - $337k
- Data Engineering roles range from $242k - $325k
- Data Scientist roles range from $280k - $550k
- Data Scientists and Data Engineering roles have higher end salaries as compared to Data Analysts 
- Data Scientists being the highest paid job title for these remote roles in the United States.

*/