CREATE TABLE stg_sales AS
SELECT
  sale_id,
  device_id,
  DATE(sale_timestamp) AS sale_date,
  TRIM(device_model) AS device_model,
  TRIM(country) AS country,
  TRIM(channel) AS channel,
  CAST(TRIM(quantity) AS INT) AS quantity,
  CAST(TRIM(price_usd) AS FLOAT) AS price_usd,
  CAST(TRIM(quantity) AS INT) * CAST(TRIM(price_usd) AS FLOAT) AS total_revenue
FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY sale_id ORDER BY sale_timestamp) AS rn
  FROM sales
) dedup
WHERE rn = 1
  AND CAST(TRIM(quantity) AS INT) > 0
  AND CAST(TRIM(price_usd) AS FLOAT) > 0;

CREATE TABLE stg_device_activations AS
SELECT
  activation_id,
  CAST(device_id AS INT) AS device_id,
  DATE(activation_timestamp) AS activation_date,
  TRIM(model) AS device_model,
  TRIM(country) AS country,
  TRIM(city) AS city
FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY activation_id ORDER BY activation_timestamp) AS rn
  FROM device_activations
) dedup
WHERE rn = 1;

CREATE TABLE stg_returns AS
SELECT
  return_id,
  device_id,
  DATE(return_timestamp) AS return_date,
  TRIM(return_reason) AS return_reason,
  TRIM(resolution) AS resolution,
  TRIM(country) AS country,
  TRIM(city) AS city
FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY return_id ORDER BY return_timestamp) AS rn
  FROM returns
) dedup
WHERE rn = 1;
