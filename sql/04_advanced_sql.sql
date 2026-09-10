USE ecommerce_analytics;

WITH visitor_summary AS (
    SELECT
        visitor_type,
        COUNT(*) AS total_sessions,
        SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END) AS purchases
    FROM shopper_sessions
    GROUP BY visitor_type
)

SELECT
    visitor_type,
    total_sessions,
    purchases,
    ROUND(100.0 * purchases / total_sessions, 2) AS conversion_rate
FROM visitor_summary
ORDER BY conversion_rate DESC;