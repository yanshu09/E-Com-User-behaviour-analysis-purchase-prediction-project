USE ecommerce_analytics;

-- 1. Overall conversion rate

SELECT
    COUNT(*) AS total_sessions,
    SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END) AS purchases,
    ROUND(
        100.0 * SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS conversion_rate
FROM shopper_sessions;

-- 2. Conversion by visitor type

SELECT
    visitor_type,
    COUNT(*) AS total_sessions,
    SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END) AS purchases,
    ROUND(
        100.0 * SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS conversion_rate
FROM shopper_sessions
GROUP BY visitor_type
ORDER BY conversion_rate DESC;

-- 3. Monthly conversion performance

SELECT
    month,
    COUNT(*) AS sessions,
    SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END) AS purchases,
    ROUND(
        100.0 * SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS conversion_rate
FROM shopper_sessions
GROUP BY month
ORDER BY conversion_rate DESC;

-- 4. Analyze conversion across bounce-rate segments

SELECT
    CASE
        WHEN bounce_rates < 0.05 THEN 'Low Bounce'
        WHEN bounce_rates < 0.10 THEN 'Medium Bounce'
        ELSE 'High Bounce'
    END AS bounce_segment,

    COUNT(*) AS total_sessions,

    SUM(
        CASE
            WHEN revenue = TRUE THEN 1
            ELSE 0
        END
    ) AS purchases,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN revenue = TRUE THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS conversion_rate

FROM shopper_sessions

GROUP BY bounce_segment

ORDER BY conversion_rate DESC;

-- 5. Analyze conversion based on product-page engagement

SELECT
    CASE
        WHEN product_related < 5 THEN 'Low Engagement'
        WHEN product_related BETWEEN 5 AND 20 THEN 'Medium Engagement'
        ELSE 'High Engagement'
    END AS engagement_level,

    COUNT(*) AS total_sessions,

    SUM(
        CASE
            WHEN revenue = TRUE THEN 1
            ELSE 0
        END
    ) AS purchases,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN revenue = TRUE THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS conversion_rate

FROM shopper_sessions

GROUP BY engagement_level

ORDER BY conversion_rate DESC;

-- 6. Compare weekend and weekday conversion

SELECT
    CASE
        WHEN weekend = TRUE THEN 'Weekend'
        ELSE 'Weekday'
    END AS shopping_day,

    COUNT(*) AS total_sessions,

    SUM(
        CASE
            WHEN revenue = TRUE THEN 1
            ELSE 0
        END
    ) AS purchases,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN revenue = TRUE THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS conversion_rate

FROM shopper_sessions

GROUP BY weekend

ORDER BY conversion_rate DESC;

-- 7. Compare user behavior by purchase outcome

SELECT
    CASE
        WHEN revenue = TRUE THEN 'Purchased'
        ELSE 'Did Not Purchase'
    END AS purchase_status,

    COUNT(*) AS total_sessions,

    ROUND(AVG(product_related), 2) AS avg_product_pages,

    ROUND(AVG(product_related_duration), 2) AS avg_product_time,

    ROUND(AVG(bounce_rates), 4) AS avg_bounce_rate,

    ROUND(AVG(exit_rates), 4) AS avg_exit_rate,

    ROUND(AVG(page_values), 2) AS avg_page_value

FROM shopper_sessions

GROUP BY revenue;

-- 8. Identify high-intent shopping sessions

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

WHERE product_related >= 20
  AND page_values > 0

ORDER BY page_values DESC;