CREATE TABLE likes (
user_id VARCHAR(50),
created_at DATETIME,
liker_id VARCHAR(50)
);

INSERT INTO likes (user_id, created_at, liker_id) VALUES
('A', '2024-01-01 10:00:00', 'B'),
('B', '2024-01-01 11:00:00', 'C'),
('B', '2024-01-01 12:00:00', 'D'),
('B', '2024-01-01 13:00:00', 'E'),
('C', '2024-01-02 10:00:00', 'A'),
('D', '2024-01-02 14:00:00', 'E'),
('E', '2024-01-02 15:00:00', 'F'),
('B', '2024-01-03 09:00:00', 'G'),
('H', '2024-01-03 10:00:00', 'A'),
('B', '2024-01-03 11:00:00', 'C'),
('I', '2024-01-03 12:00:00', 'I');

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema


select l1.liker_id as user,
       count(distinct l2.liker_id) as count
from likes l1
join likes l2 on l1.liker_id = l2.user_id
group by l1.liker_id
