CREATE TABLE users (
id INTEGER PRIMARY KEY,
name VARCHAR(100),
birthdate DATETIME
);

INSERT INTO users (id, name, birthdate) VALUES
(1, 'Alice', '1995-05-15'),
(2, 'Bob', '1985-03-20'),
(3, 'Charlie', '2005-07-10'),
(4, 'David', '1955-11-30'),
(5, 'Eve', '2015-09-25'),
(6, 'Frank', '1935-02-14'),
(7, 'Grace', '1975-12-01');

CREATE TABLE search_events (
search_id INTEGER PRIMARY KEY,
query VARCHAR(255),
has_clicked BOOLEAN,
user_id INTEGER,
search_time DATETIME,
FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO search_events (search_id, query, has_clicked, user_id, search_time) VALUES

(1, 'travel', TRUE, 1, '2021-03-15 10:00:00'),
(2, 'books', FALSE, 1, '2021-03-15 11:00:00'),
(3, 'cars', TRUE, 2, '2021-05-20 14:30:00'),
(4, 'tech', TRUE, 2, '2021-05-20 15:00:00'),
(5, 'games', FALSE, 3, '2021-07-10 16:45:00'),
(6, 'music', FALSE, 3, '2021-07-10 17:00:00'),
(7, 'retirement', TRUE, 4, '2021-09-05 09:15:00'),
(8, 'health', FALSE, 4, '2021-09-05 10:00:00'),
(9, 'toys', FALSE, 5, '2021-11-25 13:20:00'),
(10, 'genealogy', TRUE, 6, '2021-12-01 11:30:00'),
(11, 'history', TRUE, 6, '2021-12-01 12:00:00'),
(12, 'finance', TRUE, 7, '2021-02-15 08:45:00'),
(13, 'investing', FALSE, 7, '2021-02-15 09:00:00');

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema


WITH filtered_events AS (
  SELECT 
    u.id AS user_id,
    se.has_clicked,
    se.search_time,
    CAST((strftime('%Y', se.search_time) - strftime('%Y', u.birthdate)) -
         (strftime('%m-%d', se.search_time) < strftime('%m-%d', u.birthdate)) AS INTEGER) AS age
  FROM search_events se
  JOIN users u ON se.user_id = u.id
  WHERE strftime('%Y', se.search_time) = '2021'
),
bucketed AS (
  SELECT 
    CASE 
      WHEN age BETWEEN 0 AND 99 THEN 
        printf('[%d-%d]', (age / 10) * 10, (age / 10) * 10 + 9)
      ELSE '[100+]' 
    END AS age_group,
    has_clicked
  FROM filtered_events
),
ctr_stats AS (
  SELECT 
    age_group,
    COUNT(*) AS total,
    SUM(CASE WHEN has_clicked THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS ctr
  FROM bucketed
  GROUP BY age_group
)
SELECT 
  age_group,
  ctr
FROM ctr_stats
ORDER BY ctr DESC, CAST(SUBSTR(age_group, 2, INSTR(age_group, '-') - 2) AS INTEGER) DESC
LIMIT 3

