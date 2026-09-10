CREATE DATABASE ecommerce_analytics;

USE ecommerce_analytics;

CREATE TABLE shopper_sessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY,

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
    weekend BOOLEAN,
    revenue BOOLEAN
);