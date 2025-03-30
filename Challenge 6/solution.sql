CREATE TABLE products (
product_id INT PRIMARY KEY,
price DECIMAL(10,2)
);

INSERT INTO products (product_id, price) VALUES
(1, 100.00),
(2, 150.00),
(3, 75.00),
(4, 200.00),
(5, 120.00);

CREATE TABLE transactions (
transaction_id INT PRIMARY KEY,
product_id INT,
amount DECIMAL(10,2),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO transactions (transaction_id, product_id, amount) VALUES
(1, 1, 95.00),
(2, 1, 98.00),
(3, 2, 145.00),
(4, 2, 150.00),
(5, 3, 70.00),
(6, 4, 190.00),
(7, 4, 195.00),
(8, 5, 115.00);

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema


WITH avg_price AS (
    SELECT AVG(amount) AS average_price
    FROM transactions
)
SELECT 
    p.product_id,
    p.price AS product_price,
    ROUND(a.average_price, 2) AS avg_transaction_price
FROM products p
INNER JOIN avg_price a ON p.price > a.average_price

