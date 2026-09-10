USE ecommerce_analytics;



-- 1. Total records

SELECT
    COUNT(*) AS total_records
FROM shopper_sessions;


-- 2. Check NULL values

SELECT
    SUM(administrative IS NULL) AS administrative_nulls,
    SUM(administrative_duration IS NULL) AS administrative_duration_nulls,
    SUM(informational IS NULL) AS informational_nulls,
    SUM(informational_duration IS NULL) AS informational_duration_nulls,
    SUM(product_related IS NULL) AS product_related_nulls,
    SUM(product_related_duration IS NULL) AS product_related_duration_nulls,
    SUM(bounce_rates IS NULL) AS bounce_rate_nulls,
    SUM(exit_rates IS NULL) AS exit_rate_nulls,
    SUM(page_values IS NULL) AS page_value_nulls,
    SUM(visitor_type IS NULL) AS visitor_type_nulls,
    SUM(revenue IS NULL) AS revenue_nulls
FROM shopper_sessions;


-- 3. Visitor type validation

SELECT
    visitor_type,
    COUNT(*) AS count
FROM shopper_sessions
GROUP BY visitor_type;


-- 4. Revenue validation

SELECT
    revenue,
    COUNT(*) AS count
FROM shopper_sessions
GROUP BY revenue;


-- 5. Check negative values

SELECT
    COUNT(*) AS negative_values
FROM shopper_sessions
WHERE administrative < 0
   OR administrative_duration < 0
   OR informational < 0
   OR informational_duration < 0
   OR product_related < 0
   OR product_related_duration < 0
   OR bounce_rates < 0
   OR exit_rates < 0
   OR page_values < 0;


-- 6. Check duplicate behavioral records

SELECT
    administrative,
    product_related,
    visitor_type,
    revenue,
    COUNT(*) AS occurrences
FROM shopper_sessions
GROUP BY
    administrative,
    product_related,
    visitor_type,
    revenue
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;