CREATE TABLE dim_date (
  date_id INT PRIMARY KEY,              
  full_date DATE,
  year INT,
  month INT,
  month_name VARCHAR(10),
  day INT,
  weekday_name VARCHAR(10),
  quarter INT,
  is_weekend INT                        
);

WITH date_sequence AS (
  SELECT CAST('2025-09-01' AS DATE) AS full_date
  UNION ALL
  SELECT DATEADD(DAY, 1, full_date)
  FROM date_sequence
  WHERE full_date < '2027-08-31'
)
INSERT INTO dim_date
SELECT
  YEAR(full_date) * 10000 + MONTH(full_date) * 100 + DAY(full_date) AS date_id,
  full_date,
  YEAR(full_date) AS year,
  MONTH(full_date) AS month,
  FORMAT(full_date, 'MMM') AS month_name,
  DAY(full_date) AS day,
  FORMAT(full_date, 'ddd') AS weekday_name,
  DATEPART(QUARTER, full_date) AS quarter,
  CASE WHEN DATEPART(WEEKDAY, full_date) IN (1, 7) THEN 1 ELSE 0 END AS is_weekend
FROM date_sequence
OPTION (MAXRECURSION 730);
