CREATE TABLE transactions (
id INTEGER PRIMARY KEY,
user_id INTEGER,
created_at DATETIME,
product_id INTEGER,
quantity INTEGER
);

INSERT INTO transactions (id, user_id, created_at, product_id, quantity) VALUES
(1, 101, '2024-01-01 10:00:00', 1, 1),  
(2, 101, '2024-01-01 14:00:00', 2, 1),
(3, 101, '2024-01-15 09:00:00', 3, 1), 
(4, 102, '2024-01-05 11:00:00', 1, 2),
(5, 102, '2024-01-05 11:30:00', 2, 1),
(6, 103, '2024-01-02 15:00:00', 1, 1),
(7, 104, '2024-01-01 09:00:00', 1, 1),
(8, 104, '2024-01-02 10:00:00', 2, 1),
(9, 104, '2024-01-03 11:00:00', 3, 1);

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema

with upsold_customer as (
select count(distinct user_id) as upsold_customer_count
from transactions
group by user_id 
having count(distinct date(created_at)) > 1
)
select count(upsold_customer_count) as upsold_customer_count
from upsold_customer


