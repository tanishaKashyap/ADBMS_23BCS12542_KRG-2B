------------------------------------MEDIUM PROBLEM-------------------------------------
Create table TRANSACTION_DATA(id int,val decimal);
INSERT INTO TRANSACTION_DATA(ID,VAL)
SELECT 1,RANDOM()
FROM GENERATE_SERIES(1,1000000);

INSERT INTO TRANSACTION_DATA(ID,VAL)
SELECT 2,RANDOM()
FROM GENERATE_SERIES(1,1000000);
SELECT * FROM TRANSACTION_DATA;

CREATE or REPLACE VIEW SALES_SUMMARY AS
SELECT 
ID,
COUNT(*) AS total_quantity_sold,
sum(val) AS total_sales,
count(distinct id) AS total_orders
FROM TRANSACTION_DATA
GROUP BY ID;

EXPLAIN ANALYZE
SELECT * FROM SALES_SUMMARY;
CREATE MATERIALIZED VIEW SALES_SUMM_MV AS
SELECT 
ID,
COUNT(*) AS total_quantity_sold,
sum(val) AS total_sales,
count(distinct id) AS total_orders
FROM TRANSACTION_DATA
GROUP BY ID;

EXPLAIN ANALYZE
SELECT * FROM SALES_SUMM_MV;

------------------------------------HARD PROBLEM-------------------------------------
CREATE TABLE customer_data (
    transaction_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    payment_info VARCHAR(50), 
    order_value DECIMAL,
    order_date DATE DEFAULT CURRENT_DATE
);

-- Insert sample data
INSERT INTO customer_data (customer_name, email, phone, payment_info, order_value)
VALUES
('Tanisha Kumari', 'tanisha.pankajj@gmail.com', '987654321', '1234-5678-9012-3456', 500),
('Tanisha Kumari', 'tanisha.pankajj@gmail.com', '987654321', '1234-5678-9012-3456', 1000),
('Tarun Kumar', 'tarun3008@gmail.com', '123456789', '9876-5432-1098-7654', 700),
('Tarun Kumar', 'tarun3008@gmail.com', '123456789', '9876-5432-1098-7654', 300);

-- Create restricted view for reporting
CREATE OR REPLACE VIEW RESTRICTED_SALES_DATA AS
SELECT
    customer_name,
    COUNT(*) AS total_orders,
    SUM(order_value) AS total_sales
FROM customer_data
GROUP BY customer_name;

SELECT * FROM RESTRICTED_SALES_DATA;

-- Create a reporting user
CREATE USER CLIENT1 WITH PASSWORD 'REPORT1234';

-- Grant access to restricted view
GRANT SELECT ON RESTRICTED_SALES_DATA TO CLIENT1;

-- Revoke access (if needed)
REVOKE SELECT ON RESTRICTED_SALES_DATA FROM CLIENT1;
