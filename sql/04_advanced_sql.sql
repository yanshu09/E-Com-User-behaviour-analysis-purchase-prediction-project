USE ecommerce_analytics;

-- 1. Conversion Analysis using CTE

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


-- 2. Rank Visitor Types using Window Function

WITH visitor_summary AS (
    SELECT
        visitor_type,
        COUNT(*) AS total_sessions,
        SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END) AS purchases
    FROM shopper_sessions
    GROUP BY visitor_type
),

conversion_data AS (
    SELECT
        visitor_type,
        total_sessions,
        purchases,
        ROUND(100.0 * purchases / total_sessions, 2) AS conversion_rate
    FROM visitor_summary
)

SELECT
    visitor_type,
    total_sessions,
    purchases,
    conversion_rate,
    RANK() OVER (ORDER BY conversion_rate DESC) AS conversion_rank
FROM conversion_data
ORDER BY conversion_rank;


-- 3. JOIN Visitor Type with Visitor Segment Information

DROP TABLE IF EXISTS visitor_type_dim;

CREATE TABLE visitor_type_dim (
    visitor_type VARCHAR(50) PRIMARY KEY,
    visitor_segment VARCHAR(50)
);

INSERT INTO visitor_type_dim (visitor_type, visitor_segment)
VALUES
    ('New_Visitor', 'New Customer'),
    ('Returning_Visitor', 'Returning Customer'),
    ('Other', 'Other');

SELECT
    s.visitor_type,
    v.visitor_segment,
    COUNT(*) AS total_sessions,
    SUM(CASE WHEN s.revenue = TRUE THEN 1 ELSE 0 END) AS purchases,
    ROUND(
        100.0 * SUM(CASE WHEN s.revenue = TRUE THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS conversion_rate
FROM shopper_sessions s
JOIN visitor_type_dim v
    ON s.visitor_type = v.visitor_type
GROUP BY
    s.visitor_type,
    v.visitor_segment
ORDER BY conversion_rate DESC;