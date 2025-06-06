CREATE TABLE transactions (
id INT PRIMARY KEY,
user_id INT,
created_at DATETIME,
shipping_address VARCHAR(255)
);

-- Transactions sample data
INSERT INTO transactions (id, user_id, created_at, shipping_address) VALUES
(1, 1, '2025-01-15 10:30:00', '123 Main St'), 
(2, 1, '2025-01-16 11:45:00', '789 Oak Ave'), 
(3, 2, '2025-01-17 14:20:00', '456 Elm St'), 
(4, 2, '2025-01-18 15:10:00', '123 Pine Rd'), 
(5, 3, '2025-01-19 16:05:00', '789 Oak Ave'), 
(6, 3, '2025-01-20 17:40:00', '123 Main St'),
(7, 3, '2025-01-21 17:45:00', '123 Main St');

CREATE TABLE users (
id INT PRIMARY KEY,
name VARCHAR(255),
address VARCHAR(255)
);

-- Users sample data
INSERT INTO users (id, name, address) VALUES
(1, 'John Doe', '123 Main St'),
(2, 'Jane Smith', '456 Elm St'),
(3, 'Alice Johnson', '789 Oak Ave');

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema

SELECT 
    ROUND(100.0 * SUM(CASE WHEN t.shipping_address = u.address THEN 1 ELSE 0 END) 
          / COUNT(*), 2) AS home_address_percent
FROM transactions t
JOIN users u ON t.user_id = u.id

