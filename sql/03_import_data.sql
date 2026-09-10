USE ecommerce_analytics;

-- Temporary staging table for CSV import
DROP TABLE IF EXISTS shopper_sessions_raw;

CREATE TABLE shopper_sessions_raw (
    administrative INT,
    administrative_duration DECIMAL(10,2),
    informational INT,
    informational_duration DECIMAL(10,2),
    product_related INT,
    product_related_duration DECIMAL(10,2),
    bounce_rates DECIMAL(10,6),
    exit_rates DECIMAL(10,6),
    page_values DECIMAL(10,6),
    special_day DECIMAL(10,6),
    month VARCHAR(20),
    operating_systems INT,
    browser INT,
    region INT,
    traffic_type INT,
    visitor_type VARCHAR(50),
    weekend VARCHAR(10),
    revenue VARCHAR(10)
);

-- Import CSV
LOAD DATA LOCAL INFILE 'online_shoppers_intention.csv'
INTO TABLE shopper_sessions_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Move cleaned data into final table
INSERT INTO shopper_sessions (
    administrative,
    administrative_duration,
    informational,
    informational_duration,
    product_related,
    product_related_duration,
    bounce_rates,
    exit_rates,
    page_values,
    special_day,
    month,
    operating_systems,
    browser,
    region,
    traffic_type,
    visitor_type,
    weekend,
    revenue
)
SELECT
    administrative,
    administrative_duration,
    informational,
    informational_duration,
    product_related,
    product_related_duration,
    bounce_rates,
    exit_rates,
    page_values,
    special_day,
    month,
    operating_systems,
    browser,
    region,
    traffic_type,
    visitor_type,
    CASE WHEN weekend = 'TRUE' THEN TRUE ELSE FALSE END,
    CASE WHEN revenue = 'TRUE' THEN TRUE ELSE FALSE END
FROM shopper_sessions_raw;

-- Verify imported data
SELECT COUNT(*) AS total_rows
FROM shopper_sessions;

-- Check purchase count
SELECT
    revenue,
    COUNT(*) AS count
FROM shopper_sessions
GROUP BY revenue;