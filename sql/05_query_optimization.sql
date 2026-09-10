USE ecommerce_analytics;

-- 1. BASELINE QUERY

EXPLAIN
SELECT
    session_id,
    visitor_type,
    product_related,
    page_values,
    revenue
FROM shopper_sessions
WHERE visitor_type = 'Returning_Visitor'
  AND revenue = TRUE
ORDER BY page_values DESC;


-- Composite index for visitor type + revenue

CREATE INDEX IF NOT EXISTS idx_visitor_revenue
ON shopper_sessions(visitor_type, revenue);


-- 3. CHECK QUERY PLAN AFTER INDEX

EXPLAIN
SELECT
    session_id,
    visitor_type,
    product_related,
    page_values,
    revenue
FROM shopper_sessions
WHERE visitor_type = 'Returning_Visitor'
  AND revenue = TRUE
ORDER BY page_values DESC;


-- 4. BUSINESS QUERY USING THE INDEX
-- Find purchasing returning visitors

SELECT
    session_id,
    visitor_type,
    product_related,
    page_values,
    revenue
FROM shopper_sessions
WHERE visitor_type = 'Returning_Visitor'
  AND revenue = TRUE
ORDER BY page_values DESC
LIMIT 10;


-- 5. PRODUCT ENGAGEMENT ANALYSIS

SELECT
    CASE
        WHEN product_related < 5 THEN 'Low Engagement'
        WHEN product_related BETWEEN 5 AND 20 THEN 'Medium Engagement'
        ELSE 'High Engagement'
    END AS engagement_level,
    COUNT(*) AS sessions,
    SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END) AS purchases,
    ROUND(
        100.0 * SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS conversion_rate
FROM shopper_sessions
GROUP BY engagement_level
ORDER BY conversion_rate DESC;


-- 6. HIGH-VALUE SHOPPING SESSIONS

SELECT
    session_id,
    visitor_type,
    product_related,
    product_related_duration,
    page_values,
    bounce_rates,
    exit_rates,
    revenue
FROM shopper_sessions
WHERE page_values > 0
  AND product_related >= 20
ORDER BY page_values DESC
LIMIT 20;


-- 7. TRAFFIC SOURCE PERFORMANCE

SELECT
    traffic_type,
    COUNT(*) AS sessions,
    SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END) AS purchases,
    ROUND(
        100.0 * SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS conversion_rate
FROM shopper_sessions
GROUP BY traffic_type
ORDER BY conversion_rate DESC;


-- 8. MONTH + VISITOR TYPE ANALYSIS

SELECT
    month,
    visitor_type,
    COUNT(*) AS sessions,
    SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END) AS purchases,
    ROUND(
        100.0 * SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS conversion_rate
FROM shopper_sessions
GROUP BY month, visitor_type
ORDER BY month, conversion_rate DESC;


-- 9. INDEX INFORMATION

SHOW INDEX FROM shopper_sessions;