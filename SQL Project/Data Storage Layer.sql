CREATE TABLE dim_device (
  device_id INT PRIMARY KEY,
  device_model VARCHAR(100)
);

CREATE TABLE dim_location (
  location_id INT PRIMARY KEY IDENTITY(1,1),
  country VARCHAR(100),
  city VARCHAR(100)
);

CREATE TABLE dim_channel (
  channel_id INT PRIMARY KEY IDENTITY(1,1),
  channel_name VARCHAR(100)
);

CREATE TABLE dim_return_reason (
  reason_id INT PRIMARY KEY IDENTITY(1,1),
  return_reason VARCHAR(255)
);

CREATE TABLE dim_resolution (
  resolution_id INT PRIMARY KEY IDENTITY(1,1),
  resolution VARCHAR(255)
);

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

CREATE TABLE fact_sales (
  sale_id INT PRIMARY KEY,
  device_id INT,
  location_id INT,
  channel_id INT,
  sale_date_id INT,
  quantity INT,
  price_usd FLOAT,
  total_revenue FLOAT,
  FOREIGN KEY (device_id) REFERENCES dim_device(device_id),
  FOREIGN KEY (location_id) REFERENCES dim_location(location_id),
  FOREIGN KEY (channel_id) REFERENCES dim_channel(channel_id),
  FOREIGN KEY (sale_date_id) REFERENCES dim_date(date_id)
);

CREATE TABLE fact_activations (
  activation_id INT PRIMARY KEY,
  device_id INT,
  location_id INT,
  activation_date_id INT,
  FOREIGN KEY (device_id) REFERENCES dim_device(device_id),
  FOREIGN KEY (location_id) REFERENCES dim_location(location_id),
  FOREIGN KEY (activation_date_id) REFERENCES dim_date(date_id)
);

CREATE TABLE fact_returns (
  return_id INT PRIMARY KEY,
  device_id INT,
  location_id INT,
  return_date_id INT,
  reason_id INT,
  resolution_id INT,
  FOREIGN KEY (device_id) REFERENCES dim_device(device_id),
  FOREIGN KEY (location_id) REFERENCES dim_location(location_id),
  FOREIGN KEY (return_date_id) REFERENCES dim_date(date_id),
  FOREIGN KEY (reason_id) REFERENCES dim_return_reason(reason_id),
  FOREIGN KEY (resolution_id) REFERENCES dim_resolution(resolution_id)
);
