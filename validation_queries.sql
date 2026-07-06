-- 1. Total Records
SELECT COUNT(*) FROM validation_data;

-- 2. Closed Cases
SELECT COUNT(*) FROM validation_data
WHERE status='Closed';

-- 3. Open Cases
SELECT COUNT(*) FROM validation_data
WHERE status='Open';

-- 4. Department-wise Cases
SELECT department, COUNT(*)
FROM validation_data
GROUP BY department;

-- 5. Priority-wise Cases
SELECT priority, COUNT(*)
FROM validation_data
GROUP BY priority;

-- 6. Error Type Count
SELECT error_type, COUNT(*)
FROM validation_data
GROUP BY error_type
ORDER BY COUNT(*) DESC;

-- 7. Missing Salary
SELECT *
FROM validation_data
WHERE salary IS NULL;

-- 8. Missing City
SELECT *
FROM validation_data
WHERE city IS NULL;

-- 9. Missing Email
SELECT *
FROM validation_data
WHERE email IS NULL;

-- 10. Invalid Email
SELECT *
FROM validation_data
WHERE email NOT LIKE '%@%.%';

-- 11. Invalid Phone
SELECT *
FROM validation_data
WHERE LENGTH(phone)<>10;

-- 12. Duplicate Account Numbers
SELECT account_no,COUNT(*)
FROM validation_data
GROUP BY account_no
HAVING COUNT(*)>1;

-- 13. Duplicate Employee IDs
SELECT employee_id,COUNT(*)
FROM validation_data
GROUP BY employee_id
HAVING COUNT(*)>1;

-- 14. Average Salary
SELECT AVG(salary)
FROM validation_data;

-- 15. Maximum Salary
SELECT MAX(salary)
FROM validation_data;

-- 16. Minimum Salary
SELECT MIN(salary)
FROM validation_data;

-- 17. Department-wise Average Salary
SELECT department,
AVG(salary)
FROM validation_data
GROUP BY department;

-- 18. Top 10 Highest Salaries
SELECT *
FROM validation_data
ORDER BY salary DESC
LIMIT 10;

-- 19. City-wise Cases
SELECT city,
COUNT(*)
FROM validation_data
GROUP BY city;

-- 20. Cases Opened by Month
SELECT EXTRACT(MONTH FROM open_date),
COUNT(*)
FROM validation_data
GROUP BY EXTRACT(MONTH FROM open_date);

-- 21. Cases Closed by Month
SELECT EXTRACT(MONTH FROM close_date),
COUNT(*)
FROM validation_data
GROUP BY EXTRACT(MONTH FROM close_date);

-- 22. Closed Cases by Department
SELECT department,
COUNT(*)
FROM validation_data
WHERE status='Closed'
GROUP BY department;

-- 23. High Priority Cases
SELECT *
FROM validation_data
WHERE priority='High';

-- 24. High Priority Closed Cases
SELECT *
FROM validation_data
WHERE priority='High'
AND status='Closed';

-- 25. Hyderabad Records
SELECT *
FROM validation_data
WHERE city='Hyderabad';

-- 26. Standardize City
UPDATE validation_data
SET city='Hyderabad'
WHERE city='Hyd';

-- 27. Remove Extra Spaces
UPDATE validation_data
SET customer_name=TRIM(customer_name);

-- 28. Replace Missing Salary
UPDATE validation_data
SET salary=45000
WHERE salary IS NULL;

-- 29. Delete Duplicate Records
DELETE FROM validation_data
WHERE case_id IN (
SELECT case_id
FROM(
SELECT case_id,
ROW_NUMBER() OVER(PARTITION BY account_no ORDER BY case_id) rn
FROM validation_data
)t
WHERE rn>1
);

-- 30. Final Validation Report
SELECT department,
COUNT(*) total_cases,
AVG(salary) avg_salary
FROM validation_data
GROUP BY department
ORDER BY total_cases DESC;