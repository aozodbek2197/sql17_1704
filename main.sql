-- 1-mashq
WITH ranked AS (
    SELECT 
        username,
        activity,
        startDate,
        endDate,
        ROW_NUMBER() OVER (PARTITION BY username ORDER BY startDate DESC) AS rn,
        COUNT(*) OVER (PARTITION BY username) AS total
    FROM user_activity
)
SELECT username, activity, startDate, endDate
FROM ranked
WHERE rn = 2 OR (rn = 1 AND total = 1);
-- 2-mashq
WITH RECURSIVE numbers AS (
    SELECT 2 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 1000
),
primes AS (
    SELECT n FROM numbers n1
    WHERE NOT EXISTS (
        SELECT 1 FROM numbers n2 
        WHERE n2.n > 1 AND n2.n < n1.n AND n1.n % n2.n = 0
    )
)
SELECT GROUP_CONCAT(n SEPARATOR '&') AS primes
FROM primes;
